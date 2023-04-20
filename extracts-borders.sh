#/bin/bash

#apt install -y transmission-cli
#transmission-cli https://planet.openstreetmap.org/pbf/planet-latest.osm.pbf.torrent -w .
mkdir -p extracts

#osmium tags-filter --remove-tags --overwrite --output="temp/country-borders-raw.osm.pbf" planet-*.osm.pbf "wr/admin_level=2"
#osmium export --overwrite --output-format=geojsonseq --output="temp/country-borders-raw.geo.jsonseq" "temp/country-borders-raw.osm.pbf"
#wc -l temp/country-borders-raw.geo.jsonseq

papermill extracts-borders.ipynb extracts/_extracts-borders.ipynb
jupyter nbconvert --to html extracts/_extracts-borders.ipynb


osmium extracts --strategy=simple --directory=extracts --config=extracts-config.json planet-*.osm.pbf

#for file in `ls extracts/*.pbf`; do
#    osmium export --add-unique-id=type_id --overwrite --config=osmium-config.json --output-format=geojsonseq --output="temp/${COUNTRY}.geo.jsonseq" "temp/${COUNTRY}.osm.pbf"
#    echo "Rows: `wc -l temp/${COUNTRY}.geo.jsonseq`"
#done

#pbzip2 extracts/*jsonseq

echo "------------- FINISHED ---------------"