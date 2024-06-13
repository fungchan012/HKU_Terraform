locals {
  frontend_port_name             = "feport-${var.project.env}-${var.project.name}"
  frontend_ip_configuration_name = "feip-${var.project.env}-${var.project.name}"
  listener_name                  = "http-lstn-${var.project.env}-${var.project.name}"
  request_routing_rule_name      = "rule-${var.project.env}-${var.project.name}"
  url_path_map_name              = "url-path-map-${var.project.env}-${var.project.name}"
}

resource "azurerm_application_gateway" "agw" {
  name                = "agw-${var.project.env}-${var.project.name}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  tags = {
    Environment = var.tag.env
  }

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "gateway-ip-config-${var.project.env}-${var.project.name}"
    subnet_id = azurerm_subnet.agw.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.agw.id
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  backend_address_pool {
    name         = var.application_1.name
    ip_addresses = var.application_1.ip_addresses
  }

  backend_address_pool {
    name         = var.application_2.name
    ip_addresses = var.application_2.ip_addresses
  }

  backend_http_settings {
    name                  = var.application_1.name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  backend_http_settings {
    name                  = var.application_2.name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  url_path_map {
    name                               = local.url_path_map_name
    default_backend_address_pool_name  = var.application_1.name
    default_backend_http_settings_name = var.application_1.name

    path_rule {
      name                       = var.application_1.name
      paths                      = var.application_1.routing_path
      backend_address_pool_name  = var.application_1.name
      backend_http_settings_name = var.application_1.name
    }
  }

  request_routing_rule {
    name               = local.request_routing_rule_name
    rule_type          = "PathBasedRouting"
    http_listener_name = local.listener_name
    url_path_map_name  = local.url_path_map_name
    priority           = 100
  }

  firewall_policy_id                = azurerm_web_application_firewall_policy.agw_waf.id
  force_firewall_policy_association = true
  depends_on                        = [azurerm_subnet.agw, azurerm_web_application_firewall_policy.agw_waf]
}
