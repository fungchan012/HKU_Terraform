resource "azurerm_public_ip" "agw" {
  name                = "pip-${var.project.env}-${var.project.name}-agw"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Environment = var.tag.env
  }
}

resource "azurerm_public_ip" "vm" {
  name                = "pip-${var.project.env}-${var.project.name}-vm"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Environment = var.tag.env
  }
}