packer {
  required_plugins {
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = "~> 1"
    }
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
  }
}

source "qemu" "opnsense" {
  // boot_command      = "${var.boot_command}"
  boot_steps      = "${var.boot_steps}"
  boot_wait         = "${var.boot_wait}"
  disk_size         = "${var.disk_size}"
  // guest_additions_mode = "disable"
  // guest_os_type        = "FreeBSD_64"
  headless          = "${var.headless}"
  http_directory    = "http"
  iso_checksum      = "${var.iso_sha256_checksum}"
  // iso_checksum_type    = "sha256"
  iso_urls          = ["${path.root}/../iso/${var.iso_url}"]
  // keep_registered      = false
  output_directory  = "output/qemu"
  shutdown_timeout  = "1m30s"     // post_shutdown_delay
  shutdown_command  = "shutdown -p now"
  // skip_export       = false
  ssh_password      = "opnsense"
  ssh_username      = "root"
  ssh_timeout       = "20m"
  vm_name           = "opnsense"
  net_device        = "virtio-net"
  disk_interface    = "virtio"
  //* Hardware
  memory            = "${var.memory}"
  cpus              = "2"

  //* KVM Specific
  format            = "qcow2"
  accelerator       = "${var.accelerator}"
  machine_type      = "${var.qemu_machine_type}"

  //* Boot
  boot_key_interval = "${var.boot_key_interval}"
}

build {
  sources = ["source.qemu.opnsense"]

  # Convert machines to vagrant boxes
  post-processor "vagrant" {
    compression_level    = 9
    keep_input_artifact  = true
    output               = "${path.root}/../builds/${var.os_name}-${var.os_version}-${var.os_arch}.{{ .Provider }}.box"
    vagrantfile_template = "${path.root}/vagrantfile-freebsd.template"
  }
}