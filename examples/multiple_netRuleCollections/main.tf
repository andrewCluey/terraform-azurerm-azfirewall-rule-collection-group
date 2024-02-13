




module "multi_net_rule_collections" {
  source = "../.."

  name                           = "multiple_net_rule_collections"
  priority                       = 100
  firewall_policy_name           = "default_fw_policy"
  firewall_policy_resource_group = "rg-firewall-01"
  
  network_rule_collections = [
    {
      name     = "web_server_rule_collection"
      action   = "Allow"
      priority = 100
      rules = [
        {
          name                  = "demo_rule_1"
          description           = "Example Rule within a new net rule collection group."
          source_ip_groups      = ["ipg-demo"]
          destination_ip_groups = ["ipg-demo-dst"]
          destination_ports     = ["443"]
          protocols             = ["TCP"]
        },
        {
          name                  = "demo_rule_2"
          description           = "A second rule within the web server net rule collection."
          source_addresses      = ["10.0.0.0/24"]
          destination_ip_groups = ["ipg-web"]
          destination_ports     = ["443", "80"]
          protocols             = ["TCP"]
        }
      ]
    },
    {
      name     = "core_infra_rule_collection"
      action   = "Allow"
      priority = 200
      rules = [
        {
          name                  = "dns"
          description           = "A DNS rule within a second net rule collection."
          source_ip_groups      = ["ipg-servers"]
          destination_ip_groups = ["ipg-dns"]
          destination_ports     = ["53"]
          protocols             = ["TCP", "UDP"]
        }
      ]
    }
  ]
}