#/bin/bash

#apt install -y transmission-cli
#transmission-cli https://planet.openstreetmap.org/pbf/planet-latest.osm.pbf.torrent -w .
mkdir -p borders

osmium tags-filter -overwrite --output="temp/country-borders-raw.osm.pbf" planet-*.osm.pbf "a/admin_level=2"
osmium export --overwrite --output-format=geojsonseq --output="temp/country-borders-raw.geo.jsonseq" "temp/country-borders-raw.osm.pbf"
wc -l temp/country-borders-raw.geo.jsonseq

papermill simplify-country-borders.ipynb simplify-country-borders-run.ipynb
jupyter nbconvert --to html simplify-country-borders-run.ipynb