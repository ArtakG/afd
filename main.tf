module "afd" {
  source                         = ".\\module"
  location                       = var.location
  location-prefix                = var.location-prefix
  name                           = var.name
  custom-domain                  = var.custom-domain
  allowed_ips                    = var.allowed_ips
  storage-account-container-name = var.storage-account-container-name
  tags                           = var.tags
}