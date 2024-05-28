#!/bin/bash

sudo mkdir -p scripts_pfo
sudo mkdir -p data_pfo
sudo cp build_tiles_pfo.sh scripts_pfo/build_tiles_pfo.sh
sudo rm -rf data_pfo/valhalla_tiles
sudo rm data_pfo/valhalla_tiles.tar
sudo cp valhalla_settings_pfo.json ./data_pfo/valhalla.json
