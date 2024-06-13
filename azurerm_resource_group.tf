# resource "azurerm_resource_group" "rg" {
#   name     = "rg-${var.project.env}-${var.project.name}"
#   location = var.project.location

#   tags = {
#     Environment = var.tag.env
#   }
# }