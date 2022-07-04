data "nsxt_policy_transport_zone" "overlay_transport_zone" {
  display_name = "TZ-OVERLAY"
}
data "nsxt_policy_tier0_gateway" "tier0_router" {
  display_name = "Provider-LR"
}
data "nsxt_policy_edge_cluster" "ec" {
  display_name = "edge-cluster"
}

///
// Policy Services
///
data "nsxt_policy_service" "svc_icmp" {
  display_name = "ICMP ALL"
}
data "nsxt_policy_service" "svc_rdp" {
  display_name = "RDP"
}
data "nsxt_policy_service" "svc_ssh" {
  display_name = "SSH"
}
data "nsxt_policy_service" "svc_dns-tcp" {
  display_name = "DNS"
}
data "nsxt_policy_service" "svc_dns-udp" {
  display_name = "DNS-UDP"
}