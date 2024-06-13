output "account_id" {
  value     = data.azurerm_client_config.current.client_id
  sensitive = true
}

output "tenant_id" {
  value     = data.azurerm_client_config.current.tenant_id
  sensitive = true
}

# output "object_id" {
#   value = data.azurerm_client_config.current.object_id
# }

# output "client_certificate" {
#   value     = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
#   sensitive = true
# }

# output "kube_config" {
#   value = azurerm_kubernetes_cluster.aks.kube_config_raw
#   sensitive = true
# }

output "agw_ip_address" {
  value = azurerm_public_ip.agw.ip_address
}