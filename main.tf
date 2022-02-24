

#create resource group
module "resource_group" {
    source    = "./modules/rg"
    rgname    = var.envset
    location  = var.location
}

