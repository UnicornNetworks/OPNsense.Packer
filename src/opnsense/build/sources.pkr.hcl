source "qemu" "opnsense" {
  boot_key_interval = "${var.boot_key_interval}"
  boot_steps        = "${var.boot_steps}"
  boot_wait         = "${var.boot_wait}"
  disk_size         = "${var.disk_size}"
  headless          = "${var.headless}"
  http_directory    = "http"
  iso_checksum      = "${var.iso_sha256_checksum}"
  iso_urls          = ["${path.root}/../iso/${var.iso_url}"]
  output_directory  = "output/qemu"
  // shutdown_timeout  = "1m30s"     // post_shutdown_delay
  // shutdown_command  = "shutdown -p now"
//   communicator      = "none"
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

}