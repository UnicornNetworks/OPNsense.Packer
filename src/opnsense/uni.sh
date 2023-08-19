pre(){
download_url="https://mirror.dns-root.de/opnsense/releases/23.7/OPNsense-23.7-dvd-amd64.iso.bz2"

mkdir -p iso; cd iso
wget -c $download_url
bunzip2 --keep OPNsense-23.7-dvd-amd64.iso.bz2
mv OPNsense-23.7-dvd-amd64.iso opnsense.iso
shasum -a 256 opnsense.iso
cd -

# ln -sfr iso/opnsense.iso build/
echo "**.iso.bz2" >.gitignore
echo "**/opnsense.iso" >>.gitignore
echo "**/output" >>.gitignore
echo "**/builds" >>.gitignore
}

into(){
cd build
}

build(){
into
packer build .
}

debug(){
# Show qemu command
# https://developer.hashicorp.com/packer/plugins/builders/qemu#qemuargs
into
PACKER_LOG=1 packer build .
}

pre
debug
