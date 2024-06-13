resource "azurerm_network_interface" "vm" {
  name                = "nic-${var.project.env}-${var.project.name}-vm"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tags = {
    Environment = var.tag.env
  }

  ip_configuration {
    name                          = "vmipconfig"
    subnet_id                     = azurerm_subnet.vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm.id

  }
  depends_on = [azurerm_subnet.vm]
}