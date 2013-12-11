#!/bin/sh

logger "starting autopkg"
/usr/local/bin/autopkg run AdobeFlashPlayer.munki AdobeReader.munki Evernote.munki Firefox.munki GoogleChrome.munki GoogleEarth.munki MSOffice2011Updates.munki OracleJava7.munki TextWrangler.munki VLC.munki Facter.munki Puppet.munki munkitools.munki MakeCatalogs.munki 2>&1 > /tmp/autopkg.out
logger "finished autopkg, status=${?}"

if [ "`diff /tmp/autopkg.out /Users/techdept/Documents/autopkg/autopkg.out`" != "" ]; then	# there are differences from a "Nothing downloaded, packaged or imported" run
  logger "sending autopkg log"
  mail -s "autopkg log" skaiser@northmontschools.net < /tmp/autopkg.out
  logger "sent autopkg log, status=${?}, `wc -l /tmp/autopkg.out` lines in log"
else
  logger "autopkg did nothing, not sending log"
fi

exit 0

