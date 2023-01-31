
# Create Private DNS Zone
resource "azurerm_private_dns_zone" "blob-zone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.myrg.name
}

# Create Private BLOB DNS Zone Network Link
resource "azurerm_private_dns_zone_virtual_network_link" "blob-network_link" {
  name                  = "vnl-withd-zone1"
  resource_group_name   = azurerm_resource_group.myrg.name
  private_dns_zone_name = azurerm_private_dns_zone.blob-zone.name
  virtual_network_id    = azurerm_virtual_network.myvnet.id
}

# Create Private DNS Zone
resource "azurerm_private_dns_zone" "dfs-zone" {
  name                = "privatelink.dfs.core.windows.net"
  resource_group_name = azurerm_resource_group.myrg.name
}

# Create Private DNS Zone Network Link
resource "azurerm_private_dns_zone_virtual_network_link" "dfs-network_link" {
  name                  = "vnl-withd-zone1"
  resource_group_name   = azurerm_resource_group.myrg.name
  private_dns_zone_name = azurerm_private_dns_zone.dfs-zone.name
  virtual_network_id    = azurerm_virtual_network.myvnet.id
}



resource "azurerm_private_endpoint" "pestorage" {
  count=var.storage_count
  name                = "${var.environment}-${var.resoure_group_location}-pe-0${count.index}"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  subnet_id           = azurerm_subnet.mysubnet["pesubnet"].id

  private_service_connection {
    name                           = "${var.environment}-${var.resoure_group_location}-peservice-0${count.index}"
    private_connection_resource_id = azurerm_storage_account.mystorage[count.index].id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

}


resource "azurerm_private_dns_a_record" "blob-a-record" {
  count=var.storage_count
  name                = "${var.environment}-${var.resoure_group_location}-dnsarecord0${count.index}"
  zone_name           = azurerm_private_dns_zone.blob-zone.name
  resource_group_name = azurerm_resource_group.myrg.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.pestorage[count.index].private_service_connection.0.private_ip_address]
}

## Creae PE for DFS storage resource type
resource "azurerm_private_endpoint" "pedfs" {
  count=var.storage_count
  name                = "${var.environment}-${var.resoure_group_location}-dfspe-0${count.index}"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  subnet_id           = azurerm_subnet.mysubnet["pesubnet"].id

  private_service_connection {
    name                           = "${var.environment}-${var.resoure_group_location}-pedfsservice-0${count.index}"
    private_connection_resource_id = azurerm_storage_account.mystorage[count.index].id
    is_manual_connection           = false
    subresource_names              = ["dfs"]
  }

}

resource "azurerm_private_dns_a_record" "dfs-a-record" {
  count=var.storage_count
  name                = "${var.environment}-${var.resoure_group_location}-dnsarecord0${count.index}"
  zone_name           = azurerm_private_dns_zone.dfs-zone.name
  resource_group_name = azurerm_resource_group.myrg.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.pedfs[count.index].private_service_connection.0.private_ip_address]
}