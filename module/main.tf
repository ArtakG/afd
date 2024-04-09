locals {
  name = "${var.name}-${var.location-prefix}"
  lentgh = 20-length(var.name)   // Calculating the remaining characters for the local name 
}

// Resource for creating an Azure resource group
resource "azurerm_resource_group" "this" {
  location = var.location       
  name     = "${local.name}-rg" 
  tags = var.tags
}

// Resource for creating an Azure CDN frontdoor profile
resource "azurerm_cdn_frontdoor_profile" "this" {
  name                     = "${local.name}-profile"
  resource_group_name      = azurerm_resource_group.this.name
  response_timeout_seconds = 60
  sku_name                 = "Premium_AzureFrontDoor"
  tags = var.tags

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
    location               = var.location
    private_link_target_id = azurerm_storage_account.this.id
    request_message        = "The request is from terraform"
    target_type            = "blob"
  }

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.this,
    azurerm_storage_account.this,
  ]
}

// Resource for generating a random string
resource "random_string" "this" {
  length  = local.lentgh
  special = false
  upper   = false
  number  = false
}

// Resource for creating an Azure storage account
resource "azurerm_storage_account" "this" {
  account_replication_type         = "RAGRS"
  account_tier                     = "Standard"
  cross_tenant_replication_enabled = false
  location                         = azurerm_resource_group.this.location
  name                             = "${var.name}${random_string.this.result}"
  resource_group_name              = azurerm_resource_group.this.name
  tags = var.tags
}

resource "azurerm_storage_account_network_rules" "this" {
  storage_account_id = azurerm_storage_account.this.id
  default_action             = "Deny"
  ip_rules                   = var.allowed_ips
  virtual_network_subnet_ids = []
  bypass                     = ["AzureServices"]
}

resource "azurerm_storage_container" "this" {
  container_access_type = "blob"
  name                  = var.storage-account-container-name
  storage_account_name  = azurerm_storage_account.this.name
}

// Resource for uploading a blob to Azure storage
resource "azurerm_storage_blob" "this" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.this.name
  type                   = "Block"
  source                 = "index.html"
  content_type           = "text/html"
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