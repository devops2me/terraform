
variable "environment" {
  description = "Environment Name"
  type        = string
  default     = "dev"
}

variable "resoure_group_location" {
  description = "Resource Group Location"
  type        = string
  default     = "East US"
}

variable "nic_count" {
  description = "NIC count in subnet"
  type        = string
}

variable "storage_count" {
  description = "NIC count in subnet"
  type        = string
}

variable "virtual_network_address_space" {
  description = "Virtual Network Address Space"
  type        = list(string)
  default     = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"]
}

variable "subnet-names" {
  description = "Subenet Address space for mapping with subnets"
  type        = map(any)
  default = {

    subnet_1 = {
      subnet_name   = "app-subnet1"
      subnet_prefix = ["10.2.0.0/16"]
    }
    subnet_2 = {
      subnet_name   = "web-subnet2"
      subnet_prefix = ["10.3.0.0/24"]
    }
  }
}