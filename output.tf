output "azure_subnet_id" {
  value = {
    for id in keys(var.subnet-names) : id => azurerm_subnet.mysubnet[id].id
  }
  description = "List out all id of subnets"
}