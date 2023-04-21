#/bin/bash

#apt install -y transmission-cli

echo "--- Download OSM planet"
transmission-cli https://planet.openstreetmap.org/pbf/planet-latest.osm.pbf.torrent -w .
mkdir -p extracts

echo "--- Extract country boundaries"
osmium tags-filter --remove-tags --overwrite --output="temp/country-borders-raw.osm.pbf" planet-*.osm.pbf "wr/admin_level=2"
osmium export --overwrite --output-format=geojsonseq --output="temp/country-borders-raw.geo.jsonseq" "temp/country-borders-raw.osm.pbf"
ll -h temp/country-borders-raw.geo.jsonseq

echo "--- Split data into one boundary per country"
papermill extracts-borders.ipynb extracts/_extracts-borders.ipynb
jupyter nbconvert --to html extracts/_extracts-borders.ipynb
ll -h extracts/*-borders.geojson
wc -l countries.tsv

echo "--- Produce country extracts"
osmium extract --overwrite --strategy=simple --config=extracts-config.json planet-*.osm.pbf
ll -h extracts/*-borders.pbf

echo "--- Convert country extracts to GeoJson"
cat countries.tsv | while read -r CC; do
    echo "$CC"
    osmium export --add-unique-id=type_id --overwrite --config=osmium-config.json --output-format=geojsonseq --output="temp/${CC}.geo.jsonseq" "extracts/${CC}.osm.pbf"
    echo "Rows: `wc -l temp/${COUNTRY}.geo.jsonseq`"
done

#pbzip2 extracts/*jsonseq

echo "------------- FINISHED ---------------"