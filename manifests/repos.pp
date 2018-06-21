# == Class: amavisd::repos
#
# This class takes care of all necessary repository installations
#
# === Variables
#
#  $amavisd::_manage_epel
#  $amavisd::package_name
#
# === Authors
#
# Andrew Teixeira <teixeira@broadinstitute.org>
#
# === Copyright
#
# Copyright 2018
#
class amavisd::repos {

  case $::osfamily {
    'Debian': {
      require ::apt

      Exec['apt_update'] -> Package[$amavisd::package_name]
    }
    'RedHat': {
      if ($::operatingsystem != 'Amazon') and ($::operatingsystem != 'Fedora') {
        if ($amavisd::_manage_epel == true) {
          require ::epel

          Class['epel'] -> Package[$amavisd::package_name]
        }
      }
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  }
}
