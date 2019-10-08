#!/bin/bash

# Check memory used of host
warn="81"
crit="96"
mem_used=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }' | cut -d "." -f 1)
        if [ $mem_used -lt $warn ]; then
                echo "0 Memory - $mem_used% of memory used"
        elif [ $mem_used -ge $warn ] && [ $mem_used -lt $crit ]; then
                echo "1 Memory - $mem_used% of memory used"
        elif [ $mem_used -ge $crit ]; then
                echo "2 Memory - $mem_used% of memory used"
        fi


# Check filesystem / usage
filesystem_warn="81"
filesystem_crit="96"
filesystem_used=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}' | cut -d "%" -f1)
        if [ $filesystem_used -lt $filesystem_warn ]; then
                echo "0 Filesystem - Filesystem / with $filesystem_used% of used space"
        elif [ $filesystem_used -ge $filesystem_warn ] && [ $filesystem_used -lt $filesystem_crit ]; then
                echo "1 Root filesystem - Filesystem / with $filesystem_used% of used space"
        elif [ $filesystem_used -ge $filesystem_crit ]; then
                echo "2 Root filesystem - Filesystem / with $filesystem_used% of used space"
        fi
