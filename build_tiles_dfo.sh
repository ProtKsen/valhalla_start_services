#!/bin/bash

mkdir /data_dfo/valhalla_tiles

if ! test -f "/data_dfo/valhalla.json"; then
    echo "Valhalla JSON not found. Creating config."
    valhalla_build_config --mjolnir-tile-dir /data_dfo/valhalla_tiles --mjolnir-tile-extract /data_dfo/valhalla_tiles.tar --mjolnir-timezone /data_dfo/valhalla_tiles/timezones.sqlite --mjolnir-admin /data_dfo/valhalla_tiles/admins.sqlite > /data_dfo/valhalla.json
fi

if ! test -f "/data_dfo/valhalla_tiles/timezones.sqlite"; then
    echo "Valhalla tiles not found. Building now."
    valhalla_build_timezones > /data_dfo/valhalla_tiles/timezones.sq-lite
    valhalla_build_tiles -c /data_dfo/valhalla.json /osm_data/dfo.osm.pbf
fi

if ! test -f "/data_dfo/valhalla_tiles.tar"; then
    echo "Tile extract not found. Extracting now."
    valhalla_build_extract -c /data_dfo/valhalla.json -v
fi

echo "Starting valhalla server."
valhalla_service /data_dfo/valhalla.json 1
