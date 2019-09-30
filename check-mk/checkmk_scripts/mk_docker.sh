#!/bin/bash
# /usr/lib/check_mk_agent/local/mk_docker_node.sh
# Ths script monitor docker instances on this host, number of containers.
# Save container's stats command to output.containers
#
# Denis Rodrigues Ferreira
# 11/09/2019



cont_total=$(docker stats --no-stream | grep -v CONTAINER | wc -l)
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
            echo "0 $container_name-CPU - Container With Low CPU Usage, $(cat output.containers | grep $container | awk '{print $2}'| tr '.' ',')"

    elif [[ $(cat output.containers | grep $container | awk '{print $2}' | awk -F \. '{print $1}') -ge $warn ]]; then
            echo "1 $container_name-CPU - Container With Medium CPU Usage, $(cat output.containers | grep $container | awk '{print $2}'| tr '.' ',')"

    elif [[ $(cat output.containers | grep $container | awk '{print $2}' | awk -F \. '{print $1}') -ge $crit ]]; then
            echo "2 $container_name-CPU - Container With High CPU Usage, $(cat output.containers | grep $container | awk '{print $2}' | tr '.' ',')"

    else
            echo "3 $container_name-Memory - count=$graph_cpu;$warn;$crit; Problems With Plugin "
    fi

# Memory Monitor
graph_mem=$(cat output.containers | grep $container | awk '{print $6}' | grep -v / | awk -F \. '{print $1}')

    if [[ $(cat output.containers | grep $container | awk '{print $6}' | grep -v / | awk -F \. '{print $1}') -lt $warn ]]; then
            echo "0 $container_name-Memory - Container With Low Memory Usage, $(cat output.containers | grep $container | awk '{print $6}' | grep -v / | tr '.' ',')"

    elif [[ $(cat output.containers | grep $container | awk '{print $6}' | grep -v / | awk -F \. '{print $1}') -lt $crit ]]; then
            echo "1 $container_name-Memory - Container With Medium Memory Usage, $(cat output.containers | grep $container | awk '{print $6}' | grep -v / | tr '.' ',')"

    elif [[ $(cat output.containers | grep $container | awk '{print $6}' | grep -v / | awk -F \. '{print $1}') -ge $crit ]]; then
            echo "2 $container_name-Memory - Container With High Memory Usage, $(cat output.containers | grep $container | awk '{print $6}' | grep -v / | tr '.' ',')"

    else
            echo "3 $container_name-Memory - Problems With Plugin "
    fi

done

