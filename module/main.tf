locals {
  name   = "${var.name}-${var.location-prefix}"
  lentgh = 20 - length(var.name) // Calculating the remaining characters for the local name 
}

// Resource for creating an Azure resource group
resource "azurerm_resource_group" "this" {
  location = var.location
  name     = "${local.name}-rg"
  tags     = var.tags
}


// Resource for generating a random string
resource "random_string" "this" {
  length  = local.lentgh
  special = false
  upper   = false
  numeric = false
}
