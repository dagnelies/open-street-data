#/bin/bash

set -e
#set -x

mkdir -p extracts
mkdir -p temp
mkdir -p addresses
#mkdir -p www/addresses
mkdir -p poi

echo "---- Countries ----"
cat countries.tsv

cat countries.tsv | while read -r CC CCC NNN COUNTRY; do
  echo "---- ${CC} - ${COUNTRY}----"
  if [ -f temp/${CC}.done ]; then
          echo "Already done"
          continue
  fi

  bash run-single.sh ${CC} ${CC}

  touch temp/${CC}.done
done

echo "---- Finished ----"