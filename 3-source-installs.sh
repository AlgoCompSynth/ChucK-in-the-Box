#! /usr/bin/env bash

set -e

echo ""
echo "* Source Installs *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/3-source-installs.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo ""
echo ""
echo "Installing ChucK and ChuGins in chuck-in-the-box -"
echo "This will take some time."
/usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/install-ChucK-ChuGins.sh

if [[ "$MAKE_PARALLEL_LEVEL" -gt "1" ]]
then
  /usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/install-FluidSynth-ChuGin.sh
  /usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/install-miniAudicle.sh \

fi

echo ""
echo ""
distrobox enter chuck-in-the-box -- ./scripts/probe-ChucK.sh

echo "* Finished Source Installs *" | tee --append $LOGFILE
