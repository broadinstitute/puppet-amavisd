# == Class: amavisd
#
# This is the base amavisd class that should orchestrate the installation of
# all the other pieces that make up the software.
#
# === Parameters
#
#  clamd_service - The name of the clamd service if Amavisd is being used in
#    in conjuction with Clamd.
#    Default: OS-dependent - see params.pp
#
#  config_dir - The directory where the Amavisd configuration files live.
#    Default: OS-dependent - see params.pp
#
#  config_file - The name of the configuration file this module will write.
#    Default: OS-dependent - see params.pp
#
#  daemon_group - The group under which the Amavisd service will run.
#    Note: This will also set the *daemon_group* setting in the Amavisd config.
#    Default: 'amavis'
#
#  daemon_user - The user under which the Amavisd service will run.
#    Note: This will also set the *daemon_user* setting in the Amavisd config.
#    Default: 'amavis'
#
#  include_score_sender_maps - Determine whether to include the *sender_score_maps*
#    template in the final config file.
#    Default: OS-dependent - see params.pp
#
#  manage_epel - Whether or not to include the `epel` class for package installations.
#    Default: OS-dependent - see params.pp
#
#  manage_group - If true, create and manage the *$daemon_group* group.
#    Default: true
#
#  manage_user - If true, create and manage the *$daemon_user* user.
#    Default: true
#
#  package_ensure - If true, manage the package(s) needed for Amavisd.
#    Default: true
#
#  package_name - The name of the Amavisd package to install.
#    Default: 'amavisd-new'
#
#  service_enable - If true, enable the service on the system.
#    Default: true
#
#  service_ensure - Ensure that the service is in this state when Puppet runs.
#    Default: 'running'
#
#  service_name - The name of the service that Puppet should start/stop.
#    Default: OS-dependent - see params.pp
#
#  state_dir - The directory in which Amavisd stores files when it runs.
#    Default: OS-dependent - see params.pp
#
#  user_shell - The shell to use for the user created if *$manage_user* is true.
#    Default: nologin (path to nologin is OS-dependent)
#
# === Parameters with a one-to-one match to Amavisd config file variables
#  addr_extension_bad_header_maps
#  addr_extension_banned_maps
#  addr_extension_spam_maps
#  addr_extension_virus_maps
#  av_scanners
#  av_scanners_backup
#  bad_header_quarantine_method
#  bad_header_quarantine_to
#  banned_filename_re
#  banned_quarantine_to
#  bounce_killer_score
#  bypass_decode_parts
#  bypass_spam_checks_maps
#  bypass_virus_checks_maps
#  clean_quarantine_method
#  config_dir
#  config_file
#  daemon_chroot_dir
#  daemon_group
#  daemon_user
#  db_home
#  decoders
#  defang_bad_header
#  defang_banned
#  defang_by_ccat
#  defang_spam
#  defang_undecipherable
#  defang_virus
#  do_syslog
#  dspam
#  enable_db
#  enable_dkim_signing
#  enable_dkim_verification
#  enable_zmq
#  final_bad_header_destiny
#  final_banned_destiny
#  final_spam_destiny
#  final_virus_destiny
#  forward_method
#  helpers_home
#  inet_socket_bind
#  inet_socket_port
#  interface_policy
#  keep_decoded_original_maps
#  local_domains_maps
#  lock_file
#  log_level
#  log_recip_templ
#  lookup_sql_dsn
#  mailfrom_notify_admin
#  mailfrom_notify_recip
#  mailfrom_notify_spamadmin
#  mailfrom_to_quarantine
#  manage_epel
#  manage_group
#  manage_user
#  max_expansion_quota
#  max_servers
#  maxfiles
#  maxlevels
#  min_expansion_quota
#  mydomain
#  myhome
#  myhostname
#  mynetworks
#  nanny_details_level
#  notify_method
#  os_fingerprint_method
#  package_ensure
#  package_name
#  path
#  penpals_bonus_score
#  penpals_threshold_high
#  pid_file
#  policy_bank
#  quarantine_subdir_levels
#  quarantinedir
#  recipient_delimiter
#  redis_logging_key
#  redis_logging_queue_size_limit
#  release_format
#  report_format
#  sa_crediblefrom_dsn_cutoff_level
#  sa_dsn_cutoff_level
#  sa_kill_level_deflt
#  sa_local_tests_only
#  sa_mail_body_size_limit
#  sa_quarantine_cutoff_level
#  sa_spam_subject_tag
#  sa_tag2_level_deflt
#  sa_tag_level_deflt
#  service_enable
#  service_ensure
#  service_name
#  spam_quarantine_to
#  state_dir
#  storage_redis_dsn
#  storage_sql_dsn
#  syslog_facility
#  tempbase
#  timestamp_fmt_mysql
#  tmpdir
#  unix_socketname
#  virus_admin
#  virus_quarantine_to
#  warnbadhrecip
#  warnbadhsender
#  warnbannedrecip
#  warnvirusrecip
#  watch_clamav
#
# === Examples
#
# === Authors
#
# Andrew Teixeira <teixeira@broadinstitute.org>
#
# === Copyright
#
# Copyright 2018
#
class amavisd (
  Optional[String] $clamd_service                     = undef,
  Optional[String] $config_dir                        = undef,
  Optional[String] $config_file                       = undef,
  Optional[String] $daemon_group                      = 'amavis',
  Optional[String] $daemon_user                       = 'amavis',
  Optional[Boolean] $include_score_sender_maps        = undef,
  Optional[Boolean] $manage_epel                      = undef,
  Boolean $manage_group                               = true,
  Boolean $manage_user                                = true,
  Optional[String] $package_ensure                    = 'present',
  Optional[String] $package_name                      = 'amavisd-new',
  Boolean $service_enable                             = true,
  Enum['stopped', 'running'] $service_ensure          = 'running',
  Optional[String] $service_name                      = undef,
  Optional[String] $state_dir                         = undef,
  Optional[String] $user_shell                        = undef,
  Boolean  $watch_clamav                              = false,
  # Config file options
  Optional[Array] $addr_extension_bad_header_maps     = undef,
  Optional[Array] $addr_extension_banned_maps         = undef,
  Optional[Array] $addr_extension_spam_maps           = undef,
  Optional[Array] $addr_extension_virus_maps          = undef,
  Optional[Array] $av_scanners                        = undef,
  Optional[Array] $av_scanners_backup                 = undef,
  Optional[String] $bad_header_quarantine_method      = undef,
  Optional[Array] $bad_header_quarantine_to           = undef,
  Optional[Array] $banned_filename_re                 = undef,
  Optional[Array] $banned_quarantine_to               = undef,
  Optional[Integer] $bounce_killer_score              = undef,
  Optional[Integer] $bypass_decode_parts              = undef,
  Optional[Array] $bypass_spam_checks_maps            = undef,
  Optional[Array] $bypass_virus_checks_maps           = undef,
  Optional[String] $clean_quarantine_method           = undef,
  Optional[String] $daemon_chroot_dir                 = undef,
  Optional[String] $db_home                           = undef,
  Optional[Array] $decoders                           = undef,
  Optional[Integer] $defang_bad_header                = undef,
  Optional[Integer] $defang_banned                    = undef,
  Optional[Array] $defang_by_ccat                     = undef,
  Optional[Integer] $defang_spam                      = undef,
  Optional[Integer] $defang_undecipherable            = undef,
  Optional[Integer] $defang_virus                     = undef,
  Optional[Integer] $do_syslog                        = undef,
  Optional[String] $dspam                             = undef,
  Optional[Integer] $enable_db                        = undef,
  Optional[Integer] $enable_dkim_signing              = undef,
  Optional[Integer] $enable_dkim_verification         = undef,
  Optional[Integer] $enable_zmq                       = undef,
  Optional[String] $final_bad_header_destiny          = undef,
  Optional[String] $final_banned_destiny              = undef,
  Optional[String] $final_spam_destiny                = undef,
  Optional[String] $final_virus_destiny               = undef,
  Optional[String] $forward_method                    = undef,
  Optional[String] $helpers_home                      = undef,
  Optional[String] $inet_socket_bind                  = undef,
  Optional[Integer] $inet_socket_port                 = undef,
  Optional[Hash] $interface_policy                    = undef,
  Optional[Array] $keep_decoded_original_maps         = undef,
  Optional[Array] $local_domains_maps                 = undef,
  Optional[String] $lock_file                         = undef,
  Optional[Integer] $log_level                        = undef,
  Optional[String] $log_recip_templ                   = undef,
  Optional[Array] $lookup_sql_dsn                     = undef,
  Optional[String] $mailfrom_notify_admin             = undef,
  Optional[String] $mailfrom_notify_recip             = undef,
  Optional[String] $mailfrom_notify_spamadmin         = undef,
  Optional[String] $mailfrom_to_quarantine            = undef,
  Optional[String] $max_expansion_quota               = undef,
  Optional[Integer] $max_servers                      = undef,
  Optional[Integer] $maxfiles                         = undef,
  Optional[Integer] $maxlevels                        = undef,
  Optional[Integer] $min_expansion_quota              = undef,
  Optional[String] $mydomain                          = undef,
  Optional[String] $myhome                            = undef,
  Optional[String] $myhostname                        = undef,
  Optional[Array] $mynetworks                         = undef,
  Optional[Integer] $nanny_details_level              = undef,
  Optional[String] $notify_method                     = undef,
  Optional[String] $os_fingerprint_method             = undef,
  Optional[String] $path                              = undef,
  Optional[String] $penpals_bonus_score               = undef,
  Optional[String] $penpals_threshold_high            = undef,
  Optional[String] $pid_file                          = undef,
  Optional[Hash] $policy_bank                         = undef,
  Optional[Integer] $quarantine_subdir_levels         = undef,
  Optional[String] $quarantinedir                     = undef,
  Optional[String] $recipient_delimiter               = undef,
  Optional[String] $redis_logging_key                 = undef,
  Optional[Integer] $redis_logging_queue_size_limit   = undef,
  Optional[String] $release_format                    = undef,
  Optional[String] $report_format                     = undef,
  Optional[Integer] $sa_crediblefrom_dsn_cutoff_level = undef,
  Optional[Integer] $sa_dsn_cutoff_level              = undef,
  Optional[String] $sa_kill_level_deflt               = undef,
  Optional[Integer] $sa_local_tests_only              = undef,
  Optional[Integer] $sa_mail_body_size_limit          = undef,
  Optional[String] $sa_quarantine_cutoff_level        = undef,
  Optional[String] $sa_spam_subject_tag               = undef,
  Optional[String] $sa_tag2_level_deflt               = undef,
  Optional[String] $sa_tag_level_deflt                = undef,
  Optional[String] $spam_quarantine_to                = undef,
  Optional[String] $storage_redis_dsn                 = undef,
  Optional[String] $storage_sql_dsn                   = undef,
  Optional[String] $syslog_facility                   = undef,
  Optional[String] $tempbase                          = undef,
  Optional[String] $timestamp_fmt_mysql               = undef,
  Optional[String] $tmpdir                            = undef,
  Optional[String] $unix_socketname                   = undef,
  Optional[String] $virus_admin                       = undef,
  Optional[String] $virus_quarantine_to               = undef,
  Optional[Integer] $warnbadhrecip                    = undef,
  Optional[Integer] $warnbadhsender                   = undef,
  Optional[Integer] $warnbannedrecip                  = undef,
  Optional[Integer] $warnvirusrecip                   = undef,
) {
  include ::amavisd::params

  # Service Settings
  $_clamd_service             = pick($clamd_service, $amavisd::params::clamd_service)
  $_config_dir                = pick($config_dir, $amavisd::params::config_dir)
  $_config_file               = pick($config_file, $amavisd::params::config_file)
  $_include_score_sender_maps = pick($include_score_sender_maps, $amavisd::params::include_score_sender_maps)
  $_manage_epel               = pick($manage_epel, $amavisd::params::manage_epel)
  $_service_name              = pick($service_name, $amavisd::params::service_name)
  $_state_dir                 = pick($state_dir, $amavisd::params::state_dir)
  $_user_shell                = pick($user_shell, $amavisd::params::user_shell)

  # Optional[String] $daemon_group                      = 'amavis',
  # Optional[String] $daemon_user                       = 'amavis',
  # Boolean $manage_group                               = true,
  # Boolean $manage_user                                = true,
  # Optional[String] $package_ensure                    = 'present',
  # Optional[String] $package_name                      = 'amavisd-new',
  # Boolean $service_enable                             = true,
  # Enum['stopped', 'running'] $service_ensure          = 'running',
  # Boolean  $watch_clamav                              = false,

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

  anchor { 'amavisd::begin': }

  -> class { 'amavisd::repos': }
  -> class { 'amavisd::install': }
  -> class { 'amavisd::config': }
  -> class { 'amavisd::service': }

  -> anchor { 'amavisd::end': }
}
