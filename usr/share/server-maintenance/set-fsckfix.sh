#!/bin/sh

# enable automatic fsck fix on boot, without hanging while booting on fsck
# good for remote servers

DEBFILE="/etc/default/rcS"

PATH="./:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/local/sbin:/opt/local/bin:/opt/sbin:/opt/bin"

if [ ! -f "$DEBFILE" ]; then
    echo "Debian configuration file not found ($DEBFILE)"
    exit
fi

if [ ! -w "$DEBFILE" ]; then
    echo "ERROR: cannot write to file $DEBFILE" >&2
    exit 1
fi

if [ "`cat $DEBFILE | grep -i fsckfix | wc -l`" -gt "0" ]; then
    #replace
    perl -pi -e 's/FSCKFIX=.*/FSCKFIX=yes/i' "$DEBFILE"
else
    #insert
    echo "FSCKFIX=yes" >> "$DEBFILE"
fi



