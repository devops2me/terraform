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
| network.tf | added the Vnet, Subnets, PIP and NIC creation code block. |
| storage.tf | added storage creation code block with randowm name so that name conflicts should not occure. |
| variables.tf | Defined variable for usage accross the terraform |
| pe-dns.tf | Private endpoints and Privated dns records creation with blob and dfs|
| input.tfvars| input variables references|


Variables Definition:-

- environment                   = "dev"  -> Type of environment
- resoure_group_location        = "eastus2" -> Region
- virtual_network_address_space = [ "10.0.0.0/16"]  -> Vnet CIDR range to create Base VNet with in the region
- torage_count                 = "2" -> No of storage accounts to created with in the same storage account
- nic-config                     = nic-1 = {     nic-name  = "nic1"     public-ip = true  }  -> No of NIC's config to toggle in beteen Public IP
- subnet-names                  =      -> map for subnets creation as per the no of requirment and we can add the deligation according to subnet requirement


###Resouces Definition

all the resourcess names are auto generated and will be appended with the environment name find below screen shot for created resources

![image](https://user-images.githubusercontent.com/123788787/215660489-d7df84f6-9d71-4bd2-aa28-9a4ff756b9d3.png)

![image](https://user-images.githubusercontent.com/123788787/215660768-af7ed80f-265e-4d20-9d28-f0bdd90a03fb.png)


