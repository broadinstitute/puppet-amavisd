# == Class: amavisd::repos
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
class amavisd::repos {

    case $::osfamily {
        'Debian': {
            include ::apt

            Exec['apt_update'] -> Package[$amavisd::_package_name]
        }
        'RedHat': {
            if ($::operatingsystem != 'Amazon') and ($::operatingsystem != 'Fedora') {
                if ($amavisd::_manage_epel == true) {
                    include ::epel

                    Class['epel'] -> Package[$amavisd::_package_name]
                }
            }
        }
        default: {
            fail("Unsupported osfamily: ${::osfamily}")
        }
    }
}
