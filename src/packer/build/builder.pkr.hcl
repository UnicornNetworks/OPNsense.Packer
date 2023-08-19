packer {
  required_plugins {
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = "~> 1"
    }
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
  }
}

build {
  sources = ["source.qemu.opnsense"]

  provisioner "shell" {
    // Adapted from: chef/bento  (see readme.md in /scripts)
    environment_vars = [
      "HOME_DIR=/home/${var.user}",
    ]
    scripts = [
      "${path.root}/scripts/_common/vagrant.sh",
    ]
    // execute_command = "echo 'vagrant' | {{.Vars}} su -m root -c 'sh -eux {{.Path}}'"
  }

  # Convert machines to vagrant boxes
  post-processor "vagrant" {
    compression_level    = 9
    keep_input_artifact  = var.Debug ? true : false
    output               = "${path.root}/../output/${var.os_name}-${var.os_version}-${var.os_arch}.{{ .Provider }}.box"
    vagrantfile_template = "${path.root}/vagrant/Vagrantfile"
  }
}