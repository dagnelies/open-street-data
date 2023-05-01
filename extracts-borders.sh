#/bin/bash

#apt install -y transmission-cli

echo "--- Download OSM planet"
transmission-cli https://planet.openstreetmap.org/pbf/planet-latest.osm.pbf.torrent -w .
mkdir -p extracts

echo "--- Split data into one boundary per country"
papermill extracts-borders.ipynb extracts/_extracts-borders.ipynb
jupyter nbconvert --to html extracts/_extracts-borders.ipynb

echo "------------- FINISHED ---------------"