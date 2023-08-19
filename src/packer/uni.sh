version=23.7
arch=x86_64

gitignore(){
    echo "**.iso.bz2" >.gitignore
    echo "**/opnsense.iso" >>.gitignore
    echo "**/output" >>.gitignore
    echo "**/builds" >>.gitignore
    echo "**/crash.log" >>.gitignore
}

pre(){
    download_url="https://mirror.dns-root.de/opnsense/releases/${version}/OPNsense-${version}-dvd-amd64.iso.bz2"

    mkdir -p iso; cd iso
    wget -c $download_url
    bunzip2 --keep OPNsense-${version}-dvd-amd64.iso.bz2
    mv OPNsense-${version}-dvd-amd64.iso opnsense.iso
    shasum -a 256 opnsense.iso
    cd -

    # ln -sfr iso/opnsense.iso build/
    gitignore
}

into(){
    cd build
}

build(){
    into
    packer build .
}

box(){
cd output
vagrant box add OPNsense-${version}-${arch}.libvirt.box --name opnsense
}

debug(){
    # Show qemu command
    # https://developer.hashicorp.com/packer/plugins/builders/qemu#qemuargs
    into
    PACKER_LOG=1 PACKER_LOG_PATH="../output/packerlog.txt" packer build .
}

pre
debug
