# == Class: amavisd::config
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
class amavisd::config {

    if ! defined(Class['amavisd']) {
        fail('You must include the amavisd base class before using any amavisd defined resources')
    }

    $addr_extension_bad_header_maps   = $amavisd::_addr_extension_bad_header_maps
    $addr_extension_banned_maps       = $amavisd::_addr_extension_banned_maps
    $addr_extension_spam_maps         = $amavisd::_addr_extension_spam_maps
    $addr_extension_virus_maps        = $amavisd::_addr_extension_virus_maps
    $amavis_conf                      = "${amavisd::_config_dir}/${amavisd::_config_file}"
    $av_scanners                      = $amavisd::_av_scanners
    $av_scanners_backup               = $amavisd::_av_scanners_backup
    $bad_header_quarantine_method     = $amavisd::_bad_header_quarantine_method
    $bad_header_quarantine_to         = $amavisd::_bad_header_quarantine_to
    $banned_filename_re               = $amavisd::_banned_filename_re
    $banned_quarantine_to             = $amavisd::_banned_quarantine_to
    $bounce_killer_score              = $amavisd::_bounce_killer_score
    $bypass_decode_parts              = $amavisd::_bypass_decode_parts
    $bypass_spam_checks_maps          = $amavisd::_bypass_spam_checks_maps
    $bypass_virus_checks_maps         = $amavisd::_bypass_virus_checks_maps
    $clean_quarantine_method          = $amavisd::_clean_quarantine_method
    $daemon_chroot_dir                = $amavisd::_daemon_chroot_dir
    $daemon_group                     = $amavisd::_daemon_group
    $daemon_user                      = $amavisd::_daemon_user
    $db_home                          = $amavisd::_db_home
    $decoders                         = $amavisd::_decoders
    $defang_bad_header                = $amavisd::_defang_bad_header
    $defang_banned                    = $amavisd::_defang_banned
    $defang_by_ccat                   = $amavisd::_defang_by_ccat
    $defang_spam                      = $amavisd::_defang_spam
    $defang_undecipherable            = $amavisd::_defang_undecipherable
    $defang_virus                     = $amavisd::_defang_virus
    $do_syslog                        = $amavisd::_do_syslog
    $dspam                            = $amavisd::_dspam
    $enable_db                        = $amavisd::_enable_db
    $enable_dkim_signing              = $amavisd::_enable_dkim_signing
    $enable_dkim_verification         = $amavisd::_enable_dkim_verification
    $enable_zmq                       = $amavisd::_enable_zmq
    $final_bad_header_destiny         = $amavisd::_final_bad_header_destiny
    $final_banned_destiny             = $amavisd::_final_banned_destiny
    $final_spam_destiny               = $amavisd::_final_spam_destiny
    $final_virus_destiny              = $amavisd::_final_virus_destiny
    $forward_method                   = $amavisd::_forward_method
    $helpers_home                     = $amavisd::_helpers_home
    $include_score_sender_maps        = $amavisd::_include_score_sender_maps
    $inet_socket_bind                 = $amavisd::_inet_socket_bind
    $inet_socket_port                 = $amavisd::_inet_socket_port
    $interface_policy                 = $amavisd::_interface_policy
    $keep_decoded_original_maps       = $amavisd::_keep_decoded_original_maps
    $local_domains_maps               = $amavisd::_local_domains_maps
    $lock_file                        = $amavisd::_lock_file
    $log_level                        = $amavisd::_log_level
    $log_recip_templ                  = $amavisd::_log_recip_templ
    $lookup_sql_dsn                   = $amavisd::_lookup_sql_dsn
    $mailfrom_notify_admin            = $amavisd::_mailfrom_notify_admin
    $mailfrom_notify_recip            = $amavisd::_mailfrom_notify_recip
    $mailfrom_notify_spamadmin        = $amavisd::_mailfrom_notify_spamadmin
    $mailfrom_to_quarantine           = $amavisd::_mailfrom_to_quarantine
    $max_expansion_quota              = $amavisd::_max_expansion_quota
    $max_servers                      = $amavisd::_max_servers
    $maxfiles                         = $amavisd::_maxfiles
    $maxlevels                        = $amavisd::_maxlevels
    $min_expansion_quota              = $amavisd::_min_expansion_quota
    $mydomain                         = $amavisd::_mydomain
    $myhome                           = $amavisd::_myhome
    $myhostname                       = $amavisd::_myhostname
    $mynetworks                       = $amavisd::_mynetworks
    $nanny_details_level              = $amavisd::_nanny_details_level
    $notify_method                    = $amavisd::_notify_method
    $os_fingerprint_method            = $amavisd::_os_fingerprint_method
    $path                             = $amavisd::_path
    $penpals_bonus_score              = $amavisd::_penpals_bonus_score
    $penpals_threshold_high           = $amavisd::_penpals_threshold_high
    $pid_file                         = $amavisd::_pid_file
    $policy_bank                      = $amavisd::_policy_bank
    $quarantine_subdir_levels         = $amavisd::_quarantine_subdir_levels
    $quarantinedir                    = $amavisd::_quarantinedir
    $recipient_delimiter              = $amavisd::_recipient_delimiter
    $redis_logging_key                = $amavisd::_redis_logging_key
    $redis_logging_queue_size_limit   = $amavisd::_redis_logging_queue_size_limit
    $release_format                   = $amavisd::_release_format
    $report_format                    = $amavisd::_report_format
    $sa_crediblefrom_dsn_cutoff_level = $amavisd::_sa_crediblefrom_dsn_cutoff_level
    $sa_dsn_cutoff_level              = $amavisd::_sa_dsn_cutoff_level
    $sa_kill_level_deflt              = $amavisd::_sa_kill_level_deflt
    $sa_local_tests_only              = $amavisd::_sa_local_tests_only
    $sa_mail_body_size_limit          = $amavisd::_sa_mail_body_size_limit
    $sa_quarantine_cutoff_level       = $amavisd::_sa_quarantine_cutoff_level
    $sa_spam_subject_tag              = $amavisd::_sa_spam_subject_tag
    $sa_tag2_level_deflt              = $amavisd::_sa_tag2_level_deflt
    $sa_tag_level_deflt               = $amavisd::_sa_tag_level_deflt
    $spam_quarantine_to               = $amavisd::_spam_quarantine_to
    $storage_redis_dsn                = $amavisd::_storage_redis_dsn
    $storage_sql_dsn                  = $amavisd::_storage_sql_dsn
    $syslog_facility                  = $amavisd::_syslog_facility
    $tempbase                         = $amavisd::_tempbase
    $timestamp_fmt_mysql              = $amavisd::_timestamp_fmt_mysql
    $tmpdir                           = $amavisd::_tmpdir
    $unix_socketname                  = $amavisd::_unix_socketname
    $virus_admin                      = $amavisd::_virus_admin
    $virus_quarantine_to              = $amavisd::_virus_quarantine_to
    $warnbadhrecip                    = $amavisd::_warnbadhrecip
    $warnbadhsender                   = $amavisd::_warnbadhsender
    $warnbannedrecip                  = $amavisd::_warnbannedrecip
    $warnvirusrecip                   = $amavisd::_warnvirusrecip

    concat { $amavis_conf:
        ensure => 'present',
        backup => false,
        owner  => 'root',
        group  => $amavisd::params::root_group,
        mode   => '0644'
    }

    concat::fragment { 'amavis_header':
        target  => $amavis_conf,
        content => template('amavisd/header.conf.erb'),
        order   => '01'
    }

    concat::fragment { 'amavis_main':
        target  => $amavis_conf,
        content => template('amavisd/main.conf.erb'),
        order   => '05'
    }

    if $include_score_sender_maps {
        concat::fragment { 'amavis_score_sender_maps':
            target  => $amavis_conf,
            content => template('amavisd/score_sender_maps.conf.erb'),
            order   => '30'
        }
    }

    concat::fragment { 'amavis_footer':
        target  => $amavis_conf,
        content => template('amavisd/footer.conf.erb'),
        order   => '99'
    }

    #sender_scores
    #clamd.d/amavisd.conf
    #sysconfig, sysconfig/clamd.amavisd?
}
