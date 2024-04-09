// Resource for creating an Azure CDN frontdoor profile
resource "azurerm_cdn_frontdoor_profile" "this" {
  name                     = "${local.name}-profile"
  resource_group_name      = azurerm_resource_group.this.name
  response_timeout_seconds = 60
  sku_name                 = "Premium_AzureFrontDoor"
  tags                     = var.tags

}

// Resource for creating an Azure CDN frontdoor endpoint
resource "azurerm_cdn_frontdoor_endpoint" "this" {
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
  name                     = "${local.name}-edp"
}

// Resource for creating an Azure CDN frontdoor route
resource "azurerm_cdn_frontdoor_route" "this" {
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.this.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.this.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.this.id]
  name                          = "${local.name}-route"
  patterns_to_match             = ["/*"]
  supported_protocols           = ["Http", "Https"]
  cdn_frontdoor_origin_path     = "/${var.storage-account-container-name}/"
  depends_on = [
    azurerm_cdn_frontdoor_endpoint.this,
    azurerm_cdn_frontdoor_origin_group.this
  ]
}

// Resource for creating an Azure CDN frontdoor origin group
resource "azurerm_cdn_frontdoor_origin_group" "this" {
  cdn_frontdoor_profile_id                                  = azurerm_cdn_frontdoor_profile.this.id
  name                                                      = "${local.name}-origin-group"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false
  health_probe {
    interval_in_seconds = 100
    protocol            = "Http"
  }
  load_balancing {
  }
  depends_on = [
    azurerm_cdn_frontdoor_profile.this,
  ]
}

resource "azurerm_cdn_frontdoor_origin" "this" {
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.this.id
  certificate_name_check_enabled = true
  host_name                      = "${var.name}${random_string.this.result}.blob.core.windows.net"
  name                           = "${local.name}-origin"
  origin_host_header             = "${var.name}${random_string.this.result}.blob.core.windows.net"
  weight                         = 1000
  enabled                        = true

  private_link {
    location               = azurerm_resource_group.this.location
    private_link_target_id = azurerm_storage_account.this.id
    request_message        = "The request is from terraform"
    target_type            = "blob"
  }

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.this,
    azurerm_storage_account.this,
  ]
}


// Resource for creating a custom domain for Azure CDN frontdoor
resource "azurerm_cdn_frontdoor_custom_domain" "example" {
  name                     = "${local.name}-customDomain"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
  host_name                = var.custom-domain

  tls {
    certificate_type    = "ManagedCertificate"
    minimum_tls_version = "TLS12"
  }
}
