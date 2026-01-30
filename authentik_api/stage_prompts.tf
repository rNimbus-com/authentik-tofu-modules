data "http" "stage_prompts" {
  url             = "${var.authentik_provider_url}/api/v3/stages/prompt/prompts/?page_size=1000"
  request_headers = local.request_headers
}

locals {
  stage_prompts = jsondecode(data.http.stage_prompts.response_body).results
}

output "stage_prompts" {
  value = { for p in local.stage_prompts : p["name"] => p }
}