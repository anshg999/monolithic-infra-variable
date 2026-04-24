variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}
variable "location" {
  description = "The location of the resource group."
  type        = string
}
variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}
variable "storage_container_name" {
  description = "The name of the storage container."
  type        = string
}
# variable "storage_blob_name" {
#   description = "The name of the storage blob."
#   type        = string
# }
variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}
variable "virtual_network_address_space" {
  description = "The address space of the virtual network."
  type        = list(string)
}
variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}
# variable "address_prefix" {
#   description = "The address prefix of the subnet."
#   type        = list(string)
# }
variable "network_interface_name" {
  description = "The name of the network interface."
  type        = string
}
variable "virtual_machine_name" {
  description = "The name of the virtual machine."
  type        = string
}
variable "virtual_machine_size" {
  description = "The size of the virtual machine."
  type        = string
}
variable "virtual_machine_admin_username" {
  description = "The admin username of the virtual machine."
  type        = string
}
variable "virtual_machine_admin_password" {
  description = "The admin password of the virtual machine."
  type        = string
}
variable "local_file_path" {
  type    = string
  default = "path/to/local/file.txt"
}
