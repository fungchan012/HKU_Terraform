# resource "azurerm_cdn_frontdoor_firewall_policy" "afd_waf" {
#   name                              = "waf${var.project.env}${var.project.name}afd"
#   resource_group_name               = data.azurerm_resource_group.rg.name
#   sku_name                          = azurerm_cdn_frontdoor_profile.afd.sku_name
#   enabled                           = true
#   mode                              = "Prevention"
#   redirect_url                      = null
#   custom_block_response_status_code = 403
#   custom_block_response_body        = null

#   custom_rule {
#     name                           = "DenyNotMtelIPInbound"
#     enabled                        = true
#     priority                       = 100
#     # rate_limit_duration_in_minutes = 1
#     # rate_limit_threshold           = 10
#     type                           = "MatchRule"
#     action                         = "Block"

#     match_condition {
#       match_variable     = "RemoteAddr"
#       operator           = "IPMatch"
#       negation_condition = true
#       match_values       = var.allowed_ip_ranges
#     }
#   }
#   tags = {
#     Environment = var.tag.env
#   }  
# }