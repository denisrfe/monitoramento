#!/bin/bash
# /usr/lib/check_mk_agent/local/mk_updates.sh
# Ths script monitor apt updates pending on system.
#
# Denis Rodrigues Ferreira
# 30/09/2019

#### Check pending updates
UPGRADE=upgrade
DO_UPDATE=yes

function check_apt_update {
    if [ "$DO_UPDATE" = yes ] ; then
        # NOTE: Even with -qq, apt-get update can output several lines to
        # stderr, e.g.:
        #
        # W: There is no public key available for the following key IDs:
        # 1397BC53640DB551
        apt-get update -qq 2> /dev/null
    fi
    apt-get -o 'Debug::NoLocking=true' -o 'APT::Get::Show-User-Simulation-Note=false' -s -qq "$UPGRADE" | grep -v '^Conf'
}


if type apt-get > /dev/null ; then
    echo '<<<apt:sep(0)>>>'
    out=$(check_apt_update)
    if [ -z "$out" ]; then
        echo "No updates pending for installation"
    else
        echo "$out"
    fi
fi
