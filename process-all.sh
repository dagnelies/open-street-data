#/bin/bash

set -e
#set -x

mkdir -p temp

echo "---- Countries ----"
cat countries.tsv

cat countries.tsv | while read -r CONTINENT CODE COUNTRY; do
  #bash process-single.sh ${CONTINENT} ${CODE} ${COUNTRY}
  bash filter.sh ${CONTINENT} ${CODE} ${COUNTRY}
done

echo "---- Finished ----"