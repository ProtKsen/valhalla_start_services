#!/bin/bash

mkdir /data_ufo/valhalla_tiles

if ! test -f "/data_ufo/valhalla.json"; then
    echo "Valhalla JSON not found. Creating config."
    valhalla_build_config --mjolnir-tile-dir /data_ufo/valhalla_tiles --mjolnir-tile-extract /data_ufo/valhalla_tiles.tar --mjolnir-timezone /data_ufo/valhalla_tiles/timezones.sqlite --mjolnir-admin /data_ufo/valhalla_tiles/admins.sqlite > /data_ufo/valhalla.json
fi

if ! test -f "/data_ufo/valhalla_tiles/timezones.sqlite"; then
    echo "Valhalla tiles not found. Building now."
    valhalla_build_timezones > /data_ufo/valhalla_tiles/timezones.sq-lite
    valhalla_build_tiles -c /data_ufo/valhalla.json /osm_data/ufo.osm.pbf
fi

if ! test -f "/data_ufo/valhalla_tiles.tar"; then
    echo "Tile extract not found. Extracting now."
    valhalla_build_extract -c /data_ufo/valhalla.json -v
fi

echo "Starting valhalla server."
valhalla_service /data_ufo/valhalla.json 1
