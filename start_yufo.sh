#!/bin/bash

sudo mkdir -p scripts_yufo
sudo mkdir -p data_yufo
sudo cp build_tiles_yufo.sh scripts_yufo/build_tiles_yufo.sh
sudo rm -rf data_yufo/valhalla_tiles
sudo rm data_yufo/valhalla_tiles.tar
sudo cp valhalla_settings_yufo.json ./data_yufo/valhalla.json
