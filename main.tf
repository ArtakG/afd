module "afd" {
  source                         = ".\\module"
  location                       = var.location
  location-prefix                = var.location-prefix
  name                           = var.name
  custom-domain                  = var.custom-domain
  allowed_ips                    = ["${chomp(data.http.myip.response_body)}"]
  storage-account-container-name = var.storage-account-container-name
  tags                           = var.tags
}

// Get my public IP
data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}