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
    $clamav_config_dir = '/etc/clamd.d'
    $daemon_user       = 'amavis'
    $daemon_group      = 'amavis'
    $package_name      = 'amavisd-new'
    $root_group        = 'root'

    case $::osfamily {
        'Debian': {
            # Service settings
            $config_dir        = '/etc/amavisd/conf.d'
            $config_file       = '60-user'
            $manage_epel       = false
            $service_name      = 'amavis'
            $snmp_package_name = undef
            $snmp_service_name = undef
            $state_dir         = '/var/run/amavis'

            # Config settings
            $addr_extension_bad_header_maps   = undef
            $addr_extension_banned_maps       = undef
            $addr_extension_spam_maps         = undef
            $addr_extension_virus_maps        = undef
            $bounce_killer_score              = undef
            $db_home                          = undef
            $defang_banned                    = undef
            $defang_by_ccat                   = undef
            $defang_virus                     = undef
            $do_syslog                        = undef
            $enable_db                        = undef
            $enable_dkim_signing              = undef
            $enable_dkim_verification         = undef
            $final_bad_header_destiny         = undef
            $final_banned_destiny             = undef
            $final_spam_destiny               = undef
            $final_virus_destiny              = undef
            $inet_socket_port                 = undef
            $interface_policy                 = undef
            $local_domains_maps               = undef
            $log_level                        = undef
            $max_expansion_quota              = undef
            $maxfiles                         = undef
            $maxlevels                        = undef
            $max_servers                      = undef
            $min_expansion_quota              = undef
            $mydomain                         = undef
            $myhome                           = undef
            $mynetworks                       = undef
            $nanny_details_level              = undef
            $path                             = undef
            $penpals_bonus_score              = undef
            $penpals_threshold_high           = undef
            $policy_bank                      = undef
            $sa_crediblefrom_dsn_cutoff_level = undef
            $sa_dsn_cutoff_level              = undef
            $sa_kill_level_deflt              = undef
            $sa_local_tests_only              = undef
            $sa_mail_body_size_limit          = undef
            $sa_spam_subject_tag              = undef
            $sa_tag_level_deflt               = undef
            $sa_tag2_level_deflt              = undef
            $syslog_facility                  = undef
            $tempbase                         = undef
            $tmpdir                           = undef
        }
        'RedHat': {
            # Service settings
            $config_dir                       = '/etc/amavisd'
            $config_file                      = 'amavisd.conf'
            $manage_epel                      = true
            $service_name                     = 'amavisd'
            $snmp_package_name                = 'amavisd-new-snmp'
            $snmp_service_name                = 'amavisd-snmp'
            $state_dir                        = '/var/run/amavisd'

            # Config settings
            $addr_extension_bad_header_maps   = ['badh' ]
            $addr_extension_banned_maps       = [ 'banned' ]
            $addr_extension_spam_maps         = [ 'spam' ]
            $addr_extension_virus_maps        = [ 'virus' ]
            $bounce_killer_score              = '100'
            $db_home                          = '$MYHOME/db'
            $defang_banned                    = '1'
            $defang_by_ccat                   = [
                'CC_BADH.",3"',
                'CC_BADH.",5"',
                'CC_BADH.",6"'
            ]
            $defang_virus                     = '1'
            $do_syslog                        = '1'
            $enable_db                        = '1'
            $enable_dkim_signing              = '1'
            $enable_dkim_verification         = '1'
            $final_bad_header_destiny         = 'D_BOUNCE'
            $final_banned_destiny             = 'D_BOUNCE'
            $final_spam_destiny               = 'D_DISCARD'
            $final_virus_destiny              = 'D_DISCARD'
            $inet_socket_port                 = [ 10024 ]
            $interface_policy                 = {
                '10026' => 'ORIGINATING',
                'SOCK' => 'AM.PDP-SOCK'
            }
            $local_domains_maps               = [ '.$mydomain' ]
            $log_level                        = '0'
            $max_expansion_quota              = '500*1024*1024'
            $maxfiles                         = '3000'
            $maxlevels                        = '14'
            $max_servers                      = '2'
            $min_expansion_quota              = '100*1024'
            $mydomain                         = 'example.com'
            $myhome                           = '/var/spool/amavisd'
            $mynetworks                       = [
                '127.0.0.0/8',
                '[::1]',
                '[FE80::]/10',
                '[FEC0::]/10',
                '10.0.0.0/8',
                '172.16.0.0/12',
                '192.168.0.0/16'
            ]
            $nanny_details_level              = '2'
            $path                             = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/sbin:/usr/bin:/bin'
            $penpals_bonus_score              = '8'
            $penpals_threshold_high           = '$sa_kill_level_deflt'
            $policy_bank                      = {
                'MYNETS' => {
                    originating           => 1,
                    os_fingerprint_method => 'undef'
                },
                'ORIGINATING' => {
                    originating                     => '1',
                    allow_disclaimers               => '1',
                    virus_admin_maps                => '["virusalert\@$mydomain"]',
                    spam_admin_maps                 => '["virusalert\@$mydomain"]',
                    warnbadhsender                  => '1',
                    forward_method                  => "'smtp:[127.0.0.1]:10027'",
                    smtpd_discard_ehlo_keywords     => "['8BITMIME']",
                    bypass_banned_checks_maps       => '[1]',
                    terminate_dsn_on_notify_success => '0'
                },
                'AM.PDP-SOCK' => {
                    protocol => "'AM.PDP'",
                    auth_required_release => '0'
                }
            }
            $sa_crediblefrom_dsn_cutoff_level = '18'
            $sa_dsn_cutoff_level              = '10'
            $sa_kill_level_deflt              = '6.9'
            $sa_local_tests_only              = '0'
            $sa_mail_body_size_limit          = '400*1024'
            $sa_spam_subject_tag              = '***Spam*** '
            $sa_tag_level_deflt               = '2.0'
            $sa_tag2_level_deflt              = '6.2'
            $syslog_facility                  = 'mail'
            $tempbase                         = '$MYHOME/tmp'
            $tmpdir                           = '$TEMPBASE'
        }
        default: {
            fail("Unsupported osfamily: ${::osfamily}")
        }
    }

}
