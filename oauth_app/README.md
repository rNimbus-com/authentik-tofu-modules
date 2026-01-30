<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_authentik"></a> [authentik](#requirement\_authentik) | >=2025.10.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_authentik"></a> [authentik](#provider\_authentik) | >=2025.10.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >=3.7 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [authentik_application.this](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/resources/application) | resource |
| [authentik_group.app_groups](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/resources/group) | resource |
| [authentik_policy_binding.groups](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/resources/policy_binding) | resource |
| [authentik_provider_oauth2.this](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/resources/provider_oauth2) | resource |
| [random_password.authentik_client_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [authentik_certificate_key_pair.this](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/data-sources/certificate_key_pair) | data source |
| [authentik_flow.default_auth_implicit_flow](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/data-sources/flow) | data source |
| [authentik_flow.default_invalidation_flow](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/data-sources/flow) | data source |
| [authentik_property_mapping_provider_scope.scopes](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/data-sources/property_mapping_provider_scope) | data source |
| [authentik_user.users](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_icon"></a> [app\_icon](#input\_app\_icon) | The url to the application's icon. A Font Awesome icon (fa://fa-icon-name) or URL (full or relative). | `string` | `null` | no |
| <a name="input_app_launch_url"></a> [app\_launch\_url](#input\_app\_launch\_url) | The url to launch when the user clicks on the authentik application. If left empty, authentik will try to extract the launch URL based on the selected provider. Has no impact on SSO. | `string` | `null` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | The name of the authentik application. | `string` | n/a | yes |
| <a name="input_app_slug"></a> [app\_slug](#input\_app\_slug) | The "slug" for the application used in login urls. No spaces. Valid url characters only. | `string` | n/a | yes |
| <a name="input_authentik_url"></a> [authentik\_url](#input\_authentik\_url) | Url endpoint for the authentik api/provider. | `string` | n/a | yes |
| <a name="input_client_cert_key_pair_name"></a> [client\_cert\_key\_pair\_name](#input\_client\_cert\_key\_pair\_name) | Name of the certificate key pair. | `string` | n/a | yes |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | The client\_id value to use for the oauth2 provider. If not provided, a random UUID will be generated instead. | `string` | `null` | no |
| <a name="input_default_property_mappings_disabled"></a> [default\_property\_mappings\_disabled](#input\_default\_property\_mappings\_disabled) | Disables default openid property mappings from being added to the application. | `bool` | `false` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | Groups to create and associate with the application and auth provider.<br/><br/>- initial\_usernames: Optional list of users to add to the group on creation. Changing this has no effect after the group has been created.<br/>- order: The order in which to process the groups during authentication. Defaults to zero. | <pre>map(object({<br/>    initial_usernames = optional(list(string), [])<br/>    order             = optional(number, 0)<br/><br/>  }))</pre> | `null` | no |
| <a name="input_property_mappings"></a> [property\_mappings](#input\_property\_mappings) | Property mapping names to configure the oauth2 provider to use. These are added to the default property mappings unless they have been disabled with the `default_property_mappings_disabled` setting. | `list(string)` | `[]` | no |
| <a name="input_redirect_urls"></a> [redirect\_urls](#input\_redirect\_urls) | Allowed redirect URLs and their matching mode. | <pre>list(object({<br/>    matching_mode = string<br/>    url           = string<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_name"></a> [application\_name](#output\_application\_name) | Name of the Authentik Application |
| <a name="output_application_slug"></a> [application\_slug](#output\_application\_slug) | Slug for the Authentik Application |
| <a name="output_application_uuid"></a> [application\_uuid](#output\_application\_uuid) | Unique Identity of the Authentik Application |
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | Application Client ID |
| <a name="output_client_secret"></a> [client\_secret](#output\_client\_secret) | Application Client Secret |
| <a name="output_group_ids"></a> [group\_ids](#output\_group\_ids) | n/a |
| <a name="output_group_userids"></a> [group\_userids](#output\_group\_userids) | n/a |
| <a name="output_provider_id"></a> [provider\_id](#output\_provider\_id) | ID of the oauth2 provider |
| <a name="output_provider_name"></a> [provider\_name](#output\_provider\_name) | Name of the oauth2 provider |
<!-- END_TF_DOCS -->