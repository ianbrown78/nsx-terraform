terraform {
  required_providers {
    nsxt = {
      source = "vmware/nsxt"
    }
  }
}

provider "nsxt" {
  host                 = var.nsx_hostname
  username             = var.nsx_username
  password             = var.nsx_password
  allow_unverified_ssl = true
}