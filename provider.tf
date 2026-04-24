terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.70.0"
    }
  }
     backend "azurerm" {
       resource_group_name= "prodansh"
       storage_account_name= "ansh09876"
       container_name= "ansh"
       key= "tfstate"

    }
}
provider "azurerm" {
  features {}
  subscription_id = "7f9ffab5-15de-40df-80c3-9f0897275cd1"
}



