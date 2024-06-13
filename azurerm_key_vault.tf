resource "azurerm_key_vault" "kv" {
  name                        = "kv-${var.project.env}-${var.project.name}"
  location                    = data.azurerm_resource_group.rg.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  enable_rbac_authorization   = true
  sku_name                    = "standard"

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules       = var.allowed_ip_ranges
  }

  tags = {
    Environment = var.tag.env
  }

  depends_on = [azurerm_subnet.kv, azurerm_subnet.aks, data.azurerm_client_config.current]
}