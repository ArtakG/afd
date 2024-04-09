variable "location" {
  description = "value of Azure datacenter the location"
  type        = string
}

variable "location-prefix" {
  default     = "weu"
  description = "The location prefix to use for the resource group and CDN Front Door profile names."
  type        = string
}

variable "name" {
  description = "The name of the CDN Front Door profile."
  type        = string
}

variable "storage-account-container-name" {
  description = "The name of the storage account container."
  type        = string
  default     = "home"
}

variable "custom-domain" {
  description = "The custom domain to use for the CDN Front Door profile."
  type        = string
}

variable "allowed_ips" {
  description = "The list of IP addresses that are allowed to access the storage account."
  type        = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  
}