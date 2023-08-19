local "curl_config" {
  expression = "curl http://{{ .HTTPIP }}:{{ .HTTPPort }}/config.xml -o /conf/config.xml"
}

// /*
local "boot_steps" {
  expression = [
    //* Start
    ["installer<enter><wait500ms>opnsense<enter><wait2s>", "Login live iso"],
    ["<enter><wait2s><enter><wait2s><enter><wait2s>", "accept defaults"],
    ["<left><wait300ms><enter><wait2s><wait1m40s>", "Installing"],
    ["<down><enter><wait50s>","Complete install"],
    ["root<enter>opnsense<enter><wait1s>","Login"],
    ["8<enter><wait3s>", "8) Shell"],
    ["dhclient vtnet0<enter><wait3>", "DHCP"],
    ["${local.curl_config}<wait><enter>", "Fetch config file"],
    ["echo 'PasswordAuthentication yes' >> /usr/local/etc/ssh/sshd_config<enter>", "enable PasswordAuthentication"],
    ["service openssh onestart<enter><wait1>", "start SSHD service"],    
    ["exit<enter><wait300ms>6<enter><wait300ms>y<enter>", "Reboot"],
    ["<wait1h>","wait indefinitely"],

    // Login
    // ["<wait1m>", "Wait for boot"],
    // ["root<enter><wait1s>opnsense<enter><wait1s>", "Login"],
    // ["8<enter>", "8) Shell"]
  ]
}
// */


/*
local "boot_steps" {
  // Debug
  expression = [
    ["root<enter><wait1s>opnsense<enter><wait1s>", "Login"],
    ["8<enter>", "8) Shell"],
    ["pfctl -d", "Enable Web_GUI & SSH Access over WAN! disables firewall"]
    ["<wait1h>","wait indefinitely"],
  ]
}
*/


local "default_network_virtual" {
  expression = "virtio-net,netdev=user.0"
  //"-device", "virtio-net,netdev=user.0"
}

local "default_network_backend" {
  expression = "user,id=user.0,hostfwd=tcp::3107-:22"
  //"-netdev", "user,id=user.0,hostfwd=tcp::3107-:22"
}


// Network Bridge
// https://www.tecmint.com/create-network-bridge-in-ubuntu/
local "qemuargs" {
  expression = [
    ["-device", "${local.default_network_virtual}"],
    ["-netdev", "${local.default_network_backend}"],
    ["-netdev", "bridge,br=${var.bridge_interface},id=net1"],
    ["-device", "virtio-net,netdev=net1"]
  ]
}