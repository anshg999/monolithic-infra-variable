resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  depends_on               = [azurerm_resource_group.rg]
}
resource "azurerm_storage_container" "container" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
  depends_on            = [azurerm_storage_account.storage]
}

# resource "azurerm_storage_blob" "blob" {
#   name                   = var.storage_blob_name
#   storage_account_name   = azurerm_storage_account.storage.name
#   storage_container_name = azurerm_storage_container.container.name
#   type                   = "Block"
#   source                 = "some-local-filepath"
#   depends_on             = [azurerm_storage_account.storage]
# }

resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  address_space       = var.virtual_network_address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  depends_on          = [azurerm_resource_group.rg]
}
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  resource_group_name  = azurerm_resource_group.rg.name
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_network_interface" "nic" {
  name                = var.network_interface_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  depends_on          = [azurerm_subnet.subnet]
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_virtual_machine" "vm" {
  name                  = var.virtual_machine_name
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  vm_size               = var.virtual_machine_size
  network_interface_ids = [azurerm_network_interface.nic.id]

  os_profile {
    computer_name  = var.virtual_machine_name
    admin_username = var.virtual_machine_admin_username
    admin_password = var.virtual_machine_admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
