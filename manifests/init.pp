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
    $addr_extension_bad_header_maps   = undef,
    $addr_extension_banned_maps       = undef,
    $addr_extension_spam_maps         = undef,
    $addr_extension_virus_maps        = undef,
    $av_scanners                      = undef,
    $av_scanners_backup               = undef,
    $bad_header_quarantine_method     = undef,
    $bad_header_quarantine_to         = undef,
    $banned_filename_re               = undef,
    $banned_quarantine_to             = undef,
    $bounce_killer_score              = undef,
    $bypass_decode_parts              = undef,
    $bypass_spam_checks_maps          = undef,
    $bypass_virus_checks_maps         = undef,
    $clamd_service                    = undef,
    $clean_quarantine_method          = undef,
    $config_dir                       = undef,
    $config_file                      = undef,
    $daemon_chroot_dir                = undef,
    $daemon_group                     = undef,
    $daemon_user                      = undef,
    $db_home                          = undef,
    $decoders                         = undef,
    $defang_bad_header                = undef,
    $defang_banned                    = undef,
    $defang_by_ccat                   = undef,
    $defang_spam                      = undef,
    $defang_undecipherable            = undef,
    $defang_virus                     = undef,
    $do_syslog                        = undef,
    $dspam                            = undef,
    $enable_db                        = undef,
    $enable_dkim_signing              = undef,
    $enable_dkim_verification         = undef,
    $enable_zmq                       = undef,
    $final_bad_header_destiny         = undef,
    $final_banned_destiny             = undef,
    $final_spam_destiny               = undef,
    $final_virus_destiny              = undef,
    $forward_method                   = undef,
    $helpers_home                     = undef,
    $include_score_sender_maps        = undef,
    $inet_socket_bind                 = undef,
    $inet_socket_port                 = undef,
    $interface_policy                 = undef,
    $keep_decoded_original_maps       = undef,
    $local_domains_maps               = undef,
    $lock_file                        = undef,
    $log_level                        = undef,
    $log_recip_templ                  = undef,
    $lookup_sql_dsn                   = undef,
    $mailfrom_notify_admin            = undef,
    $mailfrom_notify_recip            = undef,
    $mailfrom_notify_spamadmin        = undef,
    $mailfrom_to_quarantine           = undef,
    $manage_epel                      = undef,
    $manage_group                     = undef,
    $manage_user                      = undef,
    $max_expansion_quota              = undef,
    $max_servers                      = undef,
    $maxfiles                         = undef,
    $maxlevels                        = undef,
    $min_expansion_quota              = undef,
    $mydomain                         = undef,
    $myhome                           = undef,
    $myhostname                       = undef,
    $mynetworks                       = undef,
    $nanny_details_level              = undef,
    $notify_method                    = undef,
    $os_fingerprint_method            = undef,
    $package_ensure                   = present,
    $package_name                     = undef,
    $path                             = undef,
    $penpals_bonus_score              = undef,
    $penpals_threshold_high           = undef,
    $pid_file                         = undef,
    $policy_bank                      = undef,
    $quarantine_subdir_levels         = undef,
    $quarantinedir                    = undef,
    $recipient_delimiter              = undef,
    $redis_logging_key                = undef,
    $redis_logging_queue_size_limit   = undef,
    $release_format                   = undef,
    $report_format                    = undef,
    $sa_crediblefrom_dsn_cutoff_level = undef,
    $sa_dsn_cutoff_level              = undef,
    $sa_kill_level_deflt              = undef,
    $sa_local_tests_only              = undef,
    $sa_mail_body_size_limit          = undef,
    $sa_quarantine_cutoff_level       = undef,
    $sa_spam_subject_tag              = undef,
    $sa_tag2_level_deflt              = undef,
    $sa_tag_level_deflt               = undef,
    $service_enable                   = true,
    $service_ensure                   = running,
    $service_name                     = undef,
    $spam_quarantine_to               = undef,
    $state_dir                        = undef,
    $storage_redis_dsn                = undef,
    $storage_sql_dsn                  = undef,
    $syslog_facility                  = undef,
    $tempbase                         = undef,
    $timestamp_fmt_mysql              = undef,
    $tmpdir                           = undef,
    $unix_socketname                  = undef,
    $user_shell                       = undef,
    $virus_admin                      = undef,
    $virus_quarantine_to              = undef,
    $warnbadhrecip                    = undef,
    $warnbadhsender                   = undef,
    $warnbannedrecip                  = undef,
    $warnvirusrecip                   = undef,
    $watch_clamav                     = false,
) {
    include ::amavisd::params

    # Service Settings
    $_clamd_service = pick($clamd_service, $amavisd::params::clamd_service)
    $_config_dir    = pick($config_dir, $amavisd::params::config_dir)
    $_config_file   = pick($config_file, $amavisd::params::config_file)
    $_manage_epel   = pick($manage_epel, $amavisd::params::manage_epel)
    $_package_name  = pick($package_name, $amavisd::params::package_name)
    $_service_name  = pick($service_name, $amavisd::params::service_name)
    $_state_dir     = pick($state_dir, $amavisd::params::state_dir)
    $_user_shell    = pick($user_shell, $amavisd::params::user_shell)

    # Config settings
    $_addr_extension_bad_header_maps   = pick_default($addr_extension_bad_header_maps, $amavisd::params::addr_extension_bad_header_maps)
    $_addr_extension_banned_maps       = pick_default($addr_extension_banned_maps, $amavisd::params::addr_extension_banned_maps)
    $_addr_extension_spam_maps         = pick_default($addr_extension_spam_maps, $amavisd::params::addr_extension_spam_maps)
    $_addr_extension_virus_maps        = pick_default($addr_extension_virus_maps, $amavisd::params::addr_extension_virus_maps)
    $_av_scanners                      = pick_default($av_scanners, $amavisd::params::av_scanners)
    $_av_scanners_backup               = pick_default($av_scanners_backup, $amavisd::params::av_scanners_backup)
    $_bad_header_quarantine_method     = pick_default($bad_header_quarantine_method, $amavisd::params::bad_header_quarantine_method)
    $_bad_header_quarantine_to         = pick_default($bad_header_quarantine_to, $amavisd::params::bad_header_quarantine_to)
    $_banned_filename_re               = pick_default($banned_filename_re, $amavisd::params::banned_filename_re)
    $_banned_quarantine_to             = pick_default($banned_quarantine_to, $amavisd::params::banned_quarantine_to)
    $_bounce_killer_score              = pick_default($bounce_killer_score, $amavisd::params::bounce_killer_score)
    $_bypass_decode_parts              = pick_default($bypass_decode_parts, $amavisd::params::bypass_decode_parts)
    $_bypass_spam_checks_maps          = pick_default($bypass_spam_checks_maps, $amavisd::params::bypass_spam_checks_maps)
    $_bypass_virus_checks_maps         = pick_default($bypass_virus_checks_maps, $amavisd::params::bypass_virus_checks_maps)
    $_clean_quarantine_method          = pick_default($clean_quarantine_method, $amavisd::params::clean_quarantine_method)
    $_daemon_chroot_dir                = pick_default($daemon_chroot_dir, $amavisd::params::daemon_chroot_dir)
    $_daemon_group                     = pick_default($daemon_group, $amavisd::params::daemon_group)
    $_daemon_user                      = pick_default($daemon_user, $amavisd::params::daemon_user)
    $_decoders                         = pick_default($decoders, $amavisd::params::decoders)
    $_db_home                          = pick_default($db_home, $amavisd::params::db_home)
    $_defang_bad_header                = pick_default($defang_bad_header, $amavisd::params::defang_bad_header)
    $_defang_banned                    = pick_default($defang_banned, $amavisd::params::defang_banned)
    $_defang_by_ccat                   = pick_default($defang_by_ccat, $amavisd::params::defang_by_ccat)
    $_defang_spam                      = pick_default($defang_spam, $amavisd::params::defang_spam)
    $_defang_undecipherable            = pick_default($defang_undecipherable, $amavisd::params::defang_undecipherable)
    $_defang_virus                     = pick_default($defang_virus, $amavisd::params::defang_virus)
    $_do_syslog                        = pick_default($do_syslog, $amavisd::params::do_syslog)
    $_dspam                            = pick_default($dspam, $amavisd::params::dspam)
    $_enable_db                        = pick_default($enable_db, $amavisd::params::enable_db)
    $_enable_dkim_signing              = pick_default($enable_dkim_signing, $amavisd::params::enable_dkim_signing)
    $_enable_dkim_verification         = pick_default($enable_dkim_verification, $amavisd::params::enable_dkim_verification)
    $_enable_zmq                       = pick_default($enable_zmq, $amavisd::params::enable_zmq)
    $_final_bad_header_destiny         = pick_default($final_bad_header_destiny, $amavisd::params::final_bad_header_destiny)
    $_final_banned_destiny             = pick_default($final_banned_destiny, $amavisd::params::final_banned_destiny)
    $_final_spam_destiny               = pick_default($final_spam_destiny, $amavisd::params::final_spam_destiny)
    $_final_virus_destiny              = pick_default($final_virus_destiny, $amavisd::params::final_virus_destiny)
    $_forward_method                   = pick_default($forward_method, $amavisd::params::forward_method)
    $_helpers_home                     = pick_default($helpers_home, $amavisd::params::helpers_home)
    $_include_score_sender_maps        = pick_default($include_score_sender_maps, $amavisd::params::include_score_sender_maps)
    $_inet_socket_bind                 = pick_default($inet_socket_bind, $amavisd::params::inet_socket_bind)
    $_inet_socket_port                 = pick_default($inet_socket_port, $amavisd::params::inet_socket_port)
    $_interface_policy                 = pick_default($interface_policy, $amavisd::params::interface_policy)
    $_keep_decoded_original_maps       = pick_default($keep_decoded_original_maps, $amavisd::params::keep_decoded_original_maps)
    $_local_domains_maps               = pick_default($local_domains_maps, $amavisd::params::local_domains_maps)
    $_lock_file                        = pick($lock_file, "${amavisd::_state_dir}/${amavisd::_service_name}.lock")
    $_log_level                        = pick_default($log_level, $amavisd::params::log_level)
    $_log_recip_templ                  = pick_default($log_recip_templ, $amavisd::params::log_recip_templ)
    $_lookup_sql_dsn                   = pick_default($lookup_sql_dsn, $amavisd::params::lookup_sql_dsn)
    $_mailfrom_notify_admin            = pick_default($mailfrom_notify_admin, $amavisd::params::mailfrom_notify_admin)
    $_mailfrom_notify_recip            = pick_default($mailfrom_notify_recip, $amavisd::params::mailfrom_notify_recip)
    $_mailfrom_notify_spamadmin        = pick_default($mailfrom_notify_spamadmin, $amavisd::params::mailfrom_notify_spamadmin)
    $_mailfrom_to_quarantine           = pick_default($mailfrom_to_quarantine, $amavisd::params::mailfrom_to_quarantine)
    $_manage_group                     = pick_default($manage_group, $amavisd::params::manage_group)
    $_manage_user                      = pick_default($manage_user, $amavisd::params::manage_user)
    $_max_expansion_quota              = pick_default($max_expansion_quota, $amavisd::params::max_expansion_quota)
    $_max_servers                      = pick_default($max_servers, $amavisd::params::max_servers)
    $_maxfiles                         = pick_default($maxfiles, $amavisd::params::maxfiles)
    $_maxlevels                        = pick_default($maxlevels, $amavisd::params::maxlevels)
    $_min_expansion_quota              = pick_default($min_expansion_quota, $amavisd::params::min_expansion_quota)
    $_mydomain                         = pick_default($mydomain, $amavisd::params::mydomain)
    $_myhome                           = pick_default($myhome, $amavisd::params::myhome)
    $_myhostname                       = pick_default($myhostname, $amavisd::params::myhostname)
    $_mynetworks                       = pick_default($mynetworks, $amavisd::params::mynetworks)
    $_nanny_details_level              = pick_default($nanny_details_level, $amavisd::params::nanny_details_level)
    $_notify_method                    = pick_default($notify_method, $amavisd::params::notify_method)
    $_os_fingerprint_method            = pick_default($os_fingerprint_method, $amavisd::params::os_fingerprint_method)
    $_path                             = pick_default($path, $amavisd::params::path)
    $_penpals_bonus_score              = pick_default($penpals_bonus_score, $amavisd::params::penpals_bonus_score)
    $_penpals_threshold_high           = pick_default($penpals_threshold_high, $amavisd::params::penpals_threshold_high)
    $_pid_file                         = pick($pid_file, "${amavisd::_state_dir}/${amavisd::_service_name}.pid")
    $_policy_bank                      = pick_default($policy_bank, $amavisd::params::policy_bank)
    $_quarantine_subdir_levels         = pick_default($quarantine_subdir_levels, $amavisd::params::quarantine_subdir_levels)
    $_quarantinedir                    = pick_default($quarantinedir, $amavisd::params::quarantinedir)
    $_recipient_delimiter              = pick_default($recipient_delimiter, $amavisd::params::recipient_delimiter)
    $_redis_logging_key                = pick_default($redis_logging_key, $amavisd::params::redis_logging_key)
    $_redis_logging_queue_size_limit   = pick_default($redis_logging_queue_size_limit, $amavisd::params::redis_logging_queue_size_limit)
    $_release_format                   = pick_default($release_format, $amavisd::params::release_format)
    $_report_format                    = pick_default($report_format, $amavisd::params::report_format)
    $_sa_crediblefrom_dsn_cutoff_level = pick_default($sa_crediblefrom_dsn_cutoff_level, $amavisd::params::sa_crediblefrom_dsn_cutoff_level)
    $_sa_dsn_cutoff_level              = pick_default($sa_dsn_cutoff_level, $amavisd::params::sa_dsn_cutoff_level)
    $_sa_kill_level_deflt              = pick_default($sa_kill_level_deflt, $amavisd::params::sa_kill_level_deflt)
    $_sa_local_tests_only              = pick_default($sa_local_tests_only, $amavisd::params::sa_local_tests_only)
    $_sa_mail_body_size_limit          = pick_default($sa_mail_body_size_limit, $amavisd::params::sa_mail_body_size_limit)
    $_sa_quarantine_cutoff_level       = pick_default($sa_quarantine_cutoff_level, $amavisd::params::sa_quarantine_cutoff_level)
    $_sa_spam_subject_tag              = pick_default($sa_spam_subject_tag, $amavisd::params::sa_spam_subject_tag)
    $_sa_tag2_level_deflt              = pick_default($sa_tag2_level_deflt, $amavisd::params::sa_tag2_level_deflt)
    $_sa_tag_level_deflt               = pick_default($sa_tag_level_deflt, $amavisd::params::sa_tag_level_deflt)
    $_spam_quarantine_to               = pick_default($spam_quarantine_to, $amavisd::params::spam_quarantine_to)
    $_storage_redis_dsn                = pick_default($storage_redis_dsn, $amavisd::params::storage_redis_dsn)
    $_storage_sql_dsn                  = pick_default($storage_sql_dsn, $amavisd::params::storage_sql_dsn)
    $_syslog_facility                  = pick_default($syslog_facility, $amavisd::params::syslog_facility)
    $_tempbase                         = pick_default($tempbase, $amavisd::params::tempbase)
    $_timestamp_fmt_mysql              = pick_default($timestamp_fmt_mysql, $amavisd::params::timestamp_fmt_mysql)
    $_tmpdir                           = pick_default($tmpdir, $amavisd::params::tmpdir)
    $_unix_socketname                  = pick($unix_socketname, "${amavisd::_state_dir}/${amavisd::_service_name}.sock")
    $_virus_admin                      = pick_default($virus_admin, $amavisd::params::virus_admin)
    $_virus_quarantine_to              = pick_default($virus_quarantine_to, $amavisd::params::virus_quarantine_to)
    $_warnbadhrecip                    = pick_default($warnbadhrecip, $amavisd::params::warnbadhrecip)
    $_warnbadhsender                   = pick_default($warnbadhsender, $amavisd::params::warnbadhsender)
    $_warnbannedrecip                  = pick_default($warnbannedrecip, $amavisd::params::warnbannedrecip)
    $_warnvirusrecip                   = pick_default($warnvirusrecip, $amavisd::params::warnvirusrecip)

    anchor { 'amavisd::begin': } ->

    class { 'amavisd::repos': } ->
    class { 'amavisd::install': } ->
    class { 'amavisd::config': } ->
    class { 'amavisd::service': } ->

    anchor { 'amavisd::end': }
}
