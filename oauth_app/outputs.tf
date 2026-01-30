output "provider_name" {
  value       = authentik_provider_oauth2.this.name
  description = "Name of the oauth2 provider"
}
output "provider_id" {
  value       = authentik_provider_oauth2.this.id
  description = "ID of the oauth2 provider"
}
output "client_id" {
  value       = authentik_provider_oauth2.this.client_id
  description = "Application Client ID"
}
output "client_secret" {
  value       = random_password.authentik_client_secret.result
  description = "Application Client Secret"
  sensitive   = true
}
output "application_name" {
  value       = authentik_application.this.name
  description = "Name of the Authentik Application"
}
output "application_slug" {
  value       = authentik_application.this.slug
  description = "Slug for the Authentik Application"
}
output "application_uuid" {
  value       = authentik_application.this.uuid
  description = "Unique Identity of the Authentik Application"
}
output "group_ids" {
  value = { for name, group in authentik_group.app_groups : name => group.id }
}