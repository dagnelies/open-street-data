#/bin/bash -ex

while read line; do
  continent=`cut -f1 line`
  country=`cut -f2 line`
  echo $continent $country
  curl -o temp/$country.osm.pbf https://download.geofabrik.de/$continent/$country-latest.osm.pbf
  osmium-tool export --add-unique-id=type_id --output="temp/$country.geojsonseq" "temp/$country.osm.pbf"
  gzip -9 temp/$country.geojsonseq
  ls -lh temp
done < countries.tsv
