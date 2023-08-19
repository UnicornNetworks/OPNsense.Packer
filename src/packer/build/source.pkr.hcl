source "qemu" "opnsense" {
  boot_key_interval = "${var.boot_key_interval}"
  boot_steps        = "${local.boot_steps}"
  boot_wait         = "${var.boot_wait}"
  disk_size         = "${var.disk_size}"
  headless          = "${var.headless}"
  http_directory    = "http"
  iso_checksum      = "${var.iso_sha256_checksum}"
  iso_urls          = ["${path.root}/../iso/${var.iso_url}"]
  output_directory  = "output/qemu"
  shutdown_timeout  = "2m"     // post_shutdown_delay
  shutdown_command  = "shutdown -p now"
  ssh_password      = "vagrant"
  ssh_username      = "vagrant"
  ssh_timeout       = "2h"
  vm_name           = "opnsense"
  net_device        = "virtio-net"
  disk_interface    = "virtio"
  memory            = "${var.memory}"
  cpus              = "2"

  //* KVM Specific
  format            = "qcow2"
  accelerator       = "${var.accelerator}"
  machine_type      = "${var.qemu_machine_type}"

  //* extra Network
  qemuargs          = "${local.qemuargs}"
  //* SSh
  ssh_host          = "10.0.1.143"
  // ssh_port          = 22
}