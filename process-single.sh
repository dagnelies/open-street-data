#/bin/bash

set -e

CONTINENT=$1
CODE=$2
COUNTRY=$3

echo "---- ${CONTINENT} ${CODE} ${COUNTRY} ----"
if [ -f temp/${COUNTRY}.geo.jsonseq.bz2 ]; then
        echo "Already done"
        exit 0
fi

if [ ! -f  temp/${COUNTRY}.osm.pbf  ]; then
        curl -o temp/${COUNTRY}.osm.pbf https://download.geofabrik.de/${CONTINENT}/${COUNTRY}-latest.osm.pbf
fi

echo "Converting PBF to GeoJson"
# https://docs.osmcode.org/osmium/latest/osmium-export.html
osmium export --add-unique-id=type_id --overwrite --config=osmium-config.json --output-format=geojsonseq --output="temp/${COUNTRY}.geo.jsonseq" "temp/${COUNTRY}.osm.pbf"
echo "Rows: `wc -l temp/${COUNTRY}.geo.jsonseq`"

echo "Compressing..."
time pbzip2 -f -k temp/${COUNTRY}.geo.jsonseq
ls -lh temp/${COUNTRY}.*

echo "Upload..."
rclone --config="rclone.conf" copy temp/${COUNTRY}.geo.jsonseq.bz2 r2:${CONTINENT}/

rm temp/${COUNTRY}.geo.jsonseq.bz2