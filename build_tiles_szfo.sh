#!/bin/bash

mkdir /data_szfo/valhalla_tiles

if ! test -f "/data_szfo/valhalla.json"; then
    echo "Valhalla JSON not found. Creating config."
    valhalla_build_config --mjolnir-tile-dir /data_szfo/valhalla_tiles --mjolnir-tile-extract /data_szfo/valhalla_tiles.tar --mjolnir-timezone /data_szfo/valhalla_tiles/timezones.sqlite --mjolnir-admin /data_szfo/valhalla_tiles/admins.sqlite > /data_szfo/valhalla.json
fi

if ! test -f "/data_szfo/valhalla_tiles/timezones.sqlite"; then
    echo "Valhalla tiles not found. Building now."
    valhalla_build_timezones > /data_szfo/valhalla_tiles/timezones.sq-lite
    valhalla_build_tiles -c /data_szfo/valhalla.json /osm_data/szfo.osm.pbf
fi

if ! test -f "/data_szfo/valhalla_tiles.tar"; then
    echo "Tile extract not found. Extracting now."
    valhalla_build_extract -c /data_szfo/valhalla.json -v
fi

echo "Starting valhalla server."
valhalla_service /data_szfo/valhalla.json 1
