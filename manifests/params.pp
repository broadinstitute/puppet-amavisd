# == Class: amavis::params
#
# The default parameters for the amavis class
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
class amavis::params {
    $config_dir        = '/etc/amavisd'
    $clamav_config_dir = '/etc/clamd.d'
    $package_name      = 'amavisd-new'

    case $::osfamily {
        'Debian': {
            $service_name      = 'amavis'
            $snmp_package_name = undef
            $snmp_service_name = undef
        }
        'RedHat': {
            $service_name      = 'amavisd'
            $snmp_package_name = 'amavisd-new-snmp'
            $snmp_service_name = 'amavisd-snmp'
        }
        default {
            fail("Unsupported osfamily: ${::osfamily}")
        }
    }

}
