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
#bypass_virus_checks_maps
#bypass_spam_checks_maps
#bypass_decode_parts
$max_servers = 2;            # num of pre-forked children (2..30 is common), -m
$daemon_user  = 'amavis';    # (no default;  customary: vscan or amavis), -u
$daemon_group = 'amavis';    # (no default;  customary: vscan or amavis), -g
$mydomain = 'example.com';   # a convenient default for other settings
$MYHOME = '/var/spool/amavisd';   # a convenient default for other settings, -H
$TEMPBASE = "$MYHOME/tmp";   # working directory, needs to exist, -T
$ENV{TMPDIR} = $TEMPBASE;    # environment variable TMPDIR, used by SA, etc.
$QUARANTINEDIR = undef;      # -Q
# $quarantine_subdir_levels = 1;  # add level of subdirs to disperse quarantine
# $release_format = 'resend';     # 'attach', 'plain', 'resend'
# $report_format  = 'arf';        # 'attach', 'plain', 'resend', 'arf'

# $daemon_chroot_dir = $MYHOME;   # chroot directory or undef, -R

$db_home   = "$MYHOME/db";        # dir for bdb nanny/cache/snmp databases, -D
# $helpers_home = "$MYHOME/var";  # working directory for SpamAssassin, -S
$lock_file = "/var/run/amavisd/amavisd.lock";  # -L
$pid_file  = "/var/run/amavisd/amavisd.pid";   # -P

$log_level = 0;              # verbosity 0..5, -d
$log_recip_templ = undef;    # disable by-recipient level-0 log entries
$do_syslog = 1;              # log via syslogd (preferred)
$syslog_facility = 'mail';   # Syslog facility as a string

$enable_db = 1;              # enable use of BerkeleyDB/libdb (SNMP and nanny)
# $enable_zmq = 1;           # enable use of ZeroMQ (SNMP and nanny)
$nanny_details_level = 2;    # nanny verbosity: 1: traditional, 2: detailed
$enable_dkim_verification = 1;  # enable DKIM signatures verification
$enable_dkim_signing = 1;    # load DKIM signing code, keys defined by dkim_key

@local_domains_maps = ( [".$mydomain"] );  # list of all local domains

@mynetworks = qw( 127.0.0.0/8 [::1] [FE80::]/10 [FEC0::]/10
                  10.0.0.0/8 172.16.0.0/12 192.168.0.0/16 );

$unix_socketname = "/var/run/amavisd/amavisd.sock";  # amavisd-release or amavis-milter

    $amavis_conf = "${amavisd::_config_dir}/${amavisd::_config_file}"
    concat { $amavis_conf:
        ensure => file,
        owner => 'root',
        group => $amavisd::root_group,
        mode => '0644'
    }

    concat::fragment { 'amavis_header':
        target => $amavis_conf,
        content => template('amavisd/header.conf.erb'),
        order => '01'
    }

    concat::fragment { 'amavis_keep_decoded_original_maps':
        target => $amavis_conf,
        content => template('amavisd/keep_decoded_original_maps.conf.erb'),
        order => '10'
    }

    concat::fragment { 'amavis_banned_filename_re':
        target => $amavis_conf,
        content => template('amavisd/banned_filename_re.conf.erb'),
        order => '20'
    }

    concat::fragment { 'amavis_score_sender_maps':
        target => $amavis_conf,
        content => template('amavisd/score_sender_maps.conf.erb'),
        order => '30'
    }

    concat::fragment { 'amavis_decoders':
        target => $amavis_conf,
        content => template('amavisd/decoders.conf.erb'),
        order => '40'
    }

    concat::fragment { 'amavis_av_scanners':
        target => $amavis_conf,
        content => template('amavisd/av_scanners.conf.erb'),
        order => '50'
    }

    concat::fragment { 'amavis_av_scanners_backup':
        target => $amavis_conf,
        content => template('amavisd/av_scanners_backup.conf.erb'),
        order => '70'
    }

    concat::fragment { 'amavis_footer':
        target => $amavis_conf,
        content => template('amavisd/footer.conf.erb'),
        order => '99'
    }

    #sender_scores
    #clamd.d/amavisd.conf
    #sysconfig, sysconfig/clamd.amavisd?
}
