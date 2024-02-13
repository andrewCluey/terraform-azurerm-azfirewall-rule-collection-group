


module "network_rule_collection" {
  source = "../.."

  name                           = "simple_example"
  priority                       = 100
  firewall_policy_name           = "default_fw_policy"
  firewall_policy_resource_group = "rg-firewall-01"
  
  network_rule_collection = {
    name     = "rule_collection_group_demo"
    action   = "Allow"
    priority = 10
    rules = [
      {
        name                  = "demo_rule_1"
        description           = "Example Rule within a new net rule colelction group."
        source_ip_groups      = ["ipg-demo"]
        destination_ip_groups = ["ipg-demo-dst"]
        destination_ports     = ["443"]
        protocols             = ["TCP"]
      },
      {
        name                  = "demo_rule_2"
        description           = "A second rule within the new net rule collection group."
        source_addresses      = ["10.0.0.0/24"]
        destination_ip_groups = ["ipg-web"]
        destination_ports     = ["443", "80"]
        protocols             = ["TCP"]
      }
    ]
  }

}