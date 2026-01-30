
variable "authentik_url" {
  type        = string
  description = "Url endpoint for the authentik api/provider."
}

# Certificate key pair variables
variable "client_cert_key_pair_name" {
  type        = string
  description = "Name of the certificate key pair."
}

variable "app_name" {
  type        = string
  description = "The name of the authentik application."
}

variable "app_slug" {
  type        = string
  description = "The \"slug\" for the application used in login urls. No spaces. Valid url characters only."
}

variable "client_id" {
  type        = string
  description = "The client_id value to use for the oauth2 provider. If not provided, a random UUID will be generated instead."
  default     = null
}

variable "app_launch_url" {
  type        = string
  description = "The url to launch when the user clicks on the authentik application. If left empty, authentik will try to extract the launch URL based on the selected provider. Has no impact on SSO."
  default     = null
}
variable "app_icon" {
  type        = string
  description = "The url to the application's icon. A Font Awesome icon (fa://fa-icon-name) or URL (full or relative)."
  default     = null
}

variable "redirect_urls" {
  description = "Allowed redirect URLs and their matching mode."
  type = list(object({
    matching_mode = string
    url           = string
  }))
}

variable "default_property_mappings_disabled" {
  type        = bool
  default     = false
  description = "Disables default openid property mappings from being added to the application."
}

variable "property_mappings" {
  type        = list(string)
  default     = []
  description = "Property mapping names to configure the oauth2 provider to use. These are added to the default property mappings unless they have been disabled with the `default_property_mappings_disabled` setting."
}

variable "groups" {
  type = map(object({
    initial_usernames = optional(list(string), [])
    order             = optional(number, 0)

  }))
  default     = null
  description = <<-EOD
    Groups to create and associate with the application and auth provider.

    - initial_usernames: Optional list of users to add to the group on creation. Changing this has no effect after the group has been created.
    - order: The order in which to process the groups during authentication. Defaults to zero.
  EOD
}