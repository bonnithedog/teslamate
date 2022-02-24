

# Define Terraform provider
# terraform {
#  required_version = ">= 0.14"
# }


 #Configure the Azure Provider
 provider "azurerm" {
   features {}
   version         = "=2.97.0"
   environment     = "public"

 }
