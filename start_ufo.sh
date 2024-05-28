#!/bin/bash

sudo mkdir -p scripts_ufo
sudo mkdir -p data_ufo
sudo cp build_tiles_ufo.sh scripts_ufo/build_tiles_ufo.sh
sudo rm -rf data_ufo/valhalla_tiles
sudo rm data_ufo/valhalla_tiles.tar
sudo cp valhalla_settings_ufo.json ./data_ufo/valhalla.json
