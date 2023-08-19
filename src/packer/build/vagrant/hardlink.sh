src=~/src
repo=OPNsense.Packer

hardlink(){
  cd $src/$repo/src
  ln -f packer/build/vagrant/Vagrantfile vagrant/
}

hardlink
