local "boot_steps" {
  expression = [
    ["installer<enter><wait500ms>opnsense<enter><wait2s>", "Login live iso"],
    ["<enter><wait2s><enter><wait2s><enter><wait2s>", "accept defaults"],
    ["<left><wait300ms><enter><wait2s><wait1m50s>", "Installing"],
    ["<down><enter><wait50s>","Complete install"],
    ["root<enter>opnsense<enter><wait1s>","Login"],
    ["8<enter><wait5s>", "8) Shell"],
    ["dhclient vtnet0<enter><wait6>", "DHCP"],
    // 
    ["telnet {{ .HTTPIP }} {{ .HTTPPort }} | sed '1,/^$/d' >/conf/config.xml<wait><enter>", "Telnet config"],
    ["GET /${var.config_file} HTTP/1.0<enter><enter>", "Fetch config file"],
    // 
    ["echo 'PasswordAuthentication yes' >> /usr/local/etc/ssh/sshd_config<enter>", "enable PasswordAuthentication"],
    ["service openssh onestart<enter>", "start SSHD service"],
    ["<wait1h>","wait indefinitely"]
  ]
}

//*Not used
// ["<enter><wait1s>vagrant<enter><wait1s>vagrant<enter><wait20s>","Change root password"],
// ["root<enter><wait1s>opnsense<enter><wait2s>5<enter><wait1s>y<enter><wait30s>","Login & Shutdown ..."]
// type    = list(list(string))