###############################################################################  Linux OS VM    ###############################################################################

# resource "azurerm_virtual_machine" "jumphost" {
#   name                  = "azlv-${var.project.env}-${var.project.name}-jumphost"
#   location              = data.azurerm_resource_group.rg.location
#   resource_group_name   = data.azurerm_resource_group.rg.name
#   network_interface_ids = [azurerm_network_interface.vm.id]
#   vm_size               = var.vm_size

#   # Uncomment this line to delete the OS disk automatically when deleting the VM
#   delete_os_disk_on_termination = true

#   # Uncomment this line to delete the data disks automatically when deleting the VM
#   delete_data_disks_on_termination = true

#   storage_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts-gen2"
#     version   = "latest"
#   }
#   storage_os_disk {
#     name              = "osdisk-${var.project.env}-${var.project.name}-jumphost"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#     disk_size_gb      = "32"
#   }
#   os_profile {
#     computer_name  = "${var.project.env}-${var.project.name}"
#     admin_username = "azureadmin"
#     admin_password = var.vm_password
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
#   tags = {
#     Environment = var.tag.env
#   }
#   depends_on = [ azurerm_subnet.vm,azurerm_network_interface.vm ]
# }


###############################################################################  Windows OS VM    ###############################################################################


resource "azurerm_windows_virtual_machine" "jumphost" {
  name                  = "azwn-${var.project.env}-${var.project.name}"
  resource_group_name   = data.azurerm_resource_group.rg.name
  location              = data.azurerm_resource_group.rg.location
  size                  = var.vm_size
  admin_username        = "azureadmin"
  admin_password        = var.vm_password
  network_interface_ids = [azurerm_network_interface.vm.id]

  os_disk {
    name                 = "osdisk-${var.project.env}-${var.project.name}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = "128"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "win10-22h2-pro-g2"
    version   = "latest"
  }

  tags = {
    Environment = var.tag.env
  }
  depends_on = [azurerm_subnet.vm, azurerm_network_interface.vm]

}