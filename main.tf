
# lookup
data "azurerm_firewall_policy" "main" {
  name                = var.firewall_policy_name
  resource_group_name = var.firewall_policy_resource_group
}


resource "azurerm_firewall_policy_rule_collection_group" "main" {
  name               = var.name
  firewall_policy_id = data.azurerm_firewall_policy.main.id
  priority           = var.priority

  dynamic "network_rule_collection" {
    for_each = var.network_rule_collections
    content {
      name     = network_rule_collection.value.name
      action   = network_rule_collection.value.action
      priority = network_rule_collection.value.priority
      dynamic "rule" {
        for_each = network_rule_collection.value.rules
        content {
          name                  = rule.value.name
          description           = lookup(rule.value, "description", null)         # string
          protocols             = rule.value.protocols                            # list Any of [Any, TCP, UDP, ICMP] 
          source_addresses      = lookup(rule.value, "source_addresses", [])      # list EXAMPLE - ["10.0.0.0/16",]
          source_ip_groups      = lookup(rule.value, "source_ip_groups", [])      # list
          destination_ports     = rule.value.destination_ports                    # list EXAMPLE - ["53",]
          destination_fqdns     = lookup(rule.value, "destination_fqdns", [])     # list (DNS Proxy must be enabled to use FQDNs.)
          destination_ip_groups = lookup(rule.value, "destination_ip_groups", []) # list
          destination_addresses = lookup(rule.value, "destination_addresses", []) # list EXAMPLE -  ["8.8.8.8","8.8.4.4",]
        }
      }
    }
  }

  dynamic "application_rule_collection" {
    for_each = var.application_rule_collections
    content {
      name     = application_rule_collection.value.name
      action   = application_rule_collection.value.action
      priority = application_rule_collection.value.priority

      dynamic "rule" {
        for_each = application_rule_collection.value.rules
        content {
          name        = rule.value.name
          description = rule.value.description
          dynamic "protocols" {
            for_each = rule.value.protocols
            content {
              type = protocols.value.type
              port = protocols.value.port
            }
          }
          source_addresses      = lookup(rule.value, "source_addresses", [])
          source_ip_groups      = lookup(rule.value, "source_ip_groups", [])
          destination_fqdn_tags = lookup(rule.value, "destination_fqdn_tags", [])
          destination_fqdns     = lookup(rule.value, "destination_fqdns", [])
          destination_urls      = lookup(rule.value, "destination_urls", [])
          destination_addresses = lookup(rule.value, "destination_addresses", [])
        }

      }
    }

  }

}