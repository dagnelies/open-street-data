#/bin/bash

set -e
#set -x

mkdir -p temp
mkdir -p addresses
mkdir -p www/addresses
mkdir -p poi

echo "---- Countries ----"
cat countries.tsv

cat countries.tsv | while read -r CONTINENT CODE COUNTRY; do
  echo "---- ${CONTINENT} ${CODE} ${COUNTRY} ----"
  if [ -f temp/${COUNTRY}.done ]; then
          echo "Already done"
          continue
  fi

  export CONTINENT
  export CODE
  export COUNTRY

  bash convert.sh
  bash extract.sh
  bash publish.sh
  bash website.sh

  touch temp/${COUNTRY}.done
done

echo "---- Finished ----"