# == Class: amavisd
#
# This is the base amavisd class that should orchestrate the installation of
# all the other pieces that make up the software.
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
class amavisd (
    $config_dir     = undef,
    $config_file    = undef,
    $daemon_user    = undef,
    $daemon_group   = undef,
    $manage_clamav  = false,
    $manage_epel    = undef,
    $package_ensure = present,
    $package_name   = undef,
    $service_enable = true,
    $service_ensure = running,
    $service_name   = undef,
    $state_dir      = undef,
) {
    include ::amavisd::params

    $_config_dir = pick($config_dir, $amavisd::params::config_dir)
    $_config_file = pick($config_dir, $amavisd::params::config_file)
    $_daemon_user = pick($daemon_user, $amavisd::params::daemon_user)
    $_daemon_group = pick($daemon_group, $amavisd::params::daemon_group)
    $_manage_epel = pick($manage_epel, $amavisd::params::manage_epel)
    $_package_name = pick($package_name, $amavisd::params::package_name)
    $_service_name = pick($service_name, $amavisd::params::service_name)
    $_state_dir = pick($state_dir, $amavisd::params::state_dir)

    class { 'amavisd::repos': } ->
    class { 'amavisd::install': } ->
    class { 'amavisd::config': }
    # class { 'amavisd::config': } ->
    # class { 'amavisd::service': }
}
