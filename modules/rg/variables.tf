
# Variable for resource group
variable "rgname" {
    type = string
    description = "Name of resource group"
}

# Variable to st location of datasenter to use
variable "location" {
    type = string
    description = "Azure location of storage account environment"
    default = "westus2"
}