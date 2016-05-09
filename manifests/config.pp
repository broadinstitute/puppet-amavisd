# == Class: amavisd::config
#
# This class takes care of all necessary configuration
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Authors
#
# Andrew Teixeira <teixeira@broadinstitute.org>
#
# === Copyright
#
# Copyright 2016
#
class amavisd::config {

    file { "${amavisd::_config_dir}/${amavisd::_config_file}":
        ensure => file,
        content => template('amavisd/amavisd.conf.erb'),
        owner => 'root',
        group => $amavisd::root_group,
        mode => '0644'
    }

    #sender_scores
    #clamd.d/amavisd.conf
    #sysconfig, sysconfig/clamd.amavisd?
}
