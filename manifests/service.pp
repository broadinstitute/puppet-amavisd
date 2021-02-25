# @summary This class takes care of all necessary services
#
# Variables used by this class:
#
#  * $amavisd::_clamd_service
#  * $amavisd::service_enable
#  * $amavisd::service_ensure
#  * $amavisd::_service_name
#  * $amavisd::watch_clamav
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

  service { 'amavisd_service':
    ensure    => $amavisd::service_ensure,
    enable    => $amavisd::service_enable,
    name      => $amavisd::_service_name,
    require   => $svc_require,
    subscribe => $svc_subscribe
  }
}
