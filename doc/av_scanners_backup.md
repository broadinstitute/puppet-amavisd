# av_scanners

There are a lot of AV scanners out there, and trying to configure any in this
module is a bit beyond its scope.  Therefore, we made it a variable you can
set (`$av_scanners_backup`) with some crazy Perl-like configurations.  Below are some
examples of how to do this in Puppet language such that they show up correctly
in the configuration.

*NOTE: You must escape any Perl backslash escapes to translate it through to
the config file or you will get a compilation error.*

## http://www.clamav.net/   - backs up clamd or Mail::ClamAV
$av_scanners_backup = [
  "['ClamAV-clamscan'",
  "'clamscan'",
  '"--stdout --no-summary -r --tempdir=$TEMPBASE {}"',
  "[0], qr/:.*\sFOUND$/m, qr/^.*?: (?!Infected Archive)(.*) FOUND$/m ]"
]

## http://www.f-prot.com/   - backs up F-Prot Daemon, V6
$av_scanners_backup = [
  "['F-PROT Antivirus for UNIX'",
  "['fpscan']",
  "'--report --mount --adware {}'",
  "[0,8,64]",
  "[1,2,3, 4+1,4+2,4+3, 8+1,8+2,8+3, 12+1,12+2,12+3]",
  "qr/^\\[Found\s+[^\\]]*\\]\s+<([^ \\t(>]*)/m ]"
]

## Multiple scanners

As with `av_scanners`, multiple backup scanners can be combined together by
carefully merging multiple Puppet arrays together:

$av_scanners_backup = [
  "['ClamAV-clamscan'",
  "'clamscan'",
  '"--stdout --no-summary -r --tempdir=$TEMPBASE {}"',
  "[0], qr/:.*\sFOUND$/m, qr/^.*?: (?!Infected Archive)(.*) FOUND$/m ]",

  "['F-PROT Antivirus for UNIX'",
  "['fpscan']",
  "'--report --mount --adware {}'",
  "[0,8,64]",
  "[1,2,3, 4+1,4+2,4+3, 8+1,8+2,8+3, 12+1,12+2,12+3]",
  "qr/^\\[Found\s+[^\\]]*\\]\s+<([^ \\t(>]*)/m ]"
]
