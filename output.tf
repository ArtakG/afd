output "customDomain" {
  value = module.afd.customDomain
}

output "front-door-uri" {
  value = "https://${module.afd.front-door-uri}/index.html"
}

output "storage_account_uri" {
  value = module.afd.storage-account-uri
}