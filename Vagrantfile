# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box"
  config.vm.box = "Ubuntu64"
  config.omnibus.chef_version = :latest
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.gui = false
  end
  config.vm.network "forwarded_port", guest: 3000, host: 3000

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "nodejs"
    chef.add_recipe "ruby_build"
    chef.add_recipe "ruby_rbenv"
    chef.add_recipe "ruby_rbenv::user"
    chef.add_recipe "postgresql"
    chef.add_recipe "postgresql::server"
    chef.add_recipe "oh_my_zsh"


    chef.json = {
        postgresql: {
          enable_pgdg_apt: true,
          dir: "/etc/postgresql/9.2/main",
          config: {
              data_directory: "/var/lib/postgresql/9.2/main",
              hba_file: "/etc/postgresql/9.2/main/pg_hba.conf",
              ident_file: "/etc/postgresql/9.2/main/pg_ident.conf",
              external_pid_file: "/var/run/postgresql/9.2-main.pid",
              ssl_key_file: "/etc/ssl/private/ssl-cert-snakeoil.key",
              ssl_cert_file: "/etc/ssl/certs/ssl-cert-snakeoil.pem",
          },
          client: {
              packages: ["postgresql-client-9.2",],
          },
          server: {
              packages: ["postgresql-9.2", "postgresql-server-dev-9.2"],
          },
          contrib: {
              packages: ["postgresql-contrib-9.2"],
          },
          password: {
            postgres: '12345678'
          },
          pg_hba: [
            {type: 'local', db: 'all', user: 'all', addr: nil, method: 'trust'},
            {type: 'host', db: 'all', user: 'all', addr: '127.0.0.1/32', method: 'trust'},
            {type: 'host', db: 'all', user: 'all', addr: '::1/128', method: 'trust'}
          ],
          version: "9.2",
      },
      rbenv: {
        user_installs: [{
          user: 'vagrant',
          rubies: ["2.2.4"],
          gems: {
            "2.2.4" => [
              { name: "bundler" }
           ]
          }
        }]
      },
      oh_my_zsh: {
        users: [{
          :login => 'vagrant',
          :theme => 'robbyrussell',
          :plugins => ['gem', 'git', 'rails3', 'redis-cli', 'ruby'],
          :home => '/home/vagrant' # optional
        }]
      }
    }

  end

  config.vm.provision "shell", inline: "apt-get install  -y --force-yes libfontconfig"
  config.ssh.forward_agent = true

end
