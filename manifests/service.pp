# == Class: amavis::service
#
# This class takes care of all necessary services
#
# === Authors
#
# Andrew Teixeira <teixeira@broadinstitute.org>
#
# === Copyright
#
# Copyright 2016
#
class amavis::service {
    if $amavis::manage_clamav {
        Service[$clamav::clamd_service] -> Service[$amavis::_service_name]
    }

    service { $amavis::_service_name:
        enable => $amavis::service_enable,
        ensure => $amavis::service_ensure,
        name   => $amavis::_service_name,
    }
}
