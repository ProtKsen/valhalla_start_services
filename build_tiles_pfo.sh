#!/bin/bash

mkdir /data_pfo/valhalla_tiles

if ! test -f "/data_pfo/valhalla.json"; then
    echo "Valhalla JSON not found. Creating config."
    valhalla_build_config --mjolnir-tile-dir /data_pfo/valhalla_tiles --mjolnir-tile-extract /data_pfo/valhalla_tiles.tar --mjolnir-timezone /data_pfo/valhalla_tiles/timezones.sqlite --mjolnir-admin /data_pfo/valhalla_tiles/admins.sqlite > /data_pfo/valhalla.json
fi

if ! test -f "/data_pfo/valhalla_tiles/timezones.sqlite"; then
    echo "Valhalla tiles not found. Building now."
    valhalla_build_timezones > /data_pfo/valhalla_tiles/timezones.sq-lite
    valhalla_build_tiles -c /data_pfo/valhalla.json /osm_data/pfo.osm.pbf
fi

if ! test -f "/data_pfo/valhalla_tiles.tar"; then
    echo "Tile extract not found. Extracting now."
    valhalla_build_extract -c /data_pfo/valhalla.json -v
fi

echo "Starting valhalla server."
valhalla_service /data_pfo/valhalla.json 1
