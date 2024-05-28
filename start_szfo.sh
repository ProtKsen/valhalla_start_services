#!/bin/bash

sudo mkdir -p scripts_szfo
sudo mkdir -p data_szfo
sudo cp build_tiles_szfo.sh scripts_szfo/build_tiles_szfo.sh
sudo rm -rf data_szfo/valhalla_tiles
sudo rm data_szfo/valhalla_tiles.tar
sudo cp valhalla_settings_szfo.json ./data_szfo/valhalla.json
