# == Class: amavisd::params
#
# The default parameters for the amavisd class
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Authors
#
# Andrew Teixeira <teixeira@broadinstitute.org>
#
# === Copyright
#
# Copyright 2016
#
class amavisd::params {
    $clamav_config_dir = '/etc/clamd.d'
    $daemon_user       = 'amavis'
    $daemon_group      = 'amavis'
    $package_name      = 'amavisd-new'
    $root_group        = 'root'

    case $::osfamily {
        'Debian': {
            $config_dir        = '/etc/amavisd/conf.d'
            $config_file       = '60-user'
            $manage_epel       = false
            $service_name      = 'amavis'
            $snmp_package_name = undef
            $snmp_service_name = undef
            $state_dir         = '/var/run/amavis'
        }
        'RedHat': {
            $config_dir        = '/etc/amavisd'
            $config_file       = 'amavisd.conf'
            $manage_epel       = true
            $service_name      = 'amavisd'
            $snmp_package_name = 'amavisd-new-snmp'
            $snmp_service_name = 'amavisd-snmp'
            $state_dir         = '/var/run/amavisd'
        }
        default: {
            fail("Unsupported osfamily: ${::osfamily}")
        }
    }

}
