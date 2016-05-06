# == Class: amavis::config
#
# This class takes care of all necessary configuration
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Authors
#
# Andrew Teixeira <teixeira@broadinstitute.org>
#
# === Copyright
#
# Copyright 2016
#
class amavis::config {

    package { $amavis::_package_name:
        ensure => $amavis::package_ensure,
        name   => $amavis::_package_name,
        before => Service[$amavis::_service_name]
    }
}
