resource "azurerm_private_endpoint" "kv" {
  name                = "pep-${var.project.env}-${var.project.name}-kv"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.kv.id
  tags = {
    Environment = var.tag.env
  }

  private_service_connection {
    name                           = "kv-psc"
    private_connection_resource_id = azurerm_key_vault.kv.id
    subresource_names              = ["Vault"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pep-dns-zone-group-${var.project.env}-${var.project.name}-kv"
    private_dns_zone_ids = [azurerm_private_dns_zone.kv.id]
  }
  depends_on = [azurerm_subnet.kv, azurerm_key_vault.kv]
}

resource "azurerm_private_dns_zone" "kv" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = data.azurerm_resource_group.rg.name
  tags = {
    Environment = var.tag.env
  }

  depends_on = [azurerm_subnet.kv, azurerm_key_vault.kv]
}

resource "azurerm_private_dns_zone_virtual_network_link" "kv" {
  name                  = "pl-${var.project.env}-${var.project.name}-kv"
  resource_group_name   = data.azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.kv.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  tags = {
    Environment = var.tag.env
  }

  depends_on = [azurerm_subnet.kv, azurerm_key_vault.kv]
}
