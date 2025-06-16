#! /usr/bin/env bash

set -e

./linux_dependencies.sh
./install_faust.sh
./install_faustide.sh
./install_miniaudicle.sh
