<!-- BEGIN_TF_DOCS -->
## Gerenal description

I successfully set up the architecture to securely serve content from a private container within an Azure Storage Account via Azure Front Door, (optionally) utilizing a custom domain name. This involved configuring the necessary components to ensure seamless and secure access to the content while maintaining high availability and scalability. Please note that 2 steps are not automated 
    1. Azure Storage Account private endpoint connections approve it is not supported via Terraform, it should be implement via az cli
    2. Custom domain verification is not implemented as it does not provided and verification is depends on DNS provider 

## After terraform apply
1. Az login and run terraform apply
2. Go to Azure portal-> Sotrage account->Network->Private endpoint connections and approve private link and wait 2 minutes
3. Check Azure Front Door url (terraform output) {front-door-url}/index.html
4. If costum domain is setup correctly you will need to go you Azure portal and manually verify your domain via DNS.


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.77.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_afd"></a> [afd](#module\_afd) | .\module | n/a |

## Resources

| Name | Type |
|------|------|
| [http_http.myip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom-domain"></a> [custom-domain](#input\_custom-domain) | The custom domain to use for the CDN Front Door profile. | `string` | `"learnit.solutions"` | no |
| <a name="input_location"></a> [location](#input\_location) | value of Azure datacenter the location | `string` | `"West US 3"` | no |
| <a name="input_location-prefix"></a> [location-prefix](#input\_location-prefix) | The location prefix to use for the resource group and CDN Front Door profile names. | `string` | `"wsu3"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the CDN Front Door profile. | `string` | `"frontdoortestag"` | no |
| <a name="input_storage-account-container-name"></a> [storage-account-container-name](#input\_storage-account-container-name) | The name of the storage account container. | `string` | `"home"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | <pre>{<br>  "createdBy": "agabrielyan",<br>  "environment": "test",<br>  "owner": "terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_customDomain"></a> [customDomain](#output\_customDomain) | n/a |
| <a name="output_front-door-url"></a> [front-door-url](#output\_front-door-url) | n/a |
| <a name="output_storage-account-url"></a> [storage-account-url](#output\_storage-account-url) | n/a |
<!-- END_TF_DOCS -->