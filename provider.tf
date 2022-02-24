

# Define Terraform provider
 terraform {
#  required_version = ">= 0.14"
   version         = "=2.97.0"
 }


 #Configure the Azure Provider
 provider "azurerm" {
   features {}
   environment     = "public"

 }
