variable "authentik_provider_url" {
  type        = string
  description = "Url endpoint for authentik provider and API."
}

variable "authentik_token" {
  type        = string
  description = "Authentik Token with API Access"
  sensitive   = true
}