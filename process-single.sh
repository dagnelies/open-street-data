#/bin/bash

set -e

CONTINENT=$1
CODE=$2
COUNTRY=$3

echo "---- ${CONTINENT} ${CODE} ${COUNTRY} ----"
#curl -o temp/$counCOUNTRYtry.osm.pbf https://download.geofabrik.de/${CONTINENT}/${COUNTRY}-latest.osm.pbf

echo "Converting PBF to GeoJson"
# https://docs.osmcode.org/osmium/latest/osmium-export.html
osmium export --add-unique-id=type_id --overwrite --config=osmium-config.json --output="temp/${COUNTRY}.geo.jsonseq" "temp/${COUNTRY}.osm.pbf"
#osmium export --add-unique-id=type_id --overwrite --output="temp/${COUNTRY}.geo.jsonseq" "temp/${COUNTRY}.osm.pbf"
echo "Rows: `wc -l temp/${COUNTRY}.geo.jsonseq`"

#echo 'Dropping "MultiPolygon" highways and "LineString" buildings'
#grep -v -e '"type":"MultiPolygon".*"highway":' temp/${COUNTRY}.geo.jsonseq > temp/${COUNTRY}.geo.jsonseq.filt
#grep -v -e '"type":"LineString".*"building":' temp/${COUNTRY}.geo.jsonseq.filt > temp/${COUNTRY}.geo.jsonseq
#rm temp/${COUNTRY}.geo.jsonseq.filt
#echo "Rows: `wc -l temp/${COUNTRY}.geo.jsonseq`"

echo "Compressing..."
#time gzip --force -9 -k temp/${COUNTRY}.geo.jsonseq
time zstd --force -15 temp/${COUNTRY}.geo.jsonseq
ls -lh temp/${COUNTRY}.*