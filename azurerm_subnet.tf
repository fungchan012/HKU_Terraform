resource "azurerm_subnet" "st" {
  name                 = "subnet-st"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.st_address_prefixes]
  depends_on           = [azurerm_virtual_network.vnet]
}

# resource "azurerm_subnet_network_security_group_association" "st" {
#   subnet_id                 = azurerm_subnet.st.id
#   network_security_group_id = azurerm_network_security_group.st.id
# }

resource "azurerm_subnet" "vm" {
  name                 = "subnet-vm"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.vm_address_prefixes]
  service_endpoints    = ["Microsoft.Storage"]
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet_network_security_group_association" "vm" {
  subnet_id                 = azurerm_subnet.vm.id
  network_security_group_id = azurerm_network_security_group.vm.id
}

resource "azurerm_subnet" "kv" {
  name                 = "subnet-kv"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.kv_address_prefixes]
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet_network_security_group_association" "kv" {
  subnet_id                 = azurerm_subnet.kv.id
  network_security_group_id = azurerm_network_security_group.kv.id
}

resource "azurerm_subnet" "aks" {
  name                 = "subnet-aks"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.aks_address_prefixes]
  service_endpoints    = ["Microsoft.Storage"]
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet_network_security_group_association" "aks" {
  subnet_id                 = azurerm_subnet.aks.id
  network_security_group_id = azurerm_network_security_group.aks.id
}

resource "azurerm_subnet" "agw" {
  name                 = "subnet-agw"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.agw_address_prefixes]
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet_network_security_group_association" "agw" {
  subnet_id                 = azurerm_subnet.agw.id
  network_security_group_id = azurerm_network_security_group.agw.id
}