#!/bin/bash
# /usr/lib/check_mk_agent/local/mk_docker_node.sh
# Ths script monitor docker instances on this host, number of containers.
# Save container's stats command to output.containers
#
# Denis Rodrigues Ferreira
# 11/09/2019



cont_total=$( docker stats --no-stream | grep -v CONTAINER | wc -l)
cont_running=$(docker ps | grep Up | wc -l)
cont_paused=$(docker ps | grep Paused | wc -l)
cont_stopped=$(docker ps | grep Exited | wc -l)

echo "0 Containers - $cont_total containers, $cont_running running, $cont_paused paused, $cont_stopped stopped"

docker_images=$(docker images | grep -v REPOSITORY | wc -l)
echo "0 Docker_images - There is $docker_images docker images"


# FIXED VARS (FOR THRESHOLD)
warn="90"
crit="95"

# logic
get_stats=$(docker stats --no-stream > output.containers)

for container in $(cat output.containers | awk '{print $1}' | grep -v "CONTAINER" ); do

container_name=$(docker ps | grep $container | rev |awk  '{print $1}' | rev)

# Graph
graph_cpu=$(cat output.containers | grep $container | awk '{print $2}' | awk -F \. '{print $1}')
graph_cpu=$(cat output.containers | grep $container | awk '{print $2}' | awk -F \. '{print $1}')

# CPU Monitor
    if [[ $(cat output.containers | grep $container | awk '{print $2}' | awk -F \. '{print $1}') -lt $warn ]]; then
            echo "0 $container_name-CPU count=$graph_cpu;$warn;$crit; Container With Low CPU Usage, $(cat output.containers | grep $container | awk '{print $2}'| tr '.' ',')"

    elif [[ $(cat output.containers | grep $container | awk '{print $2}' | awk -F \. '{print $1}') -ge $warn ]]; then
            echo "1 $container_name-CPU count=$graph_cpu;$warn;$crit; Container With Medium CPU Usage, $(cat output.containers | grep $container | awk '{print $2}'| tr '.' ',')"

    elif [[ $(cat output.containers | grep $container | awk '{print $2}' | awk -F \. '{print $1}') -ge $crit ]]; then
            echo "2 $container_name-CPU count=$graph_cpu;$warn;$crit; Container With High CPU Usage, $(cat output.containers | grep $container | awk '{print $2}' | tr '.' ',')"

    else
            echo "3 $container_name-Memory count=$graph_cpu;$warn;$crit; Problems With Plugin "
    fi

# Memory Monitor
graph_mem=$(cat output.containers | grep $container | awk '{print $6}' | grep -v / | awk -F \. '{print $1}')

    if [[ $(cat output.containers | grep $container | awk '{print $6}' | grep -v / | awk -F \. '{print $1}') -lt $warn ]]; then
            echo "0 $container_name-Memory count=$graph_mem;$warn;$crit; Container With Low Memory Usage, $(cat output.containers | grep $container | awk '{print $6}' | grep -v / | tr '.' ',')"

    elif [[ $(cat output.containers | grep $container | awk '{print $6}' | grep -v / | awk -F \. '{print $1}') -lt $crit ]]; then
            echo "1 $container_name-Memory count=$graph_mem;$warn;$crit; Container With Medium Memory Usage, $(cat output.containers | grep $container | awk '{print $6}' | grep -v / | tr '.' ',')"

    elif [[ $(cat output.containers | grep $container | awk '{print $6}' | grep -v / | awk -F \. '{print $1}') -ge $crit ]]; then
            echo "2 $container_name-Memory count=$graph_mem;$warn;$crit; Container With High Memory Usage, $(cat output.containers | grep $container | awk '{print $6}' | grep -v / | tr '.' ',')"

    else
            echo "3 $container_name-Memory count=$graph_mem;$warn;$crit; Problems With Plugin "
    fi


done



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


