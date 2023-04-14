#/bin/bash

echo "Fetching PBF source..."
curl -o temp/${COUNTRY}.osm.pbf https://download.geofabrik.de/${CONTINENT}/${COUNTRY}-latest.osm.pbf

echo "Converting PBF to GeoJson"
# https://docs.osmcode.org/osmium/latest/osmium-export.html
osmium export --add-unique-id=type_id --overwrite --config=osmium-config.json --output-format=geojsonseq --output="temp/${COUNTRY}.geo.jsonseq" "temp/${COUNTRY}.osm.pbf"
echo "Rows: `wc -l temp/${COUNTRY}.geo.jsonseq`"
