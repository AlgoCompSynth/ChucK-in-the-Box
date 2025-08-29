#! /usr/bin/env bash

set -e

echo ""
echo "*** R Setup ***"

source ../../set_envars.sh
export LOGFILE=$LOGFILES/R_setup.log
rm --force $LOGFILE

echo "Enabling CRAN Ubuntu repository"
# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
wget -qO- \
  https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
  | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the repo from CRAN -- lsb_release adjusts to 'noble' or 'jammy' or ... as needed
sudo add-apt-repository --yes \
  "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo apt-get update \
  >> $LOGFILE 2>&1

echo "Installing bibtool, pandoc, r-base-dev and qpdf"
/usr/bin/time sudo apt-get install -qqy \
  bibtool \
  pandoc \
  r-base-dev \
  qpdf \
  >> $LOGFILE 2>&1

echo "Setting R profiles $HOME/.Rprofile and $HOME/.Renviron"
cp Rprofile $HOME/.Rprofile
# https://forum.posit.co/t/timedatectl-had-status-1/72060/5
cp Renviron $HOME/.Renviron

echo "Updating the system library"
sudo Rscript -e 'update.packages(ask=FALSE, repos="https://cran.r-project.org")' \
  >> $LOGFILE 2>&1

echo "*** Finished R Setup ***"
