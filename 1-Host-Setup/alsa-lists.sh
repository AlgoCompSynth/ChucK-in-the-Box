#! /usr/bin/env bash


echo ""
echo "aplay --list-devices"
aplay --list-devices

echo ""
echo "aplay --list-pcms"
aplay --list-pcms

echo ""
echo "arecord --list-devices"
arecord --list-devices

echo ""
echo "arecord --list-pcms"
arecord --list-pcms

echo ""
echo "aplaymidi --list"
aplaymidi --list

echo ""
echo "arecordmidi --list"
arecordmidi --list
