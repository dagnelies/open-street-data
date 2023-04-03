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
  # https://docs.osmcode.org/osmium/latest/osmium-export.html
  osmium export --add-unique-id=type_id --overwrite --config=osmium-config.json --output="temp/$country.geo.jsonseq" "temp/$country.osm.pbf"
  echo "Rows: `wc -l temp/$country.geojsonseq`"
  
  echo 'Dropping "MultiPolygon" highways and "LineString" buildings'
  grep -v -e '"type":"MultiPolygon".*"highway":' temp/$country.geo.jsonseq > temp/$country.geo.jsonseq.filt
  grep -v -e '"type":"LineString".*"building":' temp/$country.geo.jsonseq.filt > temp/$country.geo.jsonseq
  rm temp/$country.geo.jsonseq.filt
  echo "Rows: `wc -l temp/$country.geo.jsonseq`"
  
  echo "Compressing..."
  #time gzip -9 -k temp/$country.geojsonseq
  #time zstd -12 temp/$country.geojsonseq
  ls -lh temp/$country.*
done



echo "---- Finished ----"