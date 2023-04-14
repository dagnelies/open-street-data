#/bin/bash

set -e

CONTINENT=$1
CODE=$2
COUNTRY=$3

echo "---- ${CONTINENT} ${CODE} ${COUNTRY} ----"
bzgrep '"boundary":' temp/${COUNTRY}.geo.jsonseq.bz2 > temp/${COUNTRY}-areas.geo.jsonseq
bzgrep '"highway":' temp/${COUNTRY}.geo.jsonseq.bz2 | grep '"name":' > temp/${COUNTRY}-streets.geo.jsonseq
bzgrep '"addr:housenumber":' temp/${COUNTRY}.geo.jsonseq.bz2 > temp/${COUNTRY}-housenums.geo.jsonseq

