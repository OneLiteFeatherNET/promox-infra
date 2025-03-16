variable "proxmox_url" {
  type = string                     # The type of the variable, in this case a string
  default = "https://proxmox-server01.example.com:8006/api2/json"
  description = "Proxmox URL"
}