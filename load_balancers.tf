resource "nsxt_policy_lb_service" "demo_lb_service" {
  display_name      = "demo-lb-service"
  description       = "Terraform provisioned Service demo-lb-service"
  connectivity_path = nsxt_policy_tier1_gateway.demo_lb_gateway.path
  size              = "SMALL"
  enabled           = true
  error_log_level   = "ERROR"
}

resource "nsxt_policy_lb_pool" "https_virtual_server" {
  display_name       = "https_virtual_server"
  description        = "Terraform provisioned LB Pool https_virtual_server"
  algorithm          = "ROUND_ROBIN"
  min_active_members = 1
  //active_monitor_path  = data.nsxt_policy_lb_monitor.http-monitor.path
  passive_monitor_path = "/infra/lb-monitor-profiles/default-passive-lb-monitor"
  member {
    admin_state                = "ENABLED"
    backup_member              = false
    display_name               = "hostname1"
    ip_address                 = var.hostname1
    max_concurrent_connections = 1000
    port                       = "80"
    weight                     = 1
  }
  member {
    admin_state                = "ENABLED"
    backup_member              = false
    display_name               = "hostname2"
    ip_address                 = var.hostname2
    max_concurrent_connections = 1000
    port                       = "80"
    weight                     = 1
  }
  snat {
    type              = "IPPOOL"
    ip_pool_addresses = [var.snat_demo_lb]
  }
  tcp_multiplexing_enabled = true
  tcp_multiplexing_number  = 8
}

resource "nsxt_policy_lb_virtual_server" "https_redirection" {
  display_name             = "https_redirection"
  description              = "Terraform provisioned Virtual Server"
  access_log_enabled       = true
  application_profile_path = data.nsxt_policy_lb_app_profile.https-redirect.path
  //persistence_profile_path   = data.nsxt_policy_lb_persistence_profile.cookie.path
  enabled                    = true
  ip_address                 = var.load_balancer_ip
  ports                      = ["80"]
  default_pool_member_ports  = ["80"]
  service_path               = nsxt_policy_lb_service.demo_lb_service.path
  max_concurrent_connections = 1000
  max_new_connection_rate    = 200
}

resource "nsxt_policy_lb_virtual_server" "https_virtual_server" {
  display_name               = "https_virtual_server"
  description                = "Terraform provisioned Virtual Server"
  access_log_enabled         = true
  application_profile_path   = data.nsxt_policy_lb_app_profile.http.path
  enabled                    = true
  ip_address                 = var.load_balancer_ip
  ports                      = ["443"]
  default_pool_member_ports  = ["443"]
  service_path               = nsxt_policy_lb_service.demo_lb_service.path
  max_concurrent_connections = 1000
  max_new_connection_rate    = 200
  pool_path                  = nsxt_policy_lb_pool.https_virtual_server.path
}