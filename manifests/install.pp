# == Class: amavisd::install
#
# This class takes care of all necessary package installations
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
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
# === Examples
#
#  class { 'amavisd':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Andrew Teixeira <teixeira@broadinstitute.org>
#
# === Copyright
#
# Copyright 2016
#
class amavisd::install {

    if $::osfamily == 'RedHat' {
        if ($::operatingsystem != 'Amazon') and ($::operatingsystem != 'Fedora') {
            if $amavisd::_manage_epel {
                $_requireEpel = true
            }
        }
    }

    if $_requireEpel {
        $pkg_require = Class['epel']
    } else {
        $pkg_require = undef
    }

    if $amavisd::_manage_group {
        $group_require = Group[$amavisd::_daemon_group]

        group { $amavisd::_daemon_group:
            ensure => 'present',
            system => true,
        }
    } else {
        $group_require = undef
    }

    if $amavisd::_manage_user {
        user { $amavisd::_daemon_user:
            ensure => 'present',
            comment => 'User for amavisd-new',
            forcelocal => true,
            gid => $amavisd::_daemon_group,
            home => $amavisd::_myhome,
            managehome => false,
            shell => '/sbin/nologin',
            system => true,
            require => $group_require,
        }
    }

    package { $amavisd::_package_name:
        ensure  => $amavisd::package_ensure,
        name    => $amavisd::_package_name,
        require => $pkg_require,
        before  => Service[$amavisd::_service_name]
    }
}
