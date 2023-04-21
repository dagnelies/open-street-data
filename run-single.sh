#/bin/bash

set -e

mkdir -p addresses

CODE=$1
COUNTRY=$1

export CODE
export COUNTRY

bash convert.sh
bash addresses.sh
#bash publish.sh
#bash website.sh
