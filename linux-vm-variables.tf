# Azure virtual machine settings #
#Definition vm_size Chose one from selected B1 Cheap ->> more expensive
                #Standard_B1ls 
                #Standard_B1s 
                #Standard_B1ms
                #Standard_B2s 
                #Standard_B2ms
                #Standard_B4ms
                #Standard_B8ms
                #Standard_DS3_v2
                # Could be vmsizes = "ssh -i <private key path> linuxadmin@40.127.185.159"
variable "web-linux-vm-size" {
  type        = string
  description = "Size (SKU) of the virtual machine to create"
}
variable "web-linux-license-type" {
  type        = string
  description = "Specifies the BYOL type for the virtual machine."
  default     = null
}
# Azure virtual machine storage settings #
variable "web-linux-delete-os-disk-on-termination" {
  type        = string
  description = "Should the OS Disk (either the Managed Disk / VHD Blob) be deleted when the Virtual Machine is destroyed?"
  default     = "true"  # Update for your environment
}
variable "web-linux-delete-data-disks-on-termination" {
  description = "Should the Data Disks (either the Managed Disks / VHD Blobs) be deleted when the Virtual Machine is destroyed?"
  type        = string
  default     = "true" # Update for your environment
}
variable "web-linux-vm-image" {
  type        = map(string)
  description = "Virtual machine source image information"
  default     = {
    publisher = "Canonical" 
    offer     = "UbuntuServer" 
    sku       = "16.04-LTS" 
    version   = "latest"
  }
}
# Azure virtual machine OS profile #
variable "web-linux-admin-username" {
  type        = string
  description = "Username for Virtual Machine administrator account"
  #default     = ""
}
variable "web-linux-admin-password" {
  type        = string
  description = "Password for Virtual Machine administrator account"
  #default     = "Nsfut6-v7Mccat63A?MRtUzH&67XdQ72"
}
