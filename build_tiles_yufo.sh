#!/bin/bash

mkdir /data_yufo/valhalla_tiles

if ! test -f "/data_yufo/valhalla.json"; then
    echo "Valhalla JSON not found. Creating config."
    valhalla_build_config --mjolnir-tile-dir /data_yufo/valhalla_tiles --mjolnir-tile-extract /data_yufo/valhalla_tiles.tar --mjolnir-timezone /data_yufo/valhalla_tiles/timezones.sqlite --mjolnir-admin /data_yufo/valhalla_tiles/admins.sqlite > /data_yufo/valhalla.json
fi

if ! test -f "/data_yufo/valhalla_tiles/timezones.sqlite"; then
    echo "Valhalla tiles not found. Building now."
    valhalla_build_timezones > /data_yufo/valhalla_tiles/timezones.sq-lite
    valhalla_build_tiles -c /data_yufo/valhalla.json /osm_data/yufo.osm.pbf
fi

if ! test -f "/data_yufo/valhalla_tiles.tar"; then
    echo "Tile extract not found. Extracting now."
    valhalla_build_extract -c /data_yufo/valhalla.json -v
fi

echo "Starting valhalla server."
valhalla_service /data_yufo/valhalla.json 1
