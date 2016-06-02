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

    if $amavisd::watch_clamav {
        $svc_require   = Service[$amavisd::_clamd_service]
        $svc_subscribe = [
            Concat[$amavisd::config::amavis_conf],
            Service[$clamav::clamd_service]
        ]
    } else {
        $svc_require   = undef
        $svc_subscribe = Concat[$amavisd::config::amavis_conf]
    }

    service { $amavisd::_service_name:
        ensure    => $amavisd::service_ensure,
        enable    => $amavisd::service_enable,
        name      => $amavisd::_service_name,
        require   => $svc_require,
        subscribe => $svc_subscribe
    }
}
