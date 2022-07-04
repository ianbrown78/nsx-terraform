data "nsxt_policy_transport_zone" "overlay_transport_zone" {
  display_name = "TZ-OVERLAY"
}
data "nsxt_policy_tier0_gateway" "tier0_router" {
  display_name = "Provider-LR"
}
data "nsxt_policy_edge_cluster" "ec" {
  display_name = "edge-cluster"
}

data "nsxt_policy_lb_app_profile" "http" {
  type = "HTTP"
  display_name = "default-http-lb-app-profile"
}
data "nsxt_policy_lb_app_profile" "https-redirect" {
  type = "HTTP"
  display_name = "https-redirect"
}
data "nsxt_policy_lb_persistence_profile" "cookie" {
  type = "COOKIE"
  display_name = "default-cookie-lb-persistence-profile"
}

data "nsxt_policy_lb_monitor" "http-monitor" {
  type = "HTTP"
  display_name = "default-http-lb-monitor"
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