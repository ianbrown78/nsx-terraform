variable "ip_rfc1918" {
  type    = list(string)
  default = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}
variable "dns_servers" {
  type    = list(string)
  default = ["10.10.0.8", "10.10.0.9"]
}

variable "ip_demo" {
  type    = string
  default = "10.1.0.0/24"
}
variable "gw_demo" {
  type    = string
  default = "10.1.0.1/24"
}

variable "ip_demo_dhcp_server" {
  type    = string
  default = "10.2.0.253/24"
}
variable "dhcp_demo_dhcp_range" {
  type    = list(string)
  default = ["10.2.0.10-10.2.0.100"]
}

variable "load_balancer_ip" {
  type    = string
  default = "10.2.0.2"
}
variable "snat_demo_lb" {
  type    = string
  default = "192.168.100.1"
}
variable "hostname1" {
  type    = string
  default = "10.2.0.3"
}
variable "hostname2" {
  type    = string
  default = "10.2.0.4"
}