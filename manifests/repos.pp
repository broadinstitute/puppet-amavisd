# == Class: amavis::repos
#
# This class takes care of all necessary repository installations
#
# === Authors
#
# Andrew Teixeira <teixeira@broadinstitute.org>
#
# === Copyright
#
# Copyright 2016
#
class amavis::repos {
    if $::osfamily == 'RedHat' {
        if ($::operatingsystem != 'Amazon') and ($::operatingsystem != 'Fedora') {
            if ($amavis::manage_epel == true) {
                include 'epel'
                Class['epel'] -> Package[$amavis::_package_name]
            }
        }
    }
}
