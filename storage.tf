resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_storage_account" "mystorage" {
  count=var.storage_count
  name                     = "${var.environment}${var.resoure_group_location}${random_string.random.result}0${count.index}"
  resource_group_name      = azurerm_resource_group.myrg.name
  location                 = azurerm_resource_group.myrg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "var.environment"
  }
}