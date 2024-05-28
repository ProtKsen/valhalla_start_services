#!/bin/bash

sudo mkdir -p scripts_cfo
sudo mkdir -p data_cfo
sudo cp build_tiles_cfo.sh scripts_cfo/build_tiles_cfo.sh
sudo rm -rf data_cfo/valhalla_tiles
sudo rm data_cfo/valhalla_tiles.tar
sudo cp valhalla_settings_cfo.json ./data_cfo/valhalla.json
