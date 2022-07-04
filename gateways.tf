resource "nsxt_policy_tier1_gateway" "demo_lb_gateway" {
  description = "Demo Tier-1 NLB gateway provisioned by Terraform"
  // The name shown in NSX-T UI
  display_name = "demo-lb-gateway"
  // The name of the edge clluster this T1 will be connected to
  edge_cluster_path = data.nsxt_policy_edge_cluster.ec.path
  // Whether the preferred service router instance for given logical router will preempt the peer. PREEMPTIVE/NON_PREEMPTIVE
  failover_mode = "PREEMPTIVE"
  // Log traffic or not
  default_rule_logging = "true"
  enable_firewall      = "true"
  // Create another T1 on another edge node if this one fails?
  enable_standby_relocation = "false"
  // Path to the T0 we should be connected to
  tier0_path = data.nsxt_policy_tier0_gateway.tier0_router.path
  // List of desired route advert types
  route_advertisement_types = ["TIER1_CONNECTED", "TIER1_NAT", "TIER1_LB_VIP", "TIER1_LB_SNAT"]
  // The TYPE of T1 to provision. THIS IS VERY IMPORTANT! [ROUTING, LB_SMALL, LB_MEDIUM, LB_LARGE, LB_XLARGE]
  pool_allocation = "LB_SMALL"
}