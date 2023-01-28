# Virtual Network
resource "azurerm_virtual_network" "myvnet" {
  name                = "${var.environment}-${var.resoure_group_location}-vnet"
  address_space       = var.virtual_network_address_space
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}

# Subnet
resource "azurerm_subnet" "mysubnet" {
  for_each             = var.subnet-names
  name                 = "${azurerm_virtual_network.myvnet.name}-${each.value["subnet_name"]}"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = each.value["subnet_prefix"]
}

#  Network Interface
resource "azurerm_network_interface" "myvmnic" {
  count               = var.nic_count
  name                = "${azurerm_virtual_network.myvnet.name}-vmnic-0${count.index}"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet["subnet_1"].id
    private_ip_address_allocation = "Dynamic"
  }
}

