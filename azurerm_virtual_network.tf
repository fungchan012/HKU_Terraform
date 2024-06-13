resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.project.env}-${var.project.name}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = [var.vnet_address_prefixes]

  tags = {
    Environment = var.tag.env
  }
  depends_on = [data.azurerm_resource_group.rg]
}