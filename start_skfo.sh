#!/bin/bash

sudo mkdir -p scripts_skfo
sudo mkdir -p data_skfo
sudo cp build_tiles_skfo.sh scripts_skfo/build_tiles_skfo.sh
sudo rm -rf data_skfo/valhalla_tiles
sudo rm data_skfo/valhalla_tiles.tar
sudo cp valhalla_settings_skfo.json ./data_skfo/valhalla.json
