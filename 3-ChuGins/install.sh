#! /usr/bin/env bash

set -e

echo ""
echo "** ChuGins **"

source ../set_envars.sh

./default-chugins.sh
./faust-chugin.sh

if [[ "$LOW_CAPACITY_SYSTEM" == "0" ]]
then
  ./fluidsynth-chugin.sh

fi

echo "** Finished ChuGins **" | tee --append $LOGFILE
echo ""
