#! /usr/bin/env bash

dpkg-query --list \
  | grep "^ii" \
  | sed "s/^ii //" \
  | sed "s/  */ /g" \
  | sort
