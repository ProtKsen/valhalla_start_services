#!/bin/bash

mkdir /data_sfo/valhalla_tiles

if ! test -f "/data_sfo/valhalla.json"; then
    echo "Valhalla JSON not found. Creating config."
    valhalla_build_config --mjolnir-tile-dir /data_sfo/valhalla_tiles --mjolnir-tile-extract /data_sfo/valhalla_tiles.tar --mjolnir-timezone /data_sfo/valhalla_tiles/timezones.sqlite --mjolnir-admin /data_sfo/valhalla_tiles/admins.sqlite > /data_sfo/valhalla.json
fi

if ! test -f "/data_sfo/valhalla_tiles/timezones.sqlite"; then
    echo "Valhalla tiles not found. Building now."
    valhalla_build_timezones > /data_sfo/valhalla_tiles/timezones.sq-lite
    valhalla_build_tiles -c /data_sfo/valhalla.json /osm_data/sfo.osm.pbf
fi

if ! test -f "/data_sfo/valhalla_tiles.tar"; then
    echo "Tile extract not found. Extracting now."
    valhalla_build_extract -c /data_sfo/valhalla.json -v
fi

echo "Starting valhalla server."
valhalla_service /data_sfo/valhalla.json 1
