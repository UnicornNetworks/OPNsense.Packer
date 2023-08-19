variable "boot_command" {
  type    = list(string)
  default = [
    // Login live iso
    "installer<enter><wait500ms>opnsense<enter><wait2s>",
    "<wait1h>"
  ]
}

variable "boot_steps" {
  type    = list(list(string))
  default = [
    ["installer<enter><wait500ms>opnsense<enter><wait2s>", "Login live iso"],
    ["<enter><wait2s><enter><wait2s><enter><wait2s>", "accept defaults"],
    ["<left><wait300ms><enter><wait2s><wait1m50s>", "Installing"],
    ["<down><enter><wait50s>","Complete install"],
    ["root<enter>opnsense<enter><wait1s>","Login"],
    ["8<enter><wait5s>", "8) Shell"],
    ["dhclient vtnet0<enter><wait6>", "DHCP"],
    // 
    ["telnet {{ .HTTPIP }} {{ .HTTPPort }} | sed '1,/^$/d' >/conf/config.xml<wait><enter>", "Telnet config"],
    ["GET /{{user `config_file`}} HTTP/1.0<enter><enter>", "Fetch config file"],
    // 
    ["echo 'PasswordAuthentication yes' >> /usr/local/etc/ssh/sshd_config<enter>", "enable PasswordAuthentication"],
    ["service openssh onestart<enter>", "start SSHD service"]
    ["<wait1h>","wait indefinitely"]
  ]
  //*Not used
  // ["<enter><wait1s>vagrant<enter><wait1s>vagrant<enter><wait20s>","Change root password"],
  // ["root<enter><wait1s>opnsense<enter><wait2s>5<enter><wait1s>y<enter><wait30s>","Login & Shutdown ..."]
}

#------------------------
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