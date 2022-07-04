resource "nsxt_policy_dhcp_server" "dhcp_server" {
  display_name      = "dhcp_server"
  description       = "Terraform provisioned DhcpServerConfig"
  edge_cluster_path = data.nsxt_policy_edge_cluster.ec.path
  lease_time        = 86400
  server_addresses  = [var.ip_demo_dhcp_server]
}