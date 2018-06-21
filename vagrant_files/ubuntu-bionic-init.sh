#!/usr/bin/env bash

wget -O /tmp/puppet-release-bionic.deb https://apt.puppetlabs.com/puppet-release-bionic.deb
dpkg -i /tmp/puppet-release-bionic.deb
apt-get update
apt-get install -yq build-essential curl git puppet-agent ruby ruby-dev vim
mv /tmp/Gemfile /etc/puppetlabs/code/
mv /tmp/hiera.yaml /etc/puppetlabs/code/
mkdir -p /etc/puppetlabs/code/hieradata
mkdir -p /etc/puppetlabs/code/modules
touch /etc/puppetlabs/code/hieradata/global.yaml
gem install bundle librarian-puppet rake --no-rdoc --no-ri
bundle config --global silence_root_warning 1
cd /etc/puppetlabs/code/modules/amavisd || exit
bundle install
rm -f Puppetfile.lock
librarian-puppet install --verbose --path=/etc/puppetlabs/code/modules
