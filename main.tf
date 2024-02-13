
# lookup
data "azurerm_firewall_policy" "main" {
    name = var.firewall_policy_name
    resource_group_name = var.firewall_policy_resource_group
}


resource "azurerm_firewall_policy_rule_collection_group" "main" {
  name               = var.name
  firewall_policy_id = data.azurerm_firewall_policy.main.id
  priority           = var.priority

  dynamic "network_rule_collection" {
    for_each = var.network_rule_collection
    content {
      name     = network_rule_collection.value.name
      action   = network_rule_collection.value.action
      priority = network_rule_collection.value.priority
      dynamic "rule" {
        for_each = network_rule_collection.value.rule
        content {
          name                  = rule.value.name
          description           = lookup(rule.value, "description", null)           # string
          protocols             = rule.value.protocols                              # list Any of [Any, TCP, UDP, ICMP] 
          source_addresses      = lookup(rule.value, "source_addresses", [])        # list EXAMPLE - ["10.0.0.0/16",]
          source_ip_groups      = lookup(rule.value, "source_ip_groups", [])        # list
          destination_ports     = rule.value.destination_ports                      # list EXAMPLE - ["53",]
          destination_fqdns     = lookup(rule.value, "destination_fqdns", null)     # list (DNS Proxy must be enabled to use FQDNs.)
          destination_ip_groups = lookup(rule.value, "destination_ip_groups", null) # list
          destination_addresses = lookup(rule.value, "destination_addresses", null) # list EXAMPLE -  ["8.8.8.8","8.8.4.4",]
        }
      }
    }
  }

}