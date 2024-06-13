
###############################################################################    Storage Account nsg Inbound Rules  ###############################################################################
# resource "azurerm_network_security_group" "st" {
#   name                = "nsg-${var.project.env}-${var.project.name}-snet-st"
#   location            = data.azurerm_resource_group.rg.location
#   resource_group_name = data.azurerm_resource_group.rg.name

#   tags = {
#     Environment = var.tag.env
#   }
#   depends_on = [azurerm_subnet.st, azurerm_storage_account.st]

#   security_rule {
#     name              = "AllowMtelInbound"
#     priority          = 1100
#     direction         = "Inbound"
#     access            = "Allow"
#     protocol          = "Tcp"
#     source_port_range = "*"
#     # source_port_ranges            = []
#     destination_port_range = "*"
#     # destination_port_ranges       = []
#     # source_address_prefix         = ""
#     source_address_prefixes    = var.allowed_ip_ranges
#     destination_address_prefix = "VirtualNetwork"
#     # destination_address_prefixes = []
#   }

#   security_rule {
#     name              = "DenyAnyInbound"
#     priority          = 4000
#     direction         = "Inbound"
#     access            = "Deny"
#     protocol          = "Tcp"
#     source_port_range = "*"
#     # source_port_ranges            = []
#     destination_port_range = "*"
#     # destination_port_ranges       = []
#     source_address_prefix = "*"
#     # source_address_prefixes       = []
#     destination_address_prefix = "*"
#     # destination_address_prefixes  = []
#   }

#   ###############################################################################    Storage Account nsg Outbound Rules  ###############################################################################

#   security_rule {
#     name              = "AllowVnetOutbound"
#     priority          = 1000
#     direction         = "Outbound"
#     access            = "Allow"
#     protocol          = "Tcp"
#     source_port_range = "*"
#     # source_port_ranges            = []
#     destination_port_range = "*"
#     # destination_port_ranges       = []
#     # source_address_prefix = ""
#     source_address_prefixes    = [var.st_address_prefixes]
#     destination_address_prefix = "VirtualNetwork"
#     # destination_address_prefixes = []
#   }

#   security_rule {
#     name              = "AllowMtelOutbound"
#     priority          = 1010
#     direction         = "Outbound"
#     access            = "Allow"
#     protocol          = "Tcp"
#     source_port_range = "*"
#     # source_port_ranges            = []
#     destination_port_range = "*"
#     # destination_port_ranges       = []
#     # source_address_prefix = ""
#     source_address_prefixes    = [var.st_address_prefixes]
#     destination_address_prefix = "Internet"
#     # destination_address_prefixes = []
#   }

#   security_rule {
#     name              = "DenyAnyOutbound"
#     priority          = 4000
#     direction         = "Outbound"
#     access            = "Deny"
#     protocol          = "Tcp"
#     source_port_range = "*"
#     # source_port_ranges            = []
#     destination_port_range = "*"
#     # destination_port_ranges       = []
#     source_address_prefix = "*"
#     # source_address_prefixes       = []
#     destination_address_prefix = "*"
#     # destination_address_prefixes  = []
#   }

# }

###############################################################################    Application Gateway nsg Inbound Rules  ###############################################################################

resource "azurerm_network_security_group" "agw" {
  name                = "nsg-${var.project.env}-${var.project.name}-snet-agw"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = {
    Environment = var.tag.env
  }
  depends_on = [azurerm_subnet.agw, azurerm_application_gateway.agw]


  security_rule {
    name              = "AllowGatewayManagerInbound"
    priority          = 1000
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "65200-65535"
    # destination_port_ranges       = []
    source_address_prefix = "GatewayManager"
    # source_address_prefixes       = []
    destination_address_prefix = "*"
    # destination_address_prefixes = []
  }

  security_rule {
    name              = "AllowALBInbound"
    priority          = 1010
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    source_address_prefix = "AzureLoadBalancer"
    # source_address_prefixes       = []
    destination_address_prefix = "*"
    # destination_address_prefixes = []
  }

  security_rule {
    name              = "AllowAFDBackendInbound"
    priority          = 1020
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges     = []
    # destination_port_range = ""
    destination_port_ranges = ["80", "443"]
    source_address_prefix   = "AzureFrontDoor.Backend"
    # source_address_prefixes       = []
    destination_address_prefix = "VirtualNetwork"
    # destination_address_prefixes = []
  }

  security_rule {
    name              = "AllowAzureCloudInbound"
    priority          = 1030
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges     = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    source_address_prefix = "AzureCloud"
    # source_address_prefixes       = []
    destination_address_prefix = "*"
    # destination_address_prefixes = []
  }

  security_rule {
    name              = "AllowMtelInbound"
    priority          = 1100
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    # source_address_prefix         = ""
    source_address_prefixes    = var.allowed_ip_ranges
    destination_address_prefix = "VirtualNetwork"
    # destination_address_prefixes = []
  }

  security_rule {
    name              = "DenyAnyInbound"
    priority          = 4000
    direction         = "Inbound"
    access            = "Deny"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    source_address_prefix = "*"
    # source_address_prefixes       = []
    destination_address_prefix = "*"
    # destination_address_prefixes  = []
  }

  ###############################################################################    Application Gateway nsg Outbound Rules  ###############################################################################

  security_rule {
    name              = "AllowGatewayManagerOutbound"
    priority          = 1000
    direction         = "Outbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    source_address_prefix = "*"
    # source_address_prefixes       = []
    destination_address_prefix = "VirtualNetwork"
    # destination_address_prefixes  = []
  }

  security_rule {
    name              = "AllowALBOutbound"
    priority          = 1010
    direction         = "Outbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    source_address_prefix = "*"
    # source_address_prefixes       = []
    destination_address_prefix = "VirtualNetwork"
    # destination_address_prefixes  = []
  }

}

###############################################################################    Key vaults nsg Inbound Rules  ###############################################################################

resource "azurerm_network_security_group" "kv" {
  name                = "nsg-${var.project.env}-${var.project.name}-snet-kv"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = {
    Environment = var.tag.env
  }
  depends_on = [azurerm_subnet.kv, azurerm_key_vault.kv]

  security_rule {
    name              = "AllowGatewayManagerInbound"
    priority          = 1000
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "443"
    # destination_port_ranges       = []
    source_address_prefix = "GatewayManager"
    # source_address_prefixes       = []
    destination_address_prefix = "VirtualNetwork"
    # destination_address_prefixes = []
  }

  security_rule {
    name              = "AllowAksInbound"
    priority          = 1010
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    # source_address_prefix         = ""
    source_address_prefixes    = [var.aks_address_prefixes]
    destination_address_prefix = "*"
    # destination_address_prefixes = []
  }

  security_rule {
    name              = "AllowAzureCloudInbound"
    priority          = 1020
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    source_address_prefix = "AzureCloud"
    # source_address_prefixes    = []
    destination_address_prefix = "VirtualNetwork"
    # destination_address_prefixes = []
  }

  security_rule {
    name              = "AllowMtelInbound"
    priority          = 1100
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    # source_address_prefix         = ""
    source_address_prefixes    = var.allowed_ip_ranges
    destination_address_prefix = "VirtualNetwork"
    # destination_address_prefixes = []
  }

  security_rule {
    name              = "DenyAnyInbound"
    priority          = 4000
    direction         = "Inbound"
    access            = "Deny"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    source_address_prefix = "*"
    # source_address_prefixes       = []
    destination_address_prefix = "*"
    # destination_address_prefixes  = []
  }

  ###############################################################################    Key vaults nsg Outbound Rules  ###############################################################################  

  security_rule {
    name              = "DenyAnyOutbound"
    priority          = 4000
    direction         = "Outbound"
    access            = "Deny"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    source_address_prefix = "*"
    # source_address_prefixes       = []
    destination_address_prefix = "*"
    # destination_address_prefixes  = []
  }
}


###############################################################################    Virtual Machine nsg Inbound Rules  ###############################################################################

resource "azurerm_network_security_group" "vm" {
  name                = "nsg-${var.project.env}-${var.project.name}-snet-vm"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = {
    Environment = var.tag.env
  }
  depends_on = [azurerm_subnet.vm]

  security_rule {
    name              = "AllowMtelInbound"
    priority          = 1100
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    # source_address_prefix         = ""
    source_address_prefixes    = var.allowed_ip_ranges
    destination_address_prefix = "VirtualNetwork"
    # destination_address_prefixes = []
  }
  ###############################################################################    Virtual Machine nsg Outbound Rules  ###############################################################################
}


###############################################################################    AKS nsg Inbound Rules  ###############################################################################

resource "azurerm_network_security_group" "aks" {
  name                = "nsg-${var.project.env}-${var.project.name}-snet-aks"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = {
    Environment = var.tag.env
  }
  depends_on = [azurerm_subnet.aks, azurerm_kubernetes_cluster.aks]

  security_rule {
    name              = "AllowGatewayManagerInbound"
    priority          = 1000
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    source_address_prefix = "GatewayManager"
    # source_address_prefixes       = []
    destination_address_prefix = "VirtualNetwork"
    # destination_address_prefixes = []
  }

  security_rule {
    name              = "AllowALBInbound"
    priority          = 1010
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    source_address_prefix = "AzureLoadBalancer"
    # source_address_prefixes       = []
    destination_address_prefix = "VirtualNetwork"
    # destination_address_prefixes = []
  }

  security_rule {
    name              = "AllowAzureCloudInbound"
    priority          = 1030
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges     = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    source_address_prefix = "AzureCloud"
    # source_address_prefixes       = []
    destination_address_prefix = "VirtualNetwork"
    # destination_address_prefixes = []
  }

  security_rule {
    name              = "AllowAksInbound"
    priority          = 1040
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges     = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    # source_address_prefix = ""
    source_address_prefixes = [var.aks_address_prefixes, var.aks_service_cidr, var.aks_pod_cidr]
    # destination_address_prefix    = ""
    destination_address_prefixes = [var.aks_address_prefixes, var.aks_service_cidr, var.aks_pod_cidr]
  }

  security_rule {
    name              = "AllowAksAlbInbound"
    priority          = 1050
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges     = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    source_address_prefix = "AzureLoadBalancer"
    # source_address_prefixes = []
    # destination_address_prefix    = ""
    destination_address_prefixes = [var.aks_address_prefixes, var.aks_service_cidr, var.aks_pod_cidr]
  }

  security_rule {
    name              = "AllowAgwVnetInbound"
    priority          = 1060
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges     = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    source_address_prefix = var.agw_address_prefixes
    # source_address_prefixes = []
    destination_address_prefix = "*"
    # destination_address_prefixes = []
  }

  security_rule {
    name              = "AllowMtelInbound"
    priority          = 1100
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    # source_address_prefix         = ""
    source_address_prefixes    = var.allowed_ip_ranges
    destination_address_prefix = "VirtualNetwork"
    # destination_address_prefixes = []
  }

  security_rule {
    name              = "DenyAnyInbound"
    priority          = 4000
    direction         = "Inbound"
    access            = "Deny"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    source_address_prefix = "*"
    # source_address_prefixes       = []
    destination_address_prefix = "*"
    # destination_address_prefixes  = []
  }

  ###############################################################################    AKS nsg Outbound Rules  ###############################################################################

  security_rule {
    name              = "AllowAzureCloudOutbound1"
    priority          = 1000
    direction         = "Outbound"
    access            = "Allow"
    protocol          = "Udp" #using Udp
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "1194"
    # destination_port_ranges       = []
    source_address_prefix = "VirtualNetwork"
    # source_address_prefixes       = []
    destination_address_prefix = "AzureCloud"
    # destination_address_prefixes  = []
  }

  security_rule {
    name              = "AllowAzureCloudOutbound2"
    priority          = 1010
    direction         = "Outbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "9000"
    # destination_port_ranges       = []
    source_address_prefix = "VirtualNetwork"
    # source_address_prefixes       = []
    destination_address_prefix = "AzureCloud"
    # destination_address_prefixes  = []
  }

  security_rule {
    name              = "AllowNtpOutbound"
    priority          = 1020
    direction         = "Outbound"
    access            = "Allow"
    protocol          = "Udp" #using Udp
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "123"
    # destination_port_ranges       = []
    source_address_prefix = "VirtualNetwork"
    # source_address_prefixes       = []
    destination_address_prefix = "*"
    # destination_address_prefixes  = []
  }

  security_rule {
    name              = "AllowDnsOutbound"
    priority          = 1030
    direction         = "Outbound"
    access            = "Allow"
    protocol          = "Udp" #using Udp
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "53"
    # destination_port_ranges       = []
    source_address_prefix = "VirtualNetwork"
    # source_address_prefixes       = []
    destination_address_prefix = "*"
    # destination_address_prefixes  = []
  }

  security_rule {
    name              = "AllowACROutbound"
    priority          = 1040
    direction         = "Outbound"
    access            = "Allow"
    protocol          = "Udp" #using Udp
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "443"
    # destination_port_ranges       = []
    source_address_prefix = "VirtualNetwork"
    # source_address_prefixes       = []
    destination_address_prefix = "AzureContainerRegistry"
    # destination_address_prefixes  = []
  }

  security_rule {
    name              = "AllowServiceTagKvOutbound"
    priority          = 1050
    direction         = "Outbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "443"
    # destination_port_ranges       = []
    source_address_prefix = "VirtualNetwork"
    # source_address_prefixes       = []
    destination_address_prefix = "AzureKeyVault"
    # destination_address_prefixes  = []
  }

  security_rule {
    name              = "AllowAADOutbound"
    priority          = 1060
    direction         = "Outbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "443"
    # destination_port_ranges       = []
    source_address_prefix = "VirtualNetwork"
    # source_address_prefixes       = []
    destination_address_prefix = "AzureActiveDirectory"
    # destination_address_prefixes  = []
  }

  security_rule {
    name              = "AllowALBOutbound"
    priority          = 1070
    direction         = "Outbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "443"
    # destination_port_ranges       = []
    source_address_prefix = "VirtualNetwork"
    # source_address_prefixes       = []
    destination_address_prefix = "AzureLoadBalancer"
    # destination_address_prefixes  = []
  }

  security_rule {
    name              = "AllowVnetOutbound"
    priority          = 1080
    direction         = "Outbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    source_address_prefix = "VirtualNetwork"
    # source_address_prefixes       = []
    destination_address_prefix = "VirtualNetwork"
    # destination_address_prefixes  = []
  }

  security_rule {
    name              = "AllowAksInternalOutbound"
    priority          = 1090
    direction         = "Outbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    # source_address_prefix = ""
    source_address_prefixes = [var.aks_address_prefixes, var.aks_service_cidr, var.aks_pod_cidr]
    # destination_address_prefix = ""
    destination_address_prefixes = [var.aks_address_prefixes, var.aks_service_cidr, var.aks_pod_cidr]
  }

  security_rule {
    name              = "AllowAksOutbound"
    priority          = 1100
    direction         = "Outbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "443"
    # destination_port_ranges       = []
    source_address_prefix = "VirtualNetwork"
    # source_address_prefixes       = []
    destination_address_prefix = "Internet"
    # destination_address_prefixes  = []
  }

  security_rule {
    name              = "AllowKvOutbound"
    priority          = 1500
    direction         = "Outbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "443"
    # destination_port_ranges       = []
    source_address_prefix = "VirtualNetwork"
    # source_address_prefixes       = []
    # destination_address_prefix = ""
    destination_address_prefixes = [var.kv_address_prefixes]
  }

  security_rule {
    name              = "AllowStrOutbound"
    priority          = 1510
    direction         = "Outbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "443"
    # destination_port_ranges       = []
    source_address_prefix = "VirtualNetwork"
    # source_address_prefixes       = []
    # destination_address_prefix = ""
    destination_address_prefixes = [var.st_address_prefixes]
  }

  security_rule {
    name              = "AllowVmOutbound"
    priority          = 1520
    direction         = "Outbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "443"
    # destination_port_ranges       = []
    source_address_prefix = "VirtualNetwork"
    # source_address_prefixes       = []
    # destination_address_prefix = ""
    destination_address_prefixes = [var.vm_address_prefixes]
  }

  security_rule {
    name              = "DenyAnyOutbound"
    priority          = 4000
    direction         = "Outbound"
    access            = "Deny"
    protocol          = "Tcp"
    source_port_range = "*"
    # source_port_ranges            = []
    destination_port_range = "*"
    # destination_port_ranges       = []
    source_address_prefix = "*"
    # source_address_prefixes       = []
    destination_address_prefix = "*"
    # destination_address_prefixes  = []
  }
}