

# Define Terraform provider
terraform {
  required_providers {
    azurerm = {
      # source  = "hashicorp/azurerm"
      version = "=2.97.0"
    }
  }
}


 #Configure the Azure Provider
 provider "azurerm" {
   features {}
  # environment     = "public"

 }
