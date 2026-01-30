data "http" "password_policies" {
  url             = "${var.authentik_provider_url}/api/v3/policies/password/?page_size=1000"
  request_headers = local.request_headers
}

data "http" "expression_policies" {
  url             = "${var.authentik_provider_url}/api/v3/policies/expression/?page_size=1000"
  request_headers = local.request_headers
}

locals {
  password_policies   = jsondecode(data.http.password_policies.response_body).results
  expression_policies = jsondecode(data.http.expression_policies.response_body).results
}

output "policies" {
  value = {
    password   = { for p in local.password_policies : p["name"] => p }
    expression = { for p in local.expression_policies : p["name"] => p }
  }
}