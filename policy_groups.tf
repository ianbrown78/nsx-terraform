resource "nsxt_policy_group" "rfc1918" {
  display_name = "rfc1918"
  description  = "List of IP rfc1918"
  criteria {
    ipaddress_expression {
      ip_addresses = var.ip_rfc1918
    }
  }
}

resource "nsxt_policy_group" "demo_network" {
  display_name = "demo_network"
  description  = "demo_network"
  criteria {
    ipaddress_expression {
      ip_addresses = [var.ip_demo]
    }
  }
}

resource "nsxt_policy_group" "vm-name-pg" {
  display_name = "VM Name Policy Group"
  description  = "Test group to try FW rules by name instead of IP"
  criteria {
    condition {
      key         = "Name"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "demo-01"
    }
  }
}

resource "nsxt_policy_group" "segment-name-pg" {
  display_name = "Segment Name Policy Group"
  description  = "Test group to try FW rules by name instead of IP"
  criteria {
    condition {
      key         = "Tag"
      member_type = "Segment"
      operator    = "EQUALS"
      value       = "dev|environment"
    }
  }
}