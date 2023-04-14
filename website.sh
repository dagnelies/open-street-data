#/bin/bash

echo "Website samples..."
zcat addresses/${COUNTRY}-streets.tsv.gz | head -1000 > www/addresses/${COUNTRY}-streets-sample.tsv
zcat addresses/${COUNTRY}-houses.tsv.gz  | head -1000 > www/addresses/${COUNTRY}-houses-sample.tsv


