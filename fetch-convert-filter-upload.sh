#/bin/bash

set -e
#set -x

mkdir -p temp

echo "---- Countries ----"
cat countries.tsv

cat countries.tsv | while read -r continent code country; do
  echo "---- $continent $code $country ----"
  curl -o temp/$country.osm.pbf https://download.geofabrik.de/$continent/$country-latest.osm.pbf
  osmium-tool export --add-unique-id=type_id --output="temp/$country.geojsonseq" "temp/$country.osm.pbf"
  gzip -9 temp/$country.geojsonseq
  ls -lh temp
done



echo "---- Finished ----"