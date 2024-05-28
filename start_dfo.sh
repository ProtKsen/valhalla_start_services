#!/bin/bash

sudo mkdir -p scripts_dfo
sudo mkdir -p data_dfo
sudo cp build_tiles_dfo.sh scripts_dfo/build_tiles_dfo.sh
sudo rm -rf data_dfo/valhalla_tiles
sudo rm data_dfo/valhalla_tiles.tar
sudo cp valhalla_settings_dfo.json ./data_dfo/valhalla.json
