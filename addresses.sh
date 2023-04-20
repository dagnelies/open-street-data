#/bin/bash

echo "Filter..."
grep '"boundary":'         temp/${COUNTRY}.geo.jsonseq | grep '"type":"MultiPolygon"' > temp/${COUNTRY}-areas.geo.jsonseq
grep '"highway":'          temp/${COUNTRY}.geo.jsonseq | grep '"name":'               > temp/${COUNTRY}-streets.geo.jsonseq
grep '"addr:housenumber":' temp/${COUNTRY}.geo.jsonseq                                > temp/${COUNTRY}-housenums.geo.jsonseq

echo "Extract addresses..."
papermill addresses.ipynb addresses/${COUNTRY}-run.ipynb
jupyter nbconvert --to html addresses/${COUNTRY}-run.ipynb

