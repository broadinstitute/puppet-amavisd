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
  if $facts['os']['family'] == 'RedHat' {
    if ($facts['os']['name'] != 'Amazon') and ($facts['os']['name'] != 'Fedora') {
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
      require    => $group_require,
      shell      => $amavisd::user_shell,
      system     => true,
    }
  } else {
    $user_require = undef
  }

  $file_require = unique([$group_require, $user_require])

  file { $amavisd::_myhome:
    ensure  => 'directory',
    before  => Package[$amavisd::package_name],
    group   => $amavisd::daemon_group,
    mode    => '0750',
    owner   => $amavisd::daemon_user,
    require => $file_require,
  }

  package { $amavisd::package_name:
    ensure  => $amavisd::package_ensure,
    before  => Service['amavisd_service'],
    name    => $amavisd::package_name,
    require => $pkg_require,
  }
}
