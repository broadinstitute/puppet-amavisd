#!/usr/bin/env bash

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BD
wget -O /tmp/puppetlabs-release-pc1-jessie.deb https://apt.puppetlabs.com/puppetlabs-release-pc1-jessie.deb
dpkg -i /tmp/puppetlabs-release-pc1-jessie.deb
apt-get update
apt-get install -yq curl git puppet-agent vim
mv /tmp/Gemfile /etc/puppetlabs/code/
mv /tmp/hiera.yaml /etc/puppetlabs/code/
mkdir -p /etc/puppetlabs/code/hieradata
mkdir -p /etc/puppetlabs/code/modules
touch /etc/puppetlabs/code/hieradata/global.yaml
wget -O /tmp/install-rvm.sh https://get.rvm.io
bash /tmp/install-rvm.sh
# shellcheck source=/dev/null
source /etc/profile.d/rvm.sh
rvm install 2.3.3
rvm use 2.3.3
if ! grep -q rvm /root/.bashrc; then echo 'source /etc/profile.d/rvm.sh' >> /root/.bashrc; fi
gem install bundle librarian-puppet rake --no-rdoc --no-ri
bundle config --global silence_root_warning 1
cd /etc/puppetlabs/code || exit
bundle install
cd /etc/puppetlabs/code/modules/amavisd || exit
rm -f Puppetfile.lock
librarian-puppet install --verbose --path=/etc/puppetlabs/code/modules
