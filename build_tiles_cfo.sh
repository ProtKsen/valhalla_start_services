#!/bin/bash

mkdir /data_cfo/valhalla_tiles

if ! test -f "/data_cfo/valhalla.json"; then
    echo "Valhalla JSON not found. Creating config."
    valhalla_build_config --mjolnir-tile-dir /data_cfo/valhalla_tiles --mjolnir-tile-extract /data_cfo/valhalla_tiles.tar --mjolnir-timezone /data_cfo/valhalla_tiles/timezones.sqlite --mjolnir-admin /data_cfo/valhalla_tiles/admins.sqlite > /data_cfo/valhalla.json
fi

if ! test -f "/data_cfo/valhalla_tiles/timezones.sqlite"; then
    echo "Valhalla tiles not found. Building now."
    valhalla_build_timezones > /data_cfo/valhalla_tiles/timezones.sq-lite
    valhalla_build_tiles -c /data_cfo/valhalla.json /osm_data/cfo.osm.pbf
fi

if ! test -f "/data_cfo/valhalla_tiles.tar"; then
    echo "Tile extract not found. Extracting now."
    valhalla_build_extract -c /data_cfo/valhalla.json -v
fi

echo "Starting valhalla server."
valhalla_service /data_cfo/valhalla.json 1
