#/bin/bash
echo "Compress extract..."
time pbzip2 -f temp/${COUNTRY}.geo.jsonseq

echo "Upload extract..."
rclone --config="rclone.conf" copy temp/${COUNTRY}.geo.jsonseq.bz2 r2:${CONTINENT}/

echo "Upload addresses..."
rclone --config="rclone.conf" copy addresses/${COUNTRY}-streets.tsv.gz      r2:addresses/
rclone --config="rclone.conf" copy addresses/${COUNTRY}-houses.tsv.gz       r2:addresses/
