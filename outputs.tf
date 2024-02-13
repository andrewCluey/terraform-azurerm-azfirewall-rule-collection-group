

output "rule_collection_group_name" {
  value = azurerm_firewall_policy_rule_collection_group.main.name
}

output "rule_collection_group_id" {
  value = azurerm_firewall_policy_rule_collection_group.main.id
}

output "rule_collection_group_priority" {
  value = azurerm_firewall_policy_rule_collection_group.main.priority
}