locals {
  request_headers = {
    Authorization = "Bearer ${var.authentik_token}"
    Accept        = "application/json"
  }
}

data "http" "email_templates" {
  url             = "${var.authentik_provider_url}/api/v3/stages/email/templates/"
  request_headers = local.request_headers
}
locals {
  email_templates = jsondecode(data.http.email_templates.response_body)
}
output "email_templates" {
  value = { for e in local.email_templates : e["description"] => e }
}