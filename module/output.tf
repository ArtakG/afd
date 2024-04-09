output "customDomain" {
  value = var.custom-domain
}

output "front-door-uri" {
  value = azurerm_cdn_frontdoor_endpoint.this.host_name
}

output "storage-account-uri" {
  value = azurerm_storage_account.this.primary_blob_endpoint
}