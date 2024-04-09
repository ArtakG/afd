
// Resource for creating an Azure storage account
resource "azurerm_storage_account" "this" {
  account_replication_type         = "RAGRS"
  account_tier                     = "Standard"
  cross_tenant_replication_enabled = false
  location                         = azurerm_resource_group.this.location
  name                             = "${var.name}${random_string.this.result}"
  resource_group_name              = azurerm_resource_group.this.name
  tags                             = var.tags
}

resource "azurerm_storage_account_network_rules" "this" {
  storage_account_id         = azurerm_storage_account.this.id
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
