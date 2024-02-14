
variable "name" {
  type        = string
  description = "The name to assign to the new Rule Collection Group"
}

variable "firewall_policy_name" {
  type        = string
  description = "The name of the firewall policy where the new Rule Collection Group will be created."
}

variable "firewall_policy_resource_group" {
  type        = string
  description = "The name of the Resource Group where the Firewall policy resides."
}

variable "priority" {
  type        = number
  description = "The Priority to assign to the new Rule Collection Group being created."
}


variable "network_rule_collections" {
  default = []
  type = list(object({
    name     = string
    action   = string
    priority = number
    rules = optional(list(object({
      name                  = string
      description           = optional(string, null)
      protocols             = list(string)
      source_addresses      = optional(list(string))
      source_ip_groups      = optional(list(string))
      destination_ports     = list(number)
      destination_fqdns     = optional(list(string))
      destination_ip_groups = optional(list(string))
      destination_addresses = optional(list(string))
    })))
  }))
}



variable "application_rule_collections" {
  default = []
  type = list(object({
    name     = string
    action   = string
    priority = number
    rules = optional(list(object({
      name        = string
      description = optional(string, null)
      protocols = object({
        type = string # "http" or "https"
        port = number
      })
      source_addresses      = optional(list(string))
      source_ip_groups      = optional(list(string))
      destination_fqdn_tags = optional(list(string))
      destination_fqdns     = optional(list(string))
      destination_urls      = optional(list(string))
      destination_addresses = optional(list(string))
    })))
  }))
}
