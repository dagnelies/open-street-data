#/bin/bash

#echo "Fetching PBF source..."
#curl -o temp/${COUNTRY}.osm.pbf https://download.geofabrik.de/${CONTINENT}/${COUNTRY}-latest.osm.pbf

echo "Extract PBF from planet"
osmium extract --overwrite --strategy=simple --polygon=extracts/${COUNTRY}-borders.geojson --output=extracts/${COUNTRY}.osm.pbf planet-*.osm.pbf

echo "Converting PBF to GeoJson"
# https://docs.osmcode.org/osmium/latest/osmium-export.html
osmium export --add-unique-id=type_id --overwrite --config=osmium-config.json --output-format=geojsonseq --output="temp/${COUNTRY}.geo.jsonseq" "extracts/${COUNTRY}.osm.pbf"
echo "Rows: `wc -l temp/${COUNTRY}.geo.jsonseq`"
