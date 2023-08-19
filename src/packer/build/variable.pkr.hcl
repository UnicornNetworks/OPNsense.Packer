variable "boot_key_interval" {
  type    = string
  default = "20ms"
}

variable "boot_wait" {
  type    = string
  default = "1m5s"
}

variable "config_file" {
  type    = string
  default = "config.xml"
}

variable "disk_size" {
  type    = string
  default = "8192"
}

variable "headless" {
  type    = string
  default = "false"
}

# opnsense.iso
variable "iso_sha256_checksum" {
  type    = string
  default = "sha256:48dda72ffedbc875683b68330d001a0b9291536a393999704f94189e8545d331"
}
variable "iso_url" {
  type    = string
  default = "opnsense.iso"
}

# Hardware
variable "memory" {
  type    = string
  default = "2000"
}

# qemu
variable "accelerator" {
  type    = string
  default = "kvm"
}

variable "qemu_binary" {
  type    = string
  default = null
}
variable "qemu_display" {
  type    = string
  default = "none"
}

variable "qemu_machine_type" {
  type    = string
  default = "q35"
}

variable "qemuargs" {
  type    = list(list(string))
  default = null
}

# Output
variable "os_name" {
  type    = string
  default = "OPNsense"
}

variable "os_version" {
  type    = string
  default = "23.7"
}

variable "os_arch" {
  type    = string
  default = "x86_64"
}

# Network
variable "bridge_interface" {
  type    = string
  default = "br0"
}