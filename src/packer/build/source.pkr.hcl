source "qemu" "opnsense" {
  boot_key_interval = "${var.boot_key_interval}"
  boot_steps        = "${local.boot_steps}"
  boot_wait         = "${var.boot_wait}"
  disk_size         = "${var.disk_size}"
  headless          = "${var.headless}"
  http_directory    = "http"
  iso_checksum      = "${var.iso_sha256_checksum}"
  iso_urls          = ["${path.root}/../iso/${var.iso_url}"]
  output_directory  = "../output/qemu"
  shutdown_timeout  = "1h"
  shutdown_command  = "sudo shutdown -p now"    // Vagrant user requires `sudo`
  ssh_password      = "${var.password}"
  ssh_username      = "${var.user}"
  ssh_timeout       = "2h"
  vm_name           = "opnsense"
  net_device        = "virtio-net"
  disk_interface    = "virtio"
  memory            = "${var.memory}"
  cpus              = "2"

  // KVM Specific
  format            = "qcow2"
  accelerator       = "${var.accelerator}"
  machine_type      = "${var.qemu_machine_type}"

  // extra Networks
  qemuargs          = "${local.qemuargs}"

  // SSH
  ssh_host          = "10.0.1.143"    // Todo: Add a 3rd "management" interface, with static IP!
  skip_nat_mapping  = true
}