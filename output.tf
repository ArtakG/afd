output "customDomain" {
  value = module.afd.customDomain
}

output "front-door-url" {
  value = "https://${module.afd.front-door-uri}/index.html"
}

output "storage-account-url" {
  value = module.afd.storage-account-uri
}