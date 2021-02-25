# @summary This class takes care of all necessary package installations
#
# Variables used by this class:
#
#  * $amavisd::daemon_group
#  * $amavisd::daemon_user
#  * $amavisd::_manage_epel
#  * $amavisd::manage_group
#  * $amavisd::manage_user
#  * $amavisd::_myhome
#  * $amavisd::package_ensure
#  * $amavisd::package_name
#  * $amavisd::user_shell
#
class amavisd::install {

  if $::osfamily == 'RedHat' {
    if ($::operatingsystem != 'Amazon') and ($::operatingsystem != 'Fedora') {
      if $amavisd::_manage_epel {
        $pkg_require = Class['epel']
      } else {
        $pkg_require = undef
      }
    } else {
      $pkg_require = undef
    }
  } else {
    $pkg_require = undef
  }

  if $amavisd::manage_group {
    $group_require = Group[$amavisd::daemon_group]

    group { $amavisd::daemon_group:
      ensure => 'present',
      system => true,
    }
  } else {
    $group_require = undef
  }

  if $amavisd::manage_user {
    $user_require = User[$amavisd::daemon_user]

    user { $amavisd::daemon_user:
      ensure     => 'present',
      comment    => 'User for amavisd-new',
      forcelocal => true,
      gid        => $amavisd::daemon_group,
      home       => $amavisd::_myhome,
      managehome => false,
      shell      => $amavisd::user_shell,
      system     => true,
      require    => $group_require,
    }
  } else {
    $user_require = undef
  }

  $file_require = unique([$group_require, $user_require])

  file { $amavisd::_myhome:
    ensure  => 'directory',
    owner   => $amavisd::daemon_user,
    group   => $amavisd::daemon_group,
    mode    => '0750',
    before  => Package[$amavisd::package_name],
    require => $file_require,
  }

  package { $amavisd::package_name:
    ensure  => $amavisd::package_ensure,
    name    => $amavisd::package_name,
    require => $pkg_require,
    before  => Service['amavisd_service']
  }
}
