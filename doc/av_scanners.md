# av_scanners

There are a lot of AV scanners out there, and trying to configure any in this
module is a bit beyond its scope.  Therefore, we made it a variable you can
set (`$av_scanners`) with some crazy Perl-like configurations.  Below are some
examples of how to do this in Puppet language such that they show up correctly
in the configuration.

I tried to find a good resource to show examples for all the various scanners,
but the easiest way to find that information is to download the source (or
go view the source if you can find a source code viewer for Amavis) and look
at the default `amavisd.conf` file.  It has examples of how to configure Amavis
to talk to many many different virus scanners.

*NOTE: You must escape any Perl backslash escapes to translate it through to
the config file or you will get a compilation error.*

## SAV Dynamic Interface ( http://www.sophos.com/ )
$av_scanners = [
  "['Sophos-SSSP'",
  "\\&ask_daemon",
  "[\"{}\", 'sssp:/var/run/savdi/sssp.sock']",
  # or: "[\"{}\", 'sssp:[127.0.0.1]:4010']",
  "qr/^DONE OK\\b/m, qr/^VIRUS\\b/m, qr/^VIRUS\\s*(\S*)/m ]"
]

## http://www.clamav.net/
$av_scanners = [
  "['ClamAV-clamd'",
  "\\&ask_daemon",
  "[\"CONTSCAN {}\\n\", '/var/run/clamd.amavisd/clamd.sock']",
  "qr/\\bOK$/m, qr/\\bFOUND$/m",
  "qr/^.*?: (?!Infected Archive)(.*) FOUND$/m ]"
]

## Multiple scanners

You can combine multiple scanners together by carefully combining everything
together, such as:

$av_scanners = [
  "['Sophos-SSSP'",
  "\\&ask_daemon",
  "[\"{}\", 'sssp:/var/run/savdi/sssp.sock']",
  # or: "[\"{}\", 'sssp:[127.0.0.1]:4010']",
  "qr/^DONE OK\\b/m, qr/^VIRUS\\b/m, qr/^VIRUS\\s*(\S*)/m ]",

  "['ClamAV-clamd'",
  "\\&ask_daemon",
  "[\"CONTSCAN {}\n\", '/var/run/clamd.amavisd/clamd.sock']",
  "qr/\\bOK$/m, qr/\\bFOUND$/m",
  "qr/^.*?: (?!Infected Archive)(.*) FOUND$/m ]",
]

This is not at all ideal, but short of writing a conversion layer to convert
Puppet data types 100% to Perl variables, this is the best we could do.
