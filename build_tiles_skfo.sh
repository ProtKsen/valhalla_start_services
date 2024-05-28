#!/bin/bash

mkdir /data_skfo/valhalla_tiles

if ! test -f "/data_skfo/valhalla.json"; then
    echo "Valhalla JSON not found. Creating config."
    valhalla_build_config --mjolnir-tile-dir /data_skfo/valhalla_tiles --mjolnir-tile-extract /data_skfo/valhalla_tiles.tar --mjolnir-timezone /data_skfo/valhalla_tiles/timezones.sqlite --mjolnir-admin /data_skfo/valhalla_tiles/admins.sqlite > /data_skfo/valhalla.json
fi

if ! test -f "/data_skfo/valhalla_tiles/timezones.sqlite"; then
    echo "Valhalla tiles not found. Building now."
    valhalla_build_timezones > /data_skfo/valhalla_tiles/timezones.sq-lite
    valhalla_build_tiles -c /data_skfo/valhalla.json /osm_data/skfo.osm.pbf
fi

if ! test -f "/data_skfo/valhalla_tiles.tar"; then
    echo "Tile extract not found. Extracting now."
    valhalla_build_extract -c /data_skfo/valhalla.json -v
fi

echo "Starting valhalla server."
valhalla_service /data_skfo/valhalla.json 1
