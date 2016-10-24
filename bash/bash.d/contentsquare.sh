#!/bin/sh
#
# ContentSquare aliases

alias puppet-repo='ssh puppetmaster "sudo -u admin -i tools/update-repositories.sh"'
alias puppet-repodis='ssh puppetdis "sudo -u admin -i tools/update-repositories.sh"'
alias influx='influx -host delorean-d28e6515.influxcloud.net -database telemetry -username $INFLUXDB_USERNAME -password $INFLUXDB_PASSWORD -port 8086 -ssl'
