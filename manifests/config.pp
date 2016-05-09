# == Class: amavis::config
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
class amavis::config {

    file { "${amavis::_config_dir}/${amavis::_config_file}":
        ensure => file,
        content => template('amavis/amavisd.conf.erb'),
        owner => 'root',
        group => $amavis::root_group,
        mode => '0644'
    }

    #sender_scores
    #clamd.d/amavisd.conf
    #sysconfig, sysconfig/clamd.amavisd?
}
