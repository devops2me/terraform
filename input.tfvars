environment                   = "dev"
resoure_group_location        = "eastus2"
virtual_network_address_space = ["10.3.0.0/16", "10.0.0.0/16"]
storage_count                 = "2"
nic_count                     = "3"
subnet-names                  = {subnet_1 = {
                                                subnet_name   = "app-subnet1"
                                                subnet_prefix = ["10.0.0.0/24"]
                                              }
                                 subnet_2 = {
                                                subnet_name   = "web-subnet2"
                                                subnet_prefix = ["10.0.1.0/24"]
                                              }
                                }