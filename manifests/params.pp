# == Class: amavisd::params
#
# The default parameters for the amavisd class
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
# === Authors
#
# Andrew Teixeira <teixeira@broadinstitute.org>
#
# === Copyright
#
# Copyright 2016
#
class amavisd::params {
    # Service settings
    $clamav_config_dir = '/etc/clamd.d'
    $daemon_user       = 'amavis'
    $daemon_group      = 'amavis'
    $manage_group      = true
    $manage_user       = true
    $package_name      = 'amavisd-new'
    $root_group        = 'root'

    # Config settings
    $av_scanners                    = undef
    $av_scanners_backup             = undef
    $bad_header_quarantine_method   = undef
    $bad_header_quarantine_to       = undef
    $banned_quarantine_to           = undef
    $bypass_decode_parts            = []
    $bypass_spam_checks_maps        = []
    $bypass_virus_checks_maps       = []
    $clean_quarantine_method        = undef
    $daemon_chroot_dir              = undef
    $defang_bad_header              = undef
    $defang_spam                    = undef
    $defang_undecipherable          = undef
    $dspam                          = undef
    $enable_zmq                     = undef
    $forward_method                 = undef
    $helpers_home                   = undef
    $log_recip_templ                = undef
    $lookup_sql_dsn                 = []
    $mailfrom_notify_admin          = undef
    $mailfrom_notify_recip          = undef
    $mailfrom_notify_spamadmin      = undef
    $mailfrom_to_quarantine         = undef
    $myhostname                     = undef
    $notify_method                  = undef
    $os_fingerprint_method          = undef
    $quarantine_subdir_levels       = undef
    $quarantinedir                  = undef
    $recipient_delimiter            = undef
    $redis_logging_key              = undef
    $redis_logging_queue_size_limit = undef
    $release_format                 = undef
    $report_format                  = undef
    $sa_quarantine_cutoff_level     = undef
    $spam_quarantine_to             = undef
    $storage_redis_dsn              = []
    $storage_sql_dsn                = undef
    $timestamp_fmt_mysql            = undef
    $virus_admin                    = undef
    $virus_quarantine_to            = undef
    $warnbadhrecip                  = undef
    $warnbadhsender                 = undef
    $warnbannedrecip                = undef
    $warnvirusrecip                 = undef

    case $::osfamily {
        'Debian': {
            # Service settings
            $clamd_service     = 'clamd'
            $config_dir        = '/etc/amavis/conf.d'
            $config_file       = '60-puppet'
            $manage_epel       = false
            $service_name      = 'amavis'
            $snmp_package_name = undef
            $snmp_service_name = undef
            $state_dir         = '/var/run/amavis'
            $user_shell        = '/usr/sbin/nologin'

            # Config settings
            $addr_extension_bad_header_maps     = []
            $addr_extension_banned_maps         = []
            $addr_extension_spam_maps           = []
            $addr_extension_virus_maps          = []
            $banned_filename_re                 = undef
            $bounce_killer_score                = undef
            $db_home                            = undef
            $decoders                           = undef
            $defang_banned                      = undef
            $defang_by_ccat                     = []
            $defang_virus                       = undef
            $do_syslog                          = undef
            $enable_db                          = undef
            $enable_dkim_signing                = undef
            $enable_dkim_verification           = undef
            $final_bad_header_destiny           = undef
            $final_banned_destiny               = undef
            $final_spam_destiny                 = undef
            $final_virus_destiny                = undef
            $include_score_sender_maps          = false
            $inet_socket_bind                   = undef
            $inet_socket_port                   = []
            $interface_policy                   = {}
            $keep_decoded_original_maps         = []
            $local_domains_maps                 = []
            $log_level                          = undef
            $max_expansion_quota                = undef
            $max_servers                        = undef
            $maxfiles                           = undef
            $maxlevels                          = undef
            $min_expansion_quota                = undef
            $mydomain                           = undef
            $myhome                             = '/var/lib/amavis'
            $mynetworks                         = []
            $nanny_details_level                = undef
            $path                               = undef
            $penpals_bonus_score                = undef
            $penpals_threshold_high             = undef
            $policy_bank                        = {}
            $sa_crediblefrom_dsn_cutoff_level   = undef
            $sa_dsn_cutoff_level                = undef
            $sa_kill_level_deflt                = undef
            $sa_local_tests_only                = undef
            $sa_mail_body_size_limit            = undef
            $sa_spam_subject_tag                = undef
            $sa_tag2_level_deflt                = undef
            $sa_tag_level_deflt                 = undef
            $syslog_facility                    = undef
            $tempbase                           = undef
            $tmpdir                             = undef
        }
        'RedHat': {
            # Service settings
            $clamd_service                      = 'clamd'
            $config_dir                         = '/etc/amavisd'
            $config_file                        = 'amavisd.conf'
            $manage_epel                        = true
            $service_name                       = 'amavisd'
            $snmp_package_name                  = 'amavisd-new-snmp'
            $snmp_service_name                  = 'amavisd-snmp'
            $state_dir                          = '/var/run/amavisd'
            $user_shell                         = '/sbin/nologin'

            # Config settings
            $addr_extension_bad_header_maps     = ['badh' ]
            $addr_extension_banned_maps         = [ 'banned' ]
            $addr_extension_spam_maps           = [ 'spam' ]
            $addr_extension_virus_maps          = [ 'virus' ]
            $banned_filename_re                 = [
                "qr'^\\.(exe-ms|dll)$'",
                "[ qr'^\\.(rpm|cpio|tar)$'       => 0 ]",
                "qr'.\\.(pif|scr)$'i",
                "qr'^application/x-msdownload$'i",
                "qr'^application/x-msdos-program$'i",
                "qr'^application/hta$'i",
                "qr'^(?!cid:).*\\.[^./]*[A-Za-z][^./]*\\.\\s*(exe|vbs|pif|scr|bat|cmd|com|cpl|dll)[.\\s]*$'i",
                "qr'.\\.(exe|vbs|pif|scr|cpl)$'i"
            ]
            $bounce_killer_score                = 100
            $db_home                            = '$MYHOME/db'
            $decoders                           = [
                "['mail', \\&do_mime_decode]",
                "['F',    \\&do_uncompress, ['unfreeze', 'freeze -d', 'melt', 'fcat'] ]",
                "['Z',    \\&do_uncompress, ['uncompress', 'gzip -d', 'zcat'] ]",
                "['gz',   \\&do_uncompress, 'gzip -d']",
                "['gz',   \\&do_gunzip]",
                "['bz2',  \\&do_uncompress, 'bzip2 -d']",
                "['xz',   \\&do_uncompress, ['xzdec', 'xz -dc', 'unxz -c', 'xzcat'] ]",
                "['lzma', \\&do_uncompress, ['lzmadec', 'xz -dc --format=lzma','lzma -dc', 'unlzma -c', 'lzcat', 'lzmadec'] ]",
                "['lrz',  \\&do_uncompress, ['lrzip -q -k -d -o -', 'lrzcat -q -k'] ]",
                "['lzo',  \\&do_uncompress, 'lzop -d']",
                "['lz4',  \\&do_uncompress, ['lz4c -d'] ]",
                "['rpm',  \\&do_uncompress, ['rpm2cpio.pl', 'rpm2cpio'] ]",
                "[['cpio','tar'], \\&do_pax_cpio, ['pax', 'gcpio', 'cpio'] ]",
                "['deb',  \\&do_ar, 'ar']",
                "['rar',  \\&do_unrar, ['unrar', 'rar'] ]",
                "['arj',  \\&do_unarj, ['unarj', 'arj'] ]",
                "['arc',  \\&do_arc,   ['nomarch', 'arc'] ]",
                "['zoo',  \\&do_zoo,   ['zoo', 'unzoo'] ]",
                "['cab',  \\&do_cabextract, 'cabextract']",
                "['tnef', \\&do_tnef]",
                "[['zip','kmz'], \\&do_7zip,  ['7za', '7z'] ]",
                "[['zip','kmz'], \\&do_unzip]",
                "['7z', \\&do_7zip,  ['7zr', '7za', '7z'] ]",
                "[[qw(gz bz2 Z tar)], \\&do_7zip,  ['7za', '7z'] ]",
                "[[qw(xz lzma jar cpio arj rar swf lha iso cab deb rpm)], \\&do_7zip,  '7z' ]",
                "['exe',  \\&do_executable, ['unrar','rar'], 'lha', ['unarj','arj'] ]"
            ]
            $defang_banned                      = 1
            $defang_by_ccat                     = [
                'CC_BADH.",3"',
                'CC_BADH.",5"',
                'CC_BADH.",6"'
            ]
            $defang_virus                       = 1
            $do_syslog                          = 1
            $enable_db                          = 1
            $enable_dkim_signing                = 1
            $enable_dkim_verification           = 1
            $final_bad_header_destiny           = 'D_BOUNCE'
            $final_banned_destiny               = 'D_BOUNCE'
            $final_spam_destiny                 = 'D_DISCARD'
            $final_virus_destiny                = 'D_DISCARD'
            $include_score_sender_maps          = true
            $inet_socket_bind                   = '127.0.0.1'
            $inet_socket_port                   = [ 10024 ]
            $interface_policy                   = {
                '10026' => 'ORIGINATING',
                'SOCK' => 'AM.PDP-SOCK'
            }
            $keep_decoded_original_maps         =  [
                "qr'^MAIL$'",
                "qr'^MAIL-UNDECIPHERABLE$'",
                "qr'^(ASCII(?! cpio)|text|uuencoded|xxencoded|binhex)'i",
            ]
            $local_domains_maps                 = [ '.$mydomain' ]
            $log_level                          = 0
            $max_expansion_quota                = 500*1024*1024
            $maxfiles                           = 3000
            $maxlevels                          = 14
            $max_servers                        = 2
            $min_expansion_quota                = '100*1024'
            $mydomain                           = 'example.com'
            $myhome                             = '/var/spool/amavisd'
            $mynetworks                         = [
                '127.0.0.0/8',
                '[::1]',
                '[FE80::]/10',
                '[FEC0::]/10',
                '10.0.0.0/8',
                '172.16.0.0/12',
                '192.168.0.0/16'
            ]
            $nanny_details_level                = 2
            $path                               = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/sbin:/usr/bin:/bin'
            $penpals_bonus_score                = 8
            $penpals_threshold_high             = '$sa_kill_level_deflt'
            $policy_bank                        = {
                'MYNETS' => {
                    originating           => 1,
                    os_fingerprint_method => 'undef'
                },
                'ORIGINATING' => {
                    originating                     => 1,
                    allow_disclaimers               => 1,
                    virus_admin_maps                => '["virusalert\@$mydomain"]',
                    spam_admin_maps                 => '["virusalert\@$mydomain"]',
                    warnbadhsender                  => 1,
                    forward_method                  => "'smtp:[127.0.0.1]:10027'",
                    smtpd_discard_ehlo_keywords     => "['8BITMIME']",
                    bypass_banned_checks_maps       => '[1]',
                    terminate_dsn_on_notify_success => 0
                },
                'AM.PDP-SOCK' => {
                    protocol => "'AM.PDP'",
                    auth_required_release => '0'
                }
            }
            $sa_crediblefrom_dsn_cutoff_level   = 18
            $sa_dsn_cutoff_level                = 10
            $sa_kill_level_deflt                = '6.9'
            $sa_local_tests_only                = 0
            $sa_mail_body_size_limit            = '400*1024'
            $sa_spam_subject_tag                = '***Spam*** '
            $sa_tag_level_deflt                 = '2.0'
            $sa_tag2_level_deflt                = '6.2'
            $syslog_facility                    = 'mail'
            $tempbase                           = '$MYHOME/tmp'
            $tmpdir                             = '$TEMPBASE'

        }
        default: {
            fail("Unsupported osfamily: ${::osfamily}")
        }
    }

}
