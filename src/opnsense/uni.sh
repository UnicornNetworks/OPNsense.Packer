pre(){
download_url="https://mirror.dns-root.de/opnsense/releases/23.7/OPNsense-23.7-dvd-amd64.iso.bz2"

wget -c $download_url

bunzip2 --keep OPNsense-23.7-dvd-amd64.iso.bz2
mv OPNsense-23.7-dvd-amd64.iso opnsense.iso
shasum -a 256 opnsense.iso
ln -sfr opnsense.iso build/
echo "**.iso.bz2" >.gitignore
echo "**/opnsense.iso" >>.gitignore
echo "**/output" >>.gitignore
}

pre

cd build
packer build .
