data "authentik_certificate_key_pair" "this" {
  name = var.client_cert_key_pair_name
}

locals {
  default_property_mappings = [
    "authentik default OAuth Mapping: OpenID 'email'",
    "authentik default OAuth Mapping: OpenID 'profile'",
    "authentik default OAuth Mapping: OpenID 'openid'"
  ]

  # handle null mapping list
  custom_mappings   = can(coalesce(var.property_mappings, null)) ? distinct(var.property_mappings) : []
  property_mappings = var.default_property_mappings_disabled ? local.custom_mappings : distinct(concat(local.default_property_mappings, local.custom_mappings))

  groups = can(coalesce(var.groups, null)) ? var.groups : {}
  users_groups = merge([
    for gname, group in local.groups : {
      for uname in group.initial_usernames : "${gname}_${uname}" => {
        group_name = gname
        user_name  = uname
      }
    }
  ]...)

  group_userids = {
    for group_name in distinct([for ug in local.users_groups : ug.group_name]) : group_name => [
      for key, ug in local.users_groups : data.authentik_user.users[key].id
      if ug.group_name == group_name
    ]
  }
}

resource "random_password" "authentik_client_secret" {
  length  = 128
  special = false
}

data "authentik_flow" "default_auth_implicit_flow" {
  slug = "default-provider-authorization-implicit-consent"
}

data "authentik_flow" "default_invalidation_flow" {
  slug = "default-provider-invalidation-flow"
}

data "authentik_property_mapping_provider_scope" "scopes" {
  count = length(local.property_mappings)

  name = local.property_mappings[count.index]
}

resource "authentik_provider_oauth2" "this" {
  name                  = "${var.app_name} Provider"
  client_id             = coalesce(var.client_id, uuid())
  client_secret         = random_password.authentik_client_secret.result
  signing_key           = data.authentik_certificate_key_pair.this.id
  authorization_flow    = data.authentik_flow.default_auth_implicit_flow.id
  invalidation_flow     = data.authentik_flow.default_invalidation_flow.id
  allowed_redirect_uris = var.redirect_urls
  property_mappings     = data.authentik_property_mapping_provider_scope.scopes[*].id
}

resource "authentik_application" "this" {
  name              = var.app_name
  slug              = var.app_slug
  protocol_provider = authentik_provider_oauth2.this.id
  meta_launch_url   = var.app_launch_url
  meta_icon         = var.app_icon
}

output "group_userids" {
  value = local.group_userids
}

data "authentik_user" "users" {
  for_each = local.users_groups
  username = each.value.user_name
}

resource "authentik_group" "app_groups" {
  for_each = local.groups
  name     = each.key
  users    = contains(keys(local.group_userids), each.key) ? local.group_userids[each.key] : null
  lifecycle {
    ignore_changes = [users]
  }
}

resource "authentik_policy_binding" "groups" {
  for_each = authentik_group.app_groups
  target   = authentik_application.this.uuid
  group    = each.value.id
  order    = var.groups[each.key].order
}