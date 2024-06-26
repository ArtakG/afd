variable "location" {
  description = "value of Azure datacenter the location"
  type        = string
  default     = "West US 3"
}

variable "location-prefix" {
  default     = "wsu3"
  description = "The location prefix to use for the resource group and CDN Front Door profile names."
  type        = string
}

variable "name" {
  description = "The name of the CDN Front Door profile."
  type        = string
  default     = "frontdoortestag"
}

variable "storage-account-container-name" {
  description = "The name of the storage account container."
  type        = string
  default     = "home"
}

variable "custom-domain" {
  description = "The custom domain to use for the CDN Front Door profile."
  type        = string
  default     = "learnit.solutions"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default = {
    environment = "test"
    owner       = "terraform"
    createdBy   = "agabrielyan"
  }
}