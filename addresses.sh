#/bin/bash


mkdir -p addresses

CC=$1
export CC

echo "Converting PBF to GeoJson"
# https://docs.osmcode.org/osmium/latest/osmium-export.html
osmium export --add-unique-id=type_id --overwrite --config=osmium-config.json --output-format=geojsonseq --output="temp/${CC}.geo.jsonseq" "extracts/${CC}.osm.pbf"
echo "Rows: `wc -l temp/${CC}.geo.jsonseq`"

echo "Filtering..."
grep '"boundary":'         temp/${CC}.geo.jsonseq | grep '"type":"MultiPolygon"' > temp/${CC}-areas.geo.jsonseq
grep '"highway":'          temp/${CC}.geo.jsonseq | grep '"type":"LineString"' | grep '"name":' > temp/${CC}-streets.geo.jsonseq
grep '"addr:housenumber":' temp/${CC}.geo.jsonseq                                > temp/${CC}-housenums.geo.jsonseq
grep '"building":'         temp/${CC}.geo.jsonseq | wc -l > temp/${CC}-building-count.txt

echo "Extract addresses..."
papermill addresses.ipynb addresses/${CC}-run.ipynb
jupyter nbconvert --to html addresses/${CC}-run.ipynb


pbzip2 -f "temp/${CC}.geo.jsonseq"
mv "temp/${CC}.geo.jsonseq.bz2" extracts