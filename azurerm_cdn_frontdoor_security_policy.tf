# resource "azurerm_cdn_frontdoor_security_policy" "sp" {
#   name                     = "sp-${var.project.env}-${var.project.name}-afd"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id

#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = azurerm_cdn_frontdoor_firewall_policy.afd_waf.id

#       association {
#         domain {
#           cdn_frontdoor_domain_id = azurerm_cdn_frontdoor_endpoint.fde.id
#         }
#         patterns_to_match = ["/*"]
#       }
#     }
#   }  
# }