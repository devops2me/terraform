resource "azurerm_resource_group" "myrg" {
  name     = "${var.environment}-${var.resoure_group_location}-rg"
  location = var.resoure_group_location
}