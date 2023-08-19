local "curl_command" {
  expression = "curl http://{{ .HTTPIP }}:{{ .HTTPPort }}/config.xml -o /conf/config.xml"
}

/*
local "boot_steps" {
  expression = [
    //* Start
    ["installer<enter><wait500ms>opnsense<enter><wait2s>", "Login live iso"],
    ["<enter><wait2s><enter><wait2s><enter><wait2s>", "accept defaults"],
    ["<left><wait300ms><enter><wait2s><wait1m50s>", "Installing"],
    ["<down><enter><wait50s>","Complete install"],
    ["root<enter>opnsense<enter><wait1s>","Login"],
    ["8<enter><wait3s>", "8) Shell"],
    ["dhclient vtnet0<enter><wait3>", "DHCP"],
    ["${local.curl_command}<wait><enter>", "Fetch config file"],
    ["echo 'PasswordAuthentication yes' >> /usr/local/etc/ssh/sshd_config<enter>", "enable PasswordAuthentication"],
    ["service openssh onestart<enter>", "start SSHD service"],
    ["<wait1h>","wait indefinitely"]
  ]
}
*/

local "boot_steps" {
  expression = [
    //* Debug
    ["root<enter><wait1s>opnsense<enter><wait1s>"],
    ["<wait1h>","wait indefinitely"],
  ]
}

//*Not used
// ["root<enter><wait1s>opnsense<enter><wait2s>5<enter><wait1s>y<enter><wait30s>","Login & Shutdown ..."]

local "default_network_virtual" {
  expression = "virtio-net,netdev=user.0"
  //"-device", "virtio-net,netdev=user.0"
}

local "default_network_backend" {
  expression = "user,id=user.0,hostfwd=tcp::3107-:22"
  //"-netdev", "user,id=user.0,hostfwd=tcp::3107-:22"
}


// Network Bridge
// https://blog.christophersmart.com/2016/08/31/configuring-qemu-bridge-helper-after-access-denied-by-acl-file-error/
local "qemuargs" {
  expression = [
    // ["-netdev", "bridge,br=${var.bridge_interface},id=net0"],
    ["-device", "${local.default_network_virtual}"],
    ["-netdev", "${local.default_network_backend}"],
    ["-netdev", "bridge,br=${var.bridge_interface},id=net1"],
    ["-device", "virtio-net,netdev=net1"]
  ]
}

// ["-device", "virtio-net-pci,netdev=net1"]