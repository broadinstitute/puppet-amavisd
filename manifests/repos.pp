# @summary This class takes care of all necessary repository installations
#
# Variables used by this class:
#
#  * $amavisd::_manage_epel
#  * $amavisd::package_name
#
class amavisd::repos {
  case $facts['os']['family'] {
    'Debian': {
      require apt

      Exec['apt_update'] -> Package[$amavisd::package_name]
    }
    'RedHat': {
      if ($facts['os']['name'] != 'Amazon') and ($facts['os']['name'] != 'Fedora') {
        if ($amavisd::_manage_epel == true) {
          require epel

          Class['epel'] -> Package[$amavisd::package_name]
        }
      }
    }
    default: {
      fail("Unsupported osfamily: ${facts['os']['family']}")
    }
  }
}
