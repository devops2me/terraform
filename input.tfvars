environment                   = "dev"
resoure_group_location        = "eastus2"
virtual_network_address_space = ["10.3.0.0/16", "10.0.0.0/16"]
storage_count                 = "2"
nic-config = {
  nic-1 = {
    nic-name  = "nic1"
    public-ip = true  }
  nic-2 = {
    nic-name = "nic2" }
}
subnet-names = { subnet_1 = {
  subnet_name   = "app-subnet1"
  subnet_prefix = ["10.0.0.0/24"]
  }
  subnet_2 = {
    subnet_name   = "web-subnet2"
    subnet_prefix = ["10.0.1.0/24"]
    delegations = [
      {
        name = "appservice-delegation"
        service_delegation = {
          name    = "Microsoft.Web/serverFarms"
          actions = ["Microsoft.Network/virtualNetworks/subnets/action", ]
        }
      }
    ]
  }
  pesubnet = {
    subnet_name   = "pe-subnet1"
    subnet_prefix = ["10.0.2.0/24"]
    pe_enabled    = true
  }
  dbsubnet = {
    subnet_name   = "db-subnet1"
    subnet_prefix = ["10.0.3.0/24"]
    delegations = [
      {
        name = "Microsoft.Sql.managedInstances"
        service_delegation = {
          name = "Microsoft.Sql/managedInstances"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
            "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
            "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
          ]
        }
      }
    ]
  }
}