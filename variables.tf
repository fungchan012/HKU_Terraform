###############################################################################   Public Variable  ###############################################################################

variable "tfstate_st_key" {
  type = string
}

variable "project" {
  type = map(any)
  default = {
    name     = "crm"
    env      = "icprod"
    location = "eastasia"
  }
}

variable "tag" {
  type = map(any)
  default = {
    env = "PROD"
  }
}

variable "azure_subscription_id" {
  type = string
}

variable "exist_rg" {
  type    = string
  default = "rg-icprod-its-crm"
}

variable "allowed_ip_ranges" {
  type = list(string)
  default = [
    "42.200.136.39", # MtelIP01
    "223.255.152.98" # MtelIP02
  ]
}

###############################################################################   Vnet Variable  ###############################################################################

variable "vnet_address_prefixes" {
  type    = string
  default = "192.168.16.0/21"
}

variable "st_address_prefixes" {
  type    = string
  default = "192.168.20.0/24"
}

variable "vm_address_prefixes" {
  type    = string
  default = "192.168.19.0/24"
}

variable "kv_address_prefixes" {
  type    = string
  default = "192.168.16.0/24"
}

variable "aks_address_prefixes" {
  type    = string
  default = "192.168.17.0/24"
}

variable "agw_address_prefixes" {
  type    = string
  default = "192.168.18.0/24"
}

###############################################################################   VM Variable  ###############################################################################

variable "vm_size" {
  type    = string
  default = "Standard_D2s_v5"
}

variable "vm_password" {
  type = string
}


###############################################################################  AFD AGW Variable  ###############################################################################

variable "application_1" {
  type = any
  default = {
    name         = "web"
    ip_addresses = ["192.168.18.11"]
    routing_path = ["/form/*", "/form*"]
  }
}

variable "application_2" {
  type = any
  default = {
    name         = "api"
    ip_addresses = ["192.168.18.10"]
    routing_path = ["/api/*", "/callback/*"]
  }
}

###############################################################################  AKS Variable  ###############################################################################

variable "aks_sku_tier" {
  type    = string
  default = "Standard"   ### Free / Standard / Premium
}

variable "aks_version" {
  type    = string
  default = "1.27.9"
}

variable "aks_vm_size" {
  type    = string
  default = "Standard_D2s_v5"
}

variable "aks_service_cidr" {
  type    = string
  default = "172.20.0.0/16"
}

variable "aks_dns_service_ip" {
  type    = string
  default = "172.20.0.10"
}

variable "aks_pod_cidr" {
  type    = string
  default = "172.21.0.0/16"
}