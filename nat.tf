locals {
  demo_segments = [var.ip_demo]

  # There is no way of nesting the for_each in TF but we can flatten the two lists together
  demo_flat_results = distinct(flatten([
    for nat_results in local.demo_segments : [
      for rfc_1918 in var.ip_rfc1918 : {
        rfc_1918    = rfc_1918
        nat_results = nat_results
      }
    ]
  ]))
}

resource "nsxt_policy_nat_rule" "demo_egrss_nosnat" {
  for_each             = { for entry in local.demo_flat_results : "${entry.rfc_1918}.${entry.nat_results}" => entry }
  display_name         = "demo_no_snat"
  action               = "NO_SNAT"
  enabled              = true
  rule_priority        = "300"
  destination_networks = [each.value.rfc_1918]
  source_networks      = [each.value.nat_results]
  translated_networks  = []
  gateway_path         = nsxt_policy_tier1_gateway.demo_lb_gateway.path
  logging              = true
  firewall_match       = "MATCH_INTERNAL_ADDRESS"
}

resource "nsxt_policy_nat_rule" "demo_egress_snat" {
  display_name        = "demo_egress_snat"
  action              = "SNAT"
  enabled             = true
  rule_priority       = "600"
  translated_networks = [var.snat_demo_lb]
  gateway_path        = nsxt_policy_tier1_gateway.demo_lb_gateway.path
  logging             = true
  firewall_match      = "MATCH_INTERNAL_ADDRESS"
}