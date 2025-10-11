# Raspberry Pi Zero 2 W Setup

## Introduction

The Raspberry Pi Zero 2 W was the initial target configuration for
ChucK-in-the-Box. When compared with other small devices for
embedded audio - for example, the Electro-Smith Daisy or a Teensy
4.1 - the Pi Zero 2 W has a lot going for it:

- $15US purchase price,
- Four 1 GHz 64-bit Arm cores,
- 512 MiB of RAM,
- Full 32-bit or 64-bit Linux OS: ALSA, JACK, PulseAudio, PipeWire, and
- It will run ChucK!

The only major downsides are that it uses more electrical power
than a Daisy or Teensy, and 512 MB isn't enough RAM to support
multi-job GCC compiles, container hosting or a graphical desktop.

Because of the RAM limitation, ChucK-in-the-Box on the Raspberry
Pi Zero 2 W differs from the Raspberry Pi 4 and 5 versions:

- The Zero 2 W is based on the 32-bit PiOS Lite version - there is
no desktop,
- ChucK only supports the ALSA driver; on the larger Pis, both ALSA
and PulseAudio are supported,
- miniAudicle, the FluidSynth ChuGin and container hosting are only
supported on the larger Pis.

## Flashing

## Installing

Raspberry Pi OS (PiOS) Lite does not have `git` installed. So to
install ChucK-in-the-Box:

```
sudo apt update -qq && sudo apt full-upgrade -qqy && sudo apt install -qqy git
mkdir Projects
cd Projects/
git clone https://github.com/AlgoCompSynth/ChucK-in-the-Box.git
cd ChucK-in-the-Box/
1-pios-setup.sh
```
