local "curl_command" {
  expression = "curl http://{{ .HTTPIP }}:{{ .HTTPPort }}/config.xml -o /conf/config.xml"
}

local "boot_steps" {
  expression = [
    //* Debug
    // ["root<enter>opnsense<enter><wait3s>"],
    ["<wait1h>","wait indefinitely"],

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

//*Not used
// ["root<enter><wait1s>opnsense<enter><wait2s>5<enter><wait1s>y<enter><wait30s>","Login & Shutdown ..."]

local "default_network" {
  expression = "virtio-net,netdev=user.0"
}

// network_interfaces
local "qemuargs" {
  expression = [
    ["-cpu", "host"],
    // LAN
    ["-device", "${local.default_network}"]
    // WAN
  ]
}