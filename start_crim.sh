#!/bin/bash

sudo mkdir -p scripts_crim
sudo mkdir -p data_crim
sudo cp build_tiles_crim.sh scripts_crim/build_tiles_crim.sh
sudo rm -rf data_crim/valhalla_tiles
sudo rm data_crim/valhalla_tiles.tar
sudo cp valhalla_settings_crim.json ./data_crim/valhalla.json
