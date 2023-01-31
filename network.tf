# Virtual Network
resource "azurerm_virtual_network" "myvnet" {
  name                = "${var.environment}-${var.resoure_group_location}-vnet"
  address_space       = var.virtual_network_address_space
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}

# Subnet
resource "azurerm_subnet" "mysubnet" {
  for_each                                       = var.subnet-names
  name                                           = "${azurerm_virtual_network.myvnet.name}-${each.value["subnet_name"]}"
  resource_group_name                            = azurerm_resource_group.myrg.name
  virtual_network_name                           = azurerm_virtual_network.myvnet.name
  enforce_private_link_endpoint_network_policies = each.value["pe_enabled"]
  address_prefixes                               = each.value["subnet_prefix"]
  dynamic "delegation" {
    for_each = each.value["delegations"] == null ? [] : each.value["delegations"]
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }


  }
}

resource "azurerm_public_ip" "mypip" {
  name                = "${var.environment}-${var.resoure_group_location}-publicip"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  allocation_method   = "Static"
  depends_on = [
    azurerm_resource_group.myrg
  ]
}

#  Network Interface
resource "azurerm_network_interface" "myvmnic" {
  for_each            = var.nic-config
  name                = "${azurerm_virtual_network.myvnet.name}-${each.value["nic-name"]}"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "internal0"
    subnet_id                     = azurerm_subnet.mysubnet["subnet_1"].id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id          = try(each.value["public-ip"], null) == true ? azurerm_public_ip.mypip.id : ""

  }
  ip_configuration {
    name                          = "internal1"
    subnet_id                     = azurerm_subnet.mysubnet["subnet_1"].id
    private_ip_address_allocation = "Dynamic"
    primary                       = false
  }
  depends_on = [
    azurerm_public_ip.mypip
  ]

}

