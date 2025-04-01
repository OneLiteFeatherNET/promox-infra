module "talos" {
  source = "./talos"

  providers = {
    proxmox = proxmox
  }

  image = {
    version = "v1.9.5"
    schematic = file("${path.module}/talos/image/schematic.yaml")
  }

  cilium = {
    install = file("${path.module}/talos/inline-manifests/cilium-install.yaml")
    values = file("${path.module}/kubernetes/cilium/values.yml")
  }

  cluster = {
    name            = "entenhausen"
    endpoint        = "10.200.4.100"
    gateway         = "10.200.4.1"
    talos_version   = "v1.9.5"
    proxmox_cluster = "entenhausen"
  }

  oidc = {
    client_id   = var.oidc.client_id
    groups_claim = var.oidc.groups_claim
    groups_prefix = var.oidc.groups_prefix
    issuer_url  = var.oidc.issuer_url
    username_claim = var.oidc.username_claim
  }

  cloudflared = {
    token   = var.cloudflared.token
    metrics = var.cloudflared.metrics
    edge_ip = var.cloudflared.edge_ip
  }

  nodes = {
    "duesentrieb" = {
      host_node     = "pve-01"
      machine_type  = "controlplane"
      ip            = "10.200.4.100"
      mac_address   = "BC:24:11:2E:C8:00"
      vm_id         = 800
      cpu           = 8
      ram_dedicated = 4096
    }
    "dagobert" = {
      host_node     = "pve-01"
      machine_type  = "controlplane"
      ip            = "10.200.4.101"
      mac_address   = "BC:24:11:2E:C8:01"
      vm_id         = 801
      cpu           = 4
      ram_dedicated = 4096
    }
    "donald" = {
      host_node     = "pve-01"
      machine_type  = "controlplane"
      ip            = "10.200.4.102"
      mac_address   = "BC:24:11:2E:C8:02"
      vm_id         = 802
      cpu           = 4
      ram_dedicated = 4096
    }
    "tick" = {
      host_node     = "pve-01"
      machine_type  = "worker"
      ip            = "10.200.4.50"
      mac_address   = "BC:24:11:2E:08:00"
      vm_id         = 810
      cpu           = 8
      ram_dedicated = 4096
    }

    "trick" = {
      host_node     = "pve-01"
      machine_type  = "worker"
      ip            = "10.200.4.51"
      mac_address   = "BC:24:11:2E:08:01"
      vm_id         = 811
      cpu           = 8
      ram_dedicated = 4096
    }

    "track" = {
      host_node     = "pve-01"
      machine_type  = "worker"
      ip            = "10.200.4.52"
      mac_address   = "BC:24:11:2E:08:02"
      vm_id         = 812
      cpu           = 8
      ram_dedicated = 4096
    }

    "daisy" = {
      host_node     = "pve-01"
      machine_type  = "worker"
      ip            = "10.200.4.53"
      mac_address   = "BC:24:11:2E:08:03"
      vm_id         = 813
      cpu           = 4
      ram_dedicated = 4096
    }

    "dussel" = {
      host_node     = "pve-01"
      machine_type  = "worker"
      ip            = "10.200.4.54"
      mac_address   = "BC:24:11:2E:08:04"
      vm_id         = 814
      cpu           = 4
      ram_dedicated = 4096
    }
  }
}

module "proxmox_csi_plugin" {
  depends_on = [module.talos]
  source = "./bootstrap/proxmox-csi-plugin"

  providers = {
    proxmox    = proxmox
    kubernetes = kubernetes
  }

  proxmox = var.proxmox
}

