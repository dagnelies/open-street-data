#/bin/bash

set -e
#set -x

mkdir -p temp

echo "---- Countries ----"
cat countries.tsv

cat countries.tsv | while read -r continent code country; do
  echo "---- $continent $code $country ----"
  #curl -o temp/$country.osm.pbf https://download.geofabrik.de/$continent/$country-latest.osm.pbf

  echo "Converting PBF to GeoJson"
  osmium export --add-unique-id=type_id --overwrite --output="temp/$country.geojsonseq" "temp/$country.osm.pbf"
  echo "Rows: `wc -l temp/$country.geojsonseq`"
  
  echo 'Dropping "MultiPolygon" highways and "LineString" buildings'
  grep -v -e '"type":"MultiPolygon".*"highway":' temp/$country.geojsonseq > temp/$country.geojsonseq.filt
  grep -v -e '"type":"LineString".*"building":' temp/$country.geojsonseq.filt > temp/$country.geojsonseq
  rm temp/$country.geojsonseq.filt
  echo "Rows: `wc -l temp/$country.geojsonseq`"
  
  echo "Compressing..."
  time gzip -9 -k temp/$country.geojsonseq
  #time zstd -12 temp/$country.geojsonseq
  ls -lh temp/$country.*
done



echo "---- Finished ----"