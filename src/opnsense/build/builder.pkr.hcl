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
    execute_command = "chmod +x {{ .Path }}; /bin/sh -c '{{ .Vars }} {{ .Path }}'"
    scripts         = ["scripts/base.sh"]
  }

  # Convert machines to vagrant boxes
  post-processor "vagrant" {
    compression_level    = 9
    keep_input_artifact  = true
    output               = "${path.root}/../output/${var.os_name}-${var.os_version}-${var.os_arch}.{{ .Provider }}.box"
    vagrantfile_template = "${path.root}/vagrant/Vagrantfile"
  }
}