### Terraform Tasks 
* Resource group
* VNET and 2 subnets, NIC
* Storage account

Variables Definition:-

- environment                   = "dev"  -> Type of environment
- resoure_group_location        = "eastus2" -> Region
- virtual_network_address_space = [ "10.0.0.0/16"]  -> Vnet CIDR range to create Base VNet with in the region
- torage_count                 = "2" -> No of storage accounts to created with in the same storage account
- nic_count                     = "3"  -> No of NIC's to be creation count
- subnet-names                  =      -> map for subnets creation as per the no of requirment and we can add the deligation according to subnet requirement
