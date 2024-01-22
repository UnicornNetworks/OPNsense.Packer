# works:
qemu-system-x86_64 -netdev user,id=user.0,hostfwd=tcp::3107-:22 -netdev bridge,br=br0,id=net1 -name opnsense -boot once=d -smp 2 -drive file=/home/me/src/OPNsense.Packer/src/packer/iso/opnsense.iso,media=cdrom -device virtio-net,netdev=user.0 -device virtio-net,netdev=net1 -vnc 127.0.0.1:95 -m 2000M -display gtk -machine type=q35,accel=kvm

# almost
#qemu-system-x86_64 -netdev user,id=user.0,hostfwd=tcp::3107-:22 -netdev bridge,br=br0,id=net1 -name opnsense -boot once=d -smp 2 -drive file=../output/qemu/opnsense,if=virtio,cache=writeback,discard=ignore,format=qcow2 -drive file=/home/me/src/OPNsense.Packer/src/packer/iso/opnsense.iso,media=cdrom -device virtio-net,netdev=user.0 -device virtio-net,netdev=net1 -vnc 127.0.0.1:95 -m 2000M -display gtk -machine type=q35,accel=kvm
