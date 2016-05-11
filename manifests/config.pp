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
class amavisd::config (
    $bypass_virus_checks_maps         = undef,
    $bypass_spam_checks_maps          = undef,
    $bypass_decode_parts              = undef,
    $max_servers                      = 2,
    $daemon_user                      = undef,
    $daemon_group                     = undef,
    $mydomain                         = 'example.com',
    $myhome                           = '/var/spool/amavisd',
    $tempbase                         = '$MYHOME/tmp',
    $tmpdir                           = '$TEMPBASE',
    $quarantinedir                    = undef,
    $quarantine_subdir_levels         = undef,
    $release_format                   = undef,
    $report_format                    = undef,
    $daemon_chroot_dir                = undef,
    $db_home                          = '$MYHOME/db',
    $helpers_home                     = undef,
    $lock_file                        = undef,
    $pid_file                         = undef,
    $log_level                        = 0,
    $log_recip_templ                  = undef,
    $do_syslog                        = 1,
    $syslog_facility                  = 'mail',
    $enable_db                        = 1,
    $enable_zmq                       = undef,
    $nanny_details_level              = 2,
    $enable_dkim_verification         = 1,
    $enable_dkim_signing              = 1,
    $local_domains_maps               = [ '.$mydomain' ],
    $unix_socketname                  = undef,
    $inet_socket_port                 = [ 10024 ],
    $sa_tag_level_deflt               = '2.0',
    $sa_tag2_level_deflt              = '6.2',
    $sa_kill_level_deflt              = '6.9',
    $sa_dsn_cutoff_level              = '10',
    $sa_crediblefrom_dsn_cutoff_level = '18',
    $sa_quarantine_cutoff_level       = undef,
    $penpals_bonus_score              = '8',
    $penpals_threshold_high           = '$sa_kill_level_deflt',
    $bounce_killer_score              = '100',
    $sa_mail_body_size_limit          = '400*1024',
    $sa_local_tests_only              = '0',
    $lookup_sql_dsn                   = undef,
    $storage_sql_dsn                  = undef,
    $storage_redis_dsn                = undef,
    $redis_logging_key                = undef,
    $redis_logging_queue_size_limit   = undef,
    $timestamp_fmt_mysql              = undef,
    $virus_admin                      = undef,
    $mailfrom_notify_admin            = undef,
    $mailfrom_notify_recip            = undef,
    $mailfrom_notify_spamadmin        = undef,
    $mailfrom_to_quarantine           = undef,
    $addr_extension_virus_maps        = [ 'virus' ],
    $addr_extension_banned_maps       = [ 'banned' ],
    $addr_extension_spam_maps         = [ 'spam' ],
    $addr_extension_bad_header_maps   = ['badh' ],
    $recipient_delimiter              = undef,
    $path                             = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/sbin:/usr/bin:/bin',
    $dspam                            = undef,
    $maxlevels                        = '14',
    $maxfiles                         = '3000',
    $min_expansion_quota              = '100*1024',
    $max_expansion_quota              = '500*1024*1024',
    $sa_spam_subject_tag              = '***Spam*** ',
    $defang_virus                     = '1',
    $defang_banned                    = '1',
    $myhostname                       = undef,
    $notify_method                    = undef,
    $forward_method                   = undef,
    $final_virus_destiny              = 'D_DISCARD',
    $final_banned_destiny             = 'D_BOUNCE',
    $final_spam_destiny               = 'D_DISCARD',
    $final_bad_header_destiny         = 'D_BOUNCE',
    $bad_header_quarantine_method     = undef,
    $os_fingerprint_method            = undef,
    $warnbadhsender                   = undef,
    $warnvirusrecip                   = undef,
    $warnbannedrecip                  = undef,
    $warnbadhrecip                    = undef,
    $bypass_banned_checks_maps        = undef,
    $bypass_header_checks_maps        = undef,
    $virus_lovers_maps                = undef,
    $spam_lovers_maps                 = undef,
    $banned_files_lovers_maps         = undef,
    $bad_header_lovers_maps           = undef,
    $blacklist_sender_maps            = undef,
    $clean_quarantine_method          = undef,
    $virus_quarantine_to              = undef,
    $banned_quarantine_to             = undef,
    $bad_header_quarantine_to         = undef,
    $spam_quarantine_to               = undef,
    $defang_bad_header                = undef,
    $defang_undecipherable            = undef,
    $defang_spam                      = undef,
    $mynetworks                       = [
        '127.0.0.0/8',
        '[::1]',
        '[FE80::]/10',
        '[FEC0::]/10',
        '10.0.0.0/8',
        '172.16.0.0/12',
        '192.168.0.0/16'
    ],
    $policy_bank                      = {
        'MYNETS' => {
            originating => 1,
            os_fingerprint_method => 'undef'
        },
        'ORIGINATING' => {
            originating => '1',
            allow_disclaimers => '1',
            virus_admin_maps => '["virusalert\@$mydomain"]',
            spam_admin_maps  => '["virusalert\@$mydomain"]',
            warnbadhsender   => '1',
            forward_method => "'smtp:[127.0.0.1]:10027'",
            smtpd_discard_ehlo_keywords => "['8BITMIME']",
            bypass_banned_checks_maps => '[1]',
            terminate_dsn_on_notify_success => '0'
        },
        'AM.PDP-SOCK' => {
            protocol => "'AM.PDP'",
            auth_required_release => '0',
        }
    },
    $interface_policy                 = {
        '10026' => 'ORIGINATING',
        'SOCK' => 'AM.PDP-SOCK',
    },

    $defang_by_ccat                   = [
        'CC_BADH.",3"',
        'CC_BADH.",5"',
        'CC_BADH.",6"'
    ],
) {

    if ! defined(Class['amavisd']) {
        fail('You must include the amavisd base class before using any amavisd defined resources')
    }

    $_daemon_user = pick($daemon_user, $amavisd::_daemon_user)
    $_daemon_group = pick($daemon_group, $amavisd::_daemon_group)
    $_lock_file = pick($lock_file, "${amavisd::_state_dir}/${amavisd::_service_name}.lock")
    $_pid_file = pick($pid_file, "${amavisd::_state_dir}/${amavisd::_service_name}.pid")
    $_unix_socketname = pick($unix_socketname, "${amavisd::_state_dir}/${amavisd::_service_name}.sock")

    $amavis_conf = "${amavisd::_config_dir}/${amavisd::_config_file}"

    concat { $amavis_conf:
        ensure => 'present',
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

    concat::fragment { 'amavis_keep_decoded_original_maps':
        target  => $amavis_conf,
        content => template('amavisd/keep_decoded_original_maps.conf.erb'),
        order   => '10'
    }

    concat::fragment { 'amavis_banned_filename_re':
        target  => $amavis_conf,
        content => template('amavisd/banned_filename_re.conf.erb'),
        order   => '20'
    }

    concat::fragment { 'amavis_score_sender_maps':
        target  => $amavis_conf,
        content => template('amavisd/score_sender_maps.conf.erb'),
        order   => '30'
    }

    concat::fragment { 'amavis_decoders':
        target  => $amavis_conf,
        content => template('amavisd/decoders.conf.erb'),
        order   => '40'
    }

    concat::fragment { 'amavis_av_scanners':
        target  => $amavis_conf,
        content => template('amavisd/av_scanners.conf.erb'),
        order   => '50'
    }

    concat::fragment { 'amavis_av_scanners_backup':
        target  => $amavis_conf,
        content => template('amavisd/av_scanners_backup.conf.erb'),
        order   => '70'
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
