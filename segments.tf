resource "nsxt_policy_segment" "demo" {
  display_name        = "demo_${split(".", var.gw_demo)[2]}"
  description         = "Terraform provisioned segement for demo"
  connectivity_path   = nsxt_policy_tier1_gateway.demo_lb_gateway.path
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_transport_zone.path
  dhcp_config_path    = nsxt_policy_dhcp_server.dhcp_server.path

  subnet {
    cidr        = var.gw_demo
    dhcp_ranges = var.dhcp_demo_dhcp_range

    dhcp_v4_config {
      server_address = var.ip_demo_dhcp_server
      dns_servers    = var.dns_servers
    }
  }
}