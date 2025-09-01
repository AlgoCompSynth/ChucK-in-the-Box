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

chuck --chugin-probe 2>&1 | tee --append $LOGFILE

echo "** Finished ChuGins **" | tee --append $LOGFILE
echo ""
