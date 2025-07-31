#!/usr/bin/env bash

logfile=/tmp/sd.log

echo "------------" >> $logfile
date >> $logfile

pgrep -f squirrel-sql > /dev/null 
rc=$?
echo "rc: $rc" >> $logfile

if [ $rc -eq 0 ]
then
	echo "cmd: xdotool search --name '^.*SQuirreL SQL Client' windowactivate" >> /tmp/sd.log
	xdotool search --name '^.*SQuirreL SQL Client' windowactivate
else
	# echo "cmd: flatpak run md.obsidian.Obsidian &" >> /tmp/sd.log
	#flatpak run net.sourceforge.squirrel_sql >> /tmp/sd.log
	echo "cmd: run squirrel-sql &" >> /tmp/sd.log
	# /usr/bin/env squirrel-sql &
	"$HOME/squirrel-sql-4.8.0/squirrel-sql.sh"
fi

date >> $logfile
echo "------------" >> $logfile
