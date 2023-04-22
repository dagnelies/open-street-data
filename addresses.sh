#/bin/bash

echo "Filter..."
grep '"boundary":'         temp/${CC}.geo.jsonseq | grep '"type":"MultiPolygon"' > temp/${CC}-areas.geo.jsonseq
grep '"highway":'          temp/${CC}.geo.jsonseq | grep '"name":'               > temp/${CC}-streets.geo.jsonseq
grep '"addr:housenumber":' temp/${CC}.geo.jsonseq                                > temp/${CC}-housenums.geo.jsonseq

echo "Extract addresses..."
papermill addresses.ipynb addresses/${CC}-run.ipynb
jupyter nbconvert --to html addresses/${CC}-run.ipynb

