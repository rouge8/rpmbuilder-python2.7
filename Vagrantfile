# -*- mode: ruby -*-
# vi: set ft=ruby :

$setup = <<SCRIPT
sudo yum install -y autoconf bzip2 bzip2-devel db4-devel expat-devel findutils gcc-c++ glibc-devel gmp-devel libffi-devel libGL-devel libX11-devel make ncurses-devel openssl-devel pkgconfig readline-devel sqlite-devel tar tcl-devel tix-devel tk-devel zlib-devel
sudo yum install -y rubygems ruby-devel
echo "Installing 'fpm'... (this might take a while)"
sudo gem install fpm
SCRIPT

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos64-x86_64-20131030"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v0.1.0/centos64-x86_64-20131030.box"

  # Provisioning!
  config.vm.provision "shell", inline: $setup
end
