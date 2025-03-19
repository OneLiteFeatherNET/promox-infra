variable "proxmox" {
  type = object({
    name         = string
    cluster_name = string
    endpoint     = string
    insecure     = bool
    username     = string
    api_token    = string
  })
  sensitive = true
}

variable "oidc" {
  type = object({
    client_id   = string
    groups_claim = string
    groups_prefix = string
    issuer_url  = string
    username_claim = string
  })
  sensitive = true
}