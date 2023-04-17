#/bin/bash

#apt install -y transmission-cli
#transmission-cli https://planet.openstreetmap.org/pbf/planet-latest.osm.pbf.torrent -w .
mkdir -p borders

osmium tags-filter --overwrite --output="borders/country-borders-raw.osm.pbf" planet-*.osm.pbf "wr/admin_level=2"
osmium export --overwrite --output-format=geojsonseq --output="borders/country-borders-raw.geo.jsonseq" "borders/country-borders-raw.osm.pbf"
wc -l borders/country-borders-raw.geo.jsonseq

papermill simplify-country-borders.ipynb borders/simplify-country-borders-run.ipynb
jupyter nbconvert --to html borders/simplify-country-borders-run.ipynb
