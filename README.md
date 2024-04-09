<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.77.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_afd"></a> [afd](#module\_afd) | .\module | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ips"></a> [allowed\_ips](#input\_allowed\_ips) | The list of IP addresses that are allowed to access the storage account. | `list(string)` | <pre>[<br>  "46.241.153.142"<br>]</pre> | no |
| <a name="input_custom-domain"></a> [custom-domain](#input\_custom-domain) | The custom domain to use for the CDN Front Door profile. | `string` | `"learnit.solutions"` | no |
| <a name="input_location"></a> [location](#input\_location) | value of Azure datacenter the location | `string` | `"north europe"` | no |
| <a name="input_location-prefix"></a> [location-prefix](#input\_location-prefix) | The location prefix to use for the resource group and CDN Front Door profile names. | `string` | `"neu"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the CDN Front Door profile. | `string` | `"frontdoortestag"` | no |
| <a name="input_storage-account-container-name"></a> [storage-account-container-name](#input\_storage-account-container-name) | The name of the storage account container. | `string` | `"home"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | <pre>{<br>  "createdBy": "agabrielyan",<br>  "environment": "test",<br>  "owner": "terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_customDomain"></a> [customDomain](#output\_customDomain) | n/a |
| <a name="output_front-door-uri"></a> [front-door-uri](#output\_front-door-uri) | n/a |
| <a name="output_storage_account_uri"></a> [storage\_account\_uri](#output\_storage\_account\_uri) | n/a |
<!-- END_TF_DOCS -->