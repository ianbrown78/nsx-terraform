locals {
  demo_rules = [
    ///
    // Ingress Rules
    ///
    {
      display_name       = "Ingress ICMP"
      action             = "ALLOW"
      services           = [data.nsxt_policy_service.svc_icmp.path]
      source_groups      = [nsxt_policy_group.rfc1918.path]
      destination_groups = null
    },
    {
      display_name       = "Ingress RDP"
      action             = "ALLOW"
      services           = [data.nsxt_policy_service.svc_rdp.path]
      source_groups      = [nsxt_policy_group.rfc1918.path]
      destination_groups = null
    },
    {
      display_name       = "Ingress SSH"
      action             = "ALLOW"
      services           = [data.nsxt_policy_service.svc_ssh.path]
      source_groups      = null
      destination_groups = [nsxt_policy_group.demo_network.path]
    },
    {
      display_name       = "DNS"
      action             = "ALLOW"
      services           = [data.nsxt_policy_service.svc_dns-udp.path, data.nsxt_policy_service.svc_dns-tcp.path]
      source_groups      = [nsxt_policy_group.rfc1918.path]
      destination_groups = [nsxt_policy_group.demo_network.path]
    },
    {
      display_name       = "Drop all ingress"
      action             = "DROP"
      services           = null
      source_groups      = null
      destination_groups = [nsxt_policy_group.demo_network.path]
    },

    ///
    // Egress Rules
    ///
    {
      display_name       = "Drop all egress"
      action             = "DROP"
      services           = null
      source_groups      = [nsxt_policy_group.demo_network.path]
      destination_groups = null
    }
  ]
}

resource "nsxt_policy_gateway_policy" "demo_gateway_policy" {
  display_name    = "demo-gateway-policy"
  description     = "Terraform provisioned Demo Gateway Policy"
  category        = "LocalGatewayRules"
  locked          = true
  sequence_number = 3
  stateful        = true
  tcp_strict      = false

  dynamic "rule" {
    for_each = local.demo_rules
    content {
      display_name       = rule.value.display_name
      action             = rule.value.action
      services           = rule.value.services
      destination_groups = rule.value.destination_groups
      source_groups      = rule.value.source_groups
      logged             = true
      scope              = [nsxt_policy_tier1_gateway.demo_lb_gateway.path]
    }
  }
}