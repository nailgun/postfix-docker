#!/bin/sh

set -e

pidfile=/var/spool/postfix/pid/master.pid

# fake syslog
socat UNIX-RECV:/dev/log,mode=666 STDOUT &

# disable due to EAI support is not compiled in (Alpine)
postconf -e smtputf8_enable=no

postconf_args=

while [[ $# -gt 0 ]]; do
    if [ "$1" = ":" ]; then
        postconf $postconf_args
        postconf_args=
    else
        postconf_args="$postconf_args $1"
    fi
    shift
done

if [ -n "$postconf_args" ]; then
    postconf $postconf_args
fi

unset postconf_args

trap "postfix stop" SIGINT
trap "postfix stop" SIGTERM
trap "postfix reload" SIGHUP

# start postfix
postfix start &> /dev/null

# lets give postfix some time to start
while [ -n $pidfile ]; do
    sleep 1
done

pid=`cat $pidfile`

# wait until postfix is dead (triggered by trap)
while kill -0 "$pid"; do
    sleep 5
    ls -l /var/log
done
