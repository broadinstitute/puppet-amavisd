# == Class: amavisd::repos
#
# This class takes care of all necessary repository installations
#
# === Variables
#
# These variables from other classes are required for correct functionality:
#
# [*amavisd::_package_name*]
#   This is used to provide repository dependencies to the package resource
#
# [*amavisd::_manage_epel*]
#   This determines whether the *epel* class is included and whether the
#   EPEL repository is managed using this module
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
            require ::apt

            Exec['apt_update'] -> Package[$amavisd::_package_name]
        }
        'RedHat': {
            if ($::operatingsystem != 'Amazon') and ($::operatingsystem != 'Fedora') {
                if ($amavisd::_manage_epel == true) {
                    require ::epel

                    Class['epel'] -> Package[$amavisd::_package_name]
                }
            }
        }
        default: {
            fail("Unsupported osfamily: ${::osfamily}")
        }
    }
}
