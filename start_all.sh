#!/bin/bash


declare -a okrugs=('skfo' 'sfo' 'ufo' 'dfo' 'pfo' 'yufo' 'crim' 'szfo')

for fo in "${okrugs[@]}"
do
  echo "$fo"
  sudo bash start_$fo.sh
  docker compose up -d valhalla_$fo
done

for fo in "${okrugs[@]}"
do 
    until docker logs valhalla_service-valhalla_$fo-1 2>&1| grep -q "Starting valhalla server";
    do 
        sleep 3
        echo "$fo starting..."
    done
    echo "$fo ready!"
done

sudo bash start_cfo.sh
docker compose up -d valhalla_cfo

until docker logs valhalla_service-valhalla_cfo-1 2>&1| grep -q "Starting valhalla server";
do 
  sleep 3
  echo "cfo starting..."
done
echo "cfo ready!"
