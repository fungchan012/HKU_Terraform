terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.90.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-icuat-its-crm"
    storage_account_name = "sticuatcrm"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id            = var.azure_subscription_id
  skip_provider_registration = true
  #   client_id       = ""
  #   client_secret   = var.client_secret
  #   tenant_id       = ""
}