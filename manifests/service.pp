# == Class: amavisd::service
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
class amavisd::service {
    if $amavisd::manage_clamav {
        Service[$clamav::clamd_service] -> Service[$amavisd::_service_name]
    }

    service { $amavisd::_service_name:
        ensure => $amavisd::service_ensure,
        enable => $amavisd::service_enable,
        name   => $amavisd::_service_name,
    }
}
