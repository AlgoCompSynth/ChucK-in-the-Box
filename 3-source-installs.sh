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
echo "Installing ChucK and ChuGins in debian-trixie -"
echo "This will take some time."
/usr/bin/time distrobox enter debian-trixie -- ./scripts/install-ChucK-ChuGins.sh

if [[ "$GRAPHICAL_TARGET" == "1" ]]
then
  /usr/bin/time distrobox enter debian-trixie -- ./scripts/install-FluidSynth-ChuGin.sh

fi

echo ""
echo ""
distrobox enter debian-trixie -- ./scripts/probe-ChucK.sh

if [[ "$GRAPHICAL_TARGET" == "1" ]]
then
  /usr/bin/time distrobox enter debian-trixie -- ./scripts/install-miniAudicle.sh \
    >> $LOGFILE 2>&1

fi

echo "* Finished Source Installs *" | tee --append $LOGFILE
