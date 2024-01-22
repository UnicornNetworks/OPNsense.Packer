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

## tun
