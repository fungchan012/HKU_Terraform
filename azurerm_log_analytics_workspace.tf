resource "azurerm_log_analytics_workspace" "log" {
  name                = "log-${var.project.env}-${var.project.name}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    Environment = var.tag.env
  }
}
