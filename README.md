# ChucK-in-the-Box - Computer music development tools for Linux

## What is this?

ChucK-in-the-Box is a collection of computer music development tools
for Linux computers. ChucK-in-the-Box contains

1. The [ChucK](https://chuck.stanford.edu/)
ecosystem: ChucK, miniAudicle, ChuGins and
[ChuGL](https://chuck.stanford.edu/chugl/),
2. The [Faust](https://faust.grame.fr/)
audio programming language, and
3. [FluidSynth](https://www.fluidsynth.org/)
SoundFont-based synthesis tools.

The first release is designed for use on
[Raspberry Pi](https://www.raspberrypi.com/) single-board computers.
A command-line version is available for the $15US
[Raspberry Pi Zero 2 W](https://www.raspberrypi.com/products/raspberry-pi-zero-2-w/).
This board was in fact the original inspiration for ChucK-in-the-Box.

The graphical version includes the
[miniAudicle](https://audicle.cs.princeton.edu/mini/) interactive
development environment and will run on any Raspberry Pi 4 or 5
with at least 2 GB of RAM and either the latest PiOS 64-bit desktop
based on Debian `trixie` or the legacy PiOS 64-bit desktop based on
Debian `bookworm`. In addition to the host installation, Raspberry
Pi 4 or 5 users can install 
[boxed-chuck](docs/boxed-chuck.md), a [Distrobox](https://distrobox.it/)
container based on Debian `trixie` with the same software as the
host version.

## Audio Hardware and Configuration Notes
 
All of the Raspberry Pi boards I use - Raspberry Pi Zero 2 W,
Raspberry Pi 4 and Raspberry Pi 5 - have HDMI output. So if you're
hooked up to an HDMI monitor with audio, you don't need to buy
anything for audio output.

If you're running headless, you can use an HDMI audio extractor
or HDMI capture card that has audio outputs. However, I don't
own one, so I can't recommend one. And there's no audio _input_
by default on a Raspberry Pi - if you need audio input, you'll
need additional hardware.

Another option is a USB sound card / dongle. There are expensive ones
and inexpensive ones. Most of the inexpensive ones only do 16 bit /
48 kilohertz audio, so check the specifications carefully. I have
had good results with USB gaming headsets, although you'll have to
use great caution to protect your ears as you would with any headset.

There are a number of audio HATs for the Raspberry Pi boards, and
probably dozens of DIY setups if you want to go that route. I have a
[Blokas Pisound HAT](https://blokas.io/pisound/) on one of my
Raspberry Pi 5s and Chuck-in-the-Box supports it.

Finally, ChucK-in-the-Box supports Bluetooth audio, including
microphones, speakers, headphones and headsets. Pairing and
connection setup is done with the control panel on the Raspberry
Pi 4 and 5 PiOS desktop and from the command line in the Raspberry
Pi Zero 2 W.
 
## [Raspberry Pi Zero 2 W Setup](docs/Raspberry-Pi-Zero-2-W-Setup.md)

## [Blokas Pisound Setup](docs/Blokas-Pisound-Setup.md)

## The [boxed-chuck](docs/boxed-chuck.md) Container
