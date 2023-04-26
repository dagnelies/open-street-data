#/bin/bash

set -e

mkdir -p addresses

CC=$1

export CC

#bash convert.sh
bash addresses.sh $1
#bash publish.sh
#bash website.sh
