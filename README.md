# Authentik Terraform Modules

This repository contains Terraform/OpenTofu modules for managing Authentik resources.

## Modules

### authentik_api

Module used to query an Authentik API. Useful for retrieving information for resources not present in the official Authentik Terraform provider.

**Features:**
- Retrieves email templates from the Authentik API
- Fetches password policies and expression policies
- Queries stage prompts

**Resources Retrieved:**
- Email templates (`/api/v3/stages/email/templates/`)
- Password policies (`/api/v3/policies/password/`)
- Expression policies (`/api/v3/policies/expression/`)
- Stage prompts (`/api/v3/stages/prompt/prompts/`)

**Inputs:**
- `authentik_provider_url` - URL endpoint for Authentik provider and API (required)
- `authentik_token` - Authentik Token with API Access (required, sensitive)

**Outputs:**
- `email_templates` - Map of email templates keyed by description
- `policies` - Map containing `password` and `expression` policy maps, keyed by name
- `stage_prompts` - Map of stage prompts keyed by name

**Usage Example:**
```hcl
module "authentik_api" {
  source = "./authentik_api"

  authentik_provider_url = "https://authentik.example.com"
  authentik_token         = var.authentik_token
}

output "password_policies" {
  value = module.authentik_api.policies.password
}
```

---

### oauth_app

Module for managing Authentik applications that use OAuth2. This module creates a complete OAuth2 application setup including the provider, application, and optional group management.

**Features:**
- Creates OAuth2 provider with automatic client secret generation
- Configures Authentik application with custom launch URL and icon
- Manages property mappings (default or custom)
- Creates and manages groups with policy bindings
- Supports initial user assignment to groups

**Requirements:**
- Terraform >= 1.6
- authentik provider >= 2025.10.0
- random provider >= 3.7

**Inputs:**
- `authentik_url` - URL endpoint for the Authentik API/provider (required)
- `client_cert_key_pair_name` - Name of the certificate key pair (required)
- `app_name` - The name of the Authentik application (required)
- `app_slug` - The "slug" for the application used in login URLs (required)
- `redirect_urls` - Allowed redirect URLs and their matching mode (required)
- `client_id` - The client_id value (optional, auto-generated if not provided)
- `app_launch_url` - URL to launch when user clicks the application (optional)
- `app_icon` - URL to the application's icon (optional)
- `default_property_mappings_disabled` - Disables default OpenID property mappings (default: false)
- `property_mappings` - Custom property mapping names to add (default: [])
- `groups` - Groups to create with optional initial users and order (optional)

**Outputs:**
- `provider_name` - Name of the OAuth2 provider
- `provider_id` - ID of the OAuth2 provider
- `client_id` - Application Client ID
- `client_secret` - Application Client Secret (sensitive)
- `application_name` - Name of the Authentik Application
- `application_slug` - Slug for the Authentik Application
- `application_uuid` - Unique Identity of the Authentik Application
- `group_ids` - Map of group names to IDs
- `group_userids` - Map of group names to user IDs

**Usage Example:**
```hcl
module "oauth_app" {
  source = "./oauth_app"

  authentik_url             = "https://authentik.example.com"
  client_cert_key_pair_name = "my-cert-pair"
  app_name                  = "My Application"
  app_slug                  = "my-app"
  
  redirect_urls = [
    {
      matching_mode = "strict"
      url           = "https://myapp.example.com/callback"
    }
  ]

  app_launch_url = "https://myapp.example.com"
  app_icon       = "fa://fa-apple"

  groups = {
    "admins" = {
      initial_usernames = ["admin1", "admin2"]
      order             = 10
    }
    "users" = {
      initial_usernames = ["user1"]
      order             = 20
    }
  }
}

output "client_credentials" {
  value = {
    id     = module.oauth_app.client_id
    secret = module.oauth_app.client_secret
  }
  sensitive = true
}
```

## License

See [LICENSE](LICENSE) file for details.
