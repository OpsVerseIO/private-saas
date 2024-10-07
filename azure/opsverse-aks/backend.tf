terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 4.4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "<->"         # Resource group of pre-created storage account for storing Terraform state.
    storage_account_name = "<->"         # Storage account name
    container_name       = "<->"         # Container name
    key                  = "<->.tfstate" # Terraform state file to store in the above container 
  }
}

provider "azurerm" {
  features {}
}
