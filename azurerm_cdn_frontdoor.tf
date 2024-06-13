# resource "azurerm_cdn_frontdoor_profile" "afd" {
#   name                = "afd-${var.project.env}-${var.project.name}"
#   resource_group_name = data.azurerm_resource_group.rg.name
#   sku_name            = "Standard_AzureFrontDoor"

#   tags = {
#     Environment = var.tag.env
#   }
# }

# resource "azurerm_cdn_frontdoor_endpoint" "fde" {
#   name                     = "fde-${var.project.env}-${var.project.name}"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id

#   tags = {
#     Environment = var.tag.env
#   }
# }

# resource "azurerm_cdn_frontdoor_origin_group" "application_1" {
#   name                     = "origingroup-${var.project.env}-${var.project.name}-${var.application_1.name}"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   session_affinity_enabled = true

#   load_balancing {}
# }

# resource "azurerm_cdn_frontdoor_origin_group" "application_2" {
#   name                     = "origingroup-${var.project.env}-${var.project.name}-${var.application_2.name}"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   session_affinity_enabled = true

#   load_balancing {}
# }

# resource "azurerm_cdn_frontdoor_origin" "application_1" {
#   name                          = "origin-${var.project.env}-${var.project.name}-${var.application_1.name}"
#   cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.application_1.id
#   enabled                       = true

#   certificate_name_check_enabled = false

#   host_name          = azurerm_public_ip.agw.ip_address
#   http_port          = 80
#   https_port         = 443
#   origin_host_header = azurerm_public_ip.agw.ip_address
#   priority           = 1
#   weight             = 50  
# }

# resource "azurerm_cdn_frontdoor_origin" "application_2" {
#   name                          = "origin-${var.project.env}-${var.project.name}-${var.application_2.name}"
#   cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.application_2.id
#   enabled                       = true

#   certificate_name_check_enabled = false

#   host_name          = azurerm_public_ip.agw.ip_address
#   http_port          = 80
#   https_port         = 443
#   origin_host_header = azurerm_public_ip.agw.ip_address
#   priority           = 1
#   weight             = 50  
# }

# resource "azurerm_cdn_frontdoor_route" "application_1" {
#   name                          = "route-${var.project.env}-${var.project.name}-${var.application_1.name}"
#   cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.fde.id
#   cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.application_1.id
#   cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.application_1.id]
#   # cdn_frontdoor_rule_set_ids    = [azurerm_cdn_frontdoor_rule_set.example.id]
#   enabled                       = true

#   forwarding_protocol    = "MatchRequest"
#   https_redirect_enabled = true
#   patterns_to_match      = var.application_1.routing_path
#   supported_protocols    = ["Http", "Https"]

#   # cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.contoso.id, azurerm_cdn_frontdoor_custom_domain.fabrikam.id]
#   link_to_default_domain          = true

#   # cache {
#   #   query_string_caching_behavior = "IgnoreSpecifiedQueryStrings"
#   #   query_strings                 = ["account", "settings"]
#   #   compression_enabled           = true
#   #   content_types_to_compress     = ["text/html", "text/javascript", "text/xml"]
#   # }
# }

# resource "azurerm_cdn_frontdoor_route" "application_2" {
#   name                          = "route-${var.project.env}-${var.project.name}-${var.application_2.name}"
#   cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.fde.id
#   cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.application_2.id
#   cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.application_2.id]
#   # cdn_frontdoor_rule_set_ids    = [azurerm_cdn_frontdoor_rule_set.example.id]
#   enabled                       = true

#   forwarding_protocol    = "MatchRequest"
#   https_redirect_enabled = true
#   patterns_to_match      = var.application_2.routing_path
#   supported_protocols    = ["Http", "Https"]

#   # cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.contoso.id, azurerm_cdn_frontdoor_custom_domain.fabrikam.id]
#   link_to_default_domain          = true

#   # cache {
#   #   query_string_caching_behavior = "IgnoreSpecifiedQueryStrings"
#   #   query_strings                 = ["account", "settings"]
#   #   compression_enabled           = true
#   #   content_types_to_compress     = ["text/html", "text/javascript", "text/xml"]
#   # }
# }