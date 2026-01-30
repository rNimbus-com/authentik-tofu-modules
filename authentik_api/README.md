<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [http_http.email_templates](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.expression_policies](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.password_policies](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.stage_prompts](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authentik_provider_url"></a> [authentik\_provider\_url](#input\_authentik\_provider\_url) | Url endpoint for authentik provider and API. | `string` | n/a | yes |
| <a name="input_authentik_token"></a> [authentik\_token](#input\_authentik\_token) | Authentik Token with API Access | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_email_templates"></a> [email\_templates](#output\_email\_templates) | n/a |
| <a name="output_policies"></a> [policies](#output\_policies) | n/a |
| <a name="output_stage_prompts"></a> [stage\_prompts](#output\_stage\_prompts) | n/a |
<!-- END_TF_DOCS -->