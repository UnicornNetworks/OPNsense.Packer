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
- https://mike42.me/blog/2019-08-how-to-use-the-qemu-bridge-helper-on-debian-10
- https://help.mystnodes.com/en/articles/8005230-tun-device-errors-and-troubleshooting

discuss:
- https://unix.stackexchange.com/questions/243382/making-dev-net-tun-available-to-qemu


### solution: sudo qemu
This works, but is not ideal.
