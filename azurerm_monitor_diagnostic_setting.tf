# resource "azurerm_monitor_diagnostic_setting" "afd" {
#   name                       = "ds-${var.project.env}-${var.project.name}-afd"
#   target_resource_id         = azurerm_cdn_frontdoor_profile.afd.id
#   log_analytics_workspace_id = azurerm_log_analytics_workspace.log.id

#   enabled_log {
#     category = "FrontDoorAccessLog"
#   }
#   enabled_log {
#     category = "FrontDoorWebApplicationFirewallLog"
#   }
#   depends_on = [ azurerm_cdn_frontdoor_profile.afd ]
# }

resource "azurerm_monitor_diagnostic_setting" "agw" {
  name                       = "agw-ds-${var.project.env}-${var.project.name}"
  target_resource_id         = azurerm_application_gateway.agw.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log.id

  enabled_log {
    category = "ApplicationGatewayAccessLog"
  }
  enabled_log {
    category = "ApplicationGatewayFirewallLog"
  }
  depends_on = [azurerm_application_gateway.agw]
}