# Disable Firewall
[Enable ssh (port 22) access through the WAN using terminal/console/shell](https://serverfault.com/questions/1066358/pfsense-enable-ssh-port-22-access-through-the-wan-using-terminal-console-she)

in local.pkr.hcl
```
// .DisableFirewall()
["pfctl -d", "Enable Web_GUI & SSH Access over WAN! disables firewall"],
```