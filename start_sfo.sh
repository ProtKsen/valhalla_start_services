#!/bin/bash

sudo mkdir -p scripts_sfo
sudo mkdir -p data_sfo
sudo cp build_tiles_sfo.sh scripts_sfo/build_tiles_sfo.sh
sudo rm -rf data_sfo/valhalla_tiles
sudo rm data_sfo/valhalla_tiles.tar
sudo cp valhalla_settings_sfo.json ./data_sfo/valhalla.json
