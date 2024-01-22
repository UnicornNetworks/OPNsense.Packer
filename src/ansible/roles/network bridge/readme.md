# Create network bridge
https://www.tecmint.com/create-network-bridge-in-ubuntu/

# Fix:
## access denied by acl file
works: https://blog.christophersmart.com/2016/08/31/configuring-qemu-bridge-helper-after-access-denied-by-acl-file-error/

```
echo "allow all" | sudo tee /etc/qemu/${USER}.conf
echo "include /etc/qemu/${USER}.conf" | sudo tee --append /etc/qemu/bridge.conf
sudo chown root:${USER} /etc/qemu/${USER}.conf
sudo chmod 640 /etc/qemu/${USER}.conf
```

## failed to create tun device: Operation not permitted
sch: https://www.google.com/search?q=ubuntu+failed+to+create+tun+device%3A+Operation+not+permitted

guide:
- https://help.mystnodes.com/en/articles/8005230-tun-device-errors-and-troubleshooting

discuss:
- https://unix.stackexchange.com/questions/243382/making-dev-net-tun-available-to-qemu


### solution: qemu requires sudo
This works, but is not ideal.