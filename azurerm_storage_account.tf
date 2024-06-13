# resource "azurerm_storage_account" "st" {
#   name                = "st${var.project.env}${var.project.name}"
#   resource_group_name = data.azurerm_resource_group.rg.name
#   location            = data.azurerm_resource_group.rg.location

#   account_tier             = "Standard"
#   account_kind             = "StorageV2"
#   account_replication_type = "LRS"
#   #   is_hns_enabled           = true ### Hierarchical Namespace

#   # network_rules {
#   #   default_action             = "Deny"
#   #   ip_rules                   = var.allowed_ip_ranges
#   #   virtual_network_subnet_ids = [azurerm_subnet.aks.id, azurerm_subnet.vm.id]
#   #   bypass                     = ["AzureServices"]
#   # }

#   tags = {
#     Environment = var.tag.env
#   }
#   depends_on = [data.azurerm_resource_group.rg, azurerm_subnet.st]
# }

# resource "azurerm_storage_account_network_rules" "st" {
#   storage_account_id = azurerm_storage_account.st.id

#   default_action             = "Deny"
#   ip_rules                   = var.allowed_ip_ranges
#   virtual_network_subnet_ids = [azurerm_subnet.aks.id, azurerm_subnet.vm.id]
#   bypass                     = ["AzureServices"]

#   depends_on = [ azurerm_storage_account.st ]
# }