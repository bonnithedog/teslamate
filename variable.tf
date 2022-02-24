

  
# Variable for seperate environment 
variable "envset" {
    type = string
    description = "Name environment settings for demo test or prod"
    default = "Tesla-Mate"
}

# Variable to st location of datasenter to use
variable "location" {
    type = string
    description = "Location datasenter"
    default = "northeurope"
}
