### Terraform Tasks 
* Resource group
* VNET and 2 subnets, NIC
* Storage account
# 01/30

# VNET –
* Subnet module - should handle delegated networks as well
* Network interface module – should have option to provision multiple IP to NIC and public IP (optional)
* Storage account – create private endpoints for blob and dfs




| File Name | Usage |
| ----------- | ----------- |
| rg.tf | added resource group cration definition. |
| network.tf | added the Vnet, Subnets, NIC creation code block. |
| storage.tf | added storage creation code block with randowm name so that name conflicts should not occure. |
| variables.tf | Defined variable for usage accross the terraform |
|input.tfvars| input variables references|



Variables Definition:-

- environment                   = "dev"  -> Type of environment
- resoure_group_location        = "eastus2" -> Region
- virtual_network_address_space = [ "10.0.0.0/16"]  -> Vnet CIDR range to create Base VNet with in the region
- torage_count                 = "2" -> No of storage accounts to created with in the same storage account
- nic_count                     = "3"  -> No of NIC's to be creation count
- subnet-names                  =      -> map for subnets creation as per the no of requirment and we can add the deligation according to subnet requirement


###Resouces Definition

all the resourcess names are auto generated and will be appended with the environment name find below screen shot for created resources

![image](https://user-images.githubusercontent.com/123788787/215238916-6b352ad0-ce92-41b8-9468-7782b17bb6d2.png)

![image](https://user-images.githubusercontent.com/123788787/215238962-e6f14623-d27d-4c2e-9276-93bb29e34b3d.png)

