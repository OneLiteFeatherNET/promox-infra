variable "image" {
  description = "Talos image configuration"
  type = object({
    factory_url = optional(string, "https://factory.talos.dev")
    schematic = string
    version   = string
    update_schematic = optional(string)
    update_version = optional(string)
    arch = optional(string, "amd64")
    platform = optional(string, "nocloud")
    proxmox_datastore = optional(string, "local")
  })
}

variable "cluster" {
  description = "Cluster configuration"
  type = object({
    name            = string
    endpoint        = string
    gateway         = string
    talos_version   = string
    proxmox_cluster = string
  })
}

variable "oidc" {
    description = "OIDC configuration"
    type = object({
        client_id   = string
        groups_claim = string
        groups_prefix = string
        issuer_url  = string
        username_claim = string
    })
}

variable "cloudflared" {
    description = "Cloudflared configuration"
    type = object({
        token   = string
        metrics = string
        edge_ip = string
    })
}

variable "nodes" {
  description = "Configuration for cluster nodes"
  type = map(object({
    host_node     = string
    machine_type  = string
    datastore_id = optional(string, "local-lvm")
    ip            = string
    mac_address   = string
    vm_id         = number
    cpu           = number
    ram_dedicated = number
    update = optional(bool, false)
    igpu = optional(bool, false)
  }))
}

variable "cilium" {
  description = "Cilium configuration"
  type = object({
    values  = string
    install = string
  })
}
