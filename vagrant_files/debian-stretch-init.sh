#!/usr/bin/env bash

wget -O /tmp/puppetlabs-release-pc1-stretch.deb https://apt.puppetlabs.com/puppetlabs-release-pc1-stretch.deb
dpkg -i /tmp/puppetlabs-release-pc1-stretch.deb
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
# The ec2 fact has a broken timeout, so it will make each puppet run take
# about 10 minutes if it exists.  So, make it not exist!
rm -f /var/lib/gems/2.3.0/gems/facter-2.5.1/lib/facter/ec2/rest.rb
