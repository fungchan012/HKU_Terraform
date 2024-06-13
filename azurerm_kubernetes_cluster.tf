resource "azurerm_kubernetes_cluster" "aks" {
  name                   = "aks-${var.project.env}-${var.project.name}"
  location               = data.azurerm_resource_group.rg.location
  resource_group_name    = data.azurerm_resource_group.rg.name
  dns_prefix             = "aks-${var.project.env}-${var.project.name}-dns"
  sku_tier               = var.aks_sku_tier
  kubernetes_version     = var.aks_version
  local_account_disabled = false

  default_node_pool {
    name                = "systempool"
    enable_auto_scaling = false
    # max_count = ""     ### fill when enable autoscaling
    # min_count = ""     ### fill when enable autoscaling
    node_count     = 1
    vm_size        = var.aks_vm_size
    os_sku         = "Ubuntu"
    zones          = ["1"]
    vnet_subnet_id = azurerm_subnet.aks.id ### choose own vnet
  }

  network_profile {
    network_plugin = "kubenet"
    service_cidr   = var.aks_service_cidr
    dns_service_ip = var.aks_dns_service_ip
    pod_cidr       = var.aks_pod_cidr
    network_policy = "calico"
  }

  api_server_access_profile {
    authorized_ip_ranges = var.allowed_ip_ranges
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  #   oms_agent {
  #     log_analytics_workspace_id = azurerm_log_analytics_workspace.log.id
  #   }

  tags = {
    Environment = var.tag.env
  }
  depends_on = [azurerm_subnet.aks, azurerm_log_analytics_workspace.log]
}
