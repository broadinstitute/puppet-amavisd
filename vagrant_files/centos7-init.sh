#!/usr/bin/env bash

export PUPPET_GEM_VERSION='< 6.0.0'

cd /etc/puppetlabs/code/modules/amavisd || exit
rm -f Puppetfile.lock
rm -f Gemfile.lock
bundle install
cp metadata.json /tmp
cd /tmp
librarian-puppet install --verbose --path=/etc/puppetlabs/code/modules
