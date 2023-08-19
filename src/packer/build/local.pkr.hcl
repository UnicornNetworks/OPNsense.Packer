local "slowdown" {
  expression = var.slowdown ? "<wait${var.slowdown_time}>" : ""
}

local "pause" {
  expression = ["<wait9h>","wait indefinitely"]
}

local "Debug" {
  // Add this to boot_steps to Debug interactively!
  expression = [
    // .Login()
    ["<wait1m>", "Wait for boot"],
    ["root<enter><wait1s>opnsense<enter><wait1s>", "Login"],
    ["8<enter>", "8) Shell"],
    
    // .Pause()
    ["<wait9h>","wait indefinitely"],
  ]
}

local "boot_steps" {
  expression = [
    // Debug
    ["echo '${local.slowdown}'", "is Slowdown enabled?"],
    // Start
    ["installer<enter><wait500ms>opnsense<enter><wait2s>", "Login live iso"],
    ["<enter><wait2s><enter><wait2s><enter><wait2s>", "accept defaults"],
    ["<left><wait300ms><enter><wait1m45s>${local.slowdown}", "Installing"],
    ["<down><enter><wait50s>${local.slowdown}","Complete install"],
    ["root<enter>opnsense<enter><wait1s>","Login"],
    ["8<enter><wait3s>", "8) Shell"],
    ["dhclient vtnet0<enter><wait3>", "DHCP"],
    ["${local.curl_config}<wait><enter>", "Fetch config file"],
    ["echo 'PasswordAuthentication yes' >> /usr/local/etc/ssh/sshd_config<enter>", "enable PasswordAuthentication"],
    ["service openssh onestart<enter><wait1>", "start SSHD service"],
    ["${local.add_to_sudo}", "Add user to Sudo"],
    ["exit<enter><wait300ms>6<enter><wait300ms>y<enter>", "Reboot"],
    // local.pause,
  ]
}

local "add_to_sudo" {
  expression = "echo '${var.user} ALL=(ALL) NOPASSWD: ALL' | tee -a /usr/local/etc/sudoers<enter><wait300ms>"
}

local "curl_config" {
  expression = "curl http://{{ .HTTPIP }}:{{ .HTTPPort }}/config.xml -o /conf/config.xml"
}

local "default_network_virtual" {
  expression = "virtio-net,netdev=user.0"
  //"-device", "virtio-net,netdev=user.0"
}

local "default_network_backend" {
  expression = "user,id=user.0,hostfwd=tcp::3107-:22"
  //"-netdev", "user,id=user.0,hostfwd=tcp::3107-:22"
}

// Network Bridge
local "qemuargs" {
  expression = [
    // LAN
    ["-netdev", "${local.default_network_backend}"],
    ["-device", "${local.default_network_virtual}"],
    // WAN
    ["-netdev", "bridge,br=${var.bridge_interface},id=net1"],
    ["-device", "virtio-net,netdev=net1"],
  ]
}