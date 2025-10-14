# ChucK-in-the-Box - Computer music development tools for Linux

## What is this?

ChucK-in-the-Box is a collection of computer music development tools
for Raspberry Pi computers. Any 64-bit Raspberry Pi (Raspberry Pi 3 or
later and the Raspberry Pi Zero 2 W) can be used.

ChucK-in-the-Box contains

1. the [ChucK](https://chuck.stanford.edu/)
computer music language. The current version is 1.5.5.0 from the Debian
repositories,
2. the [Faust](https://faust.grame.fr/)
audio programming language. The current version is 2.79.3 from the Debian
repositories, and
3. the default [ChuGins](https://github.com/ccrma/chugins)
and the Faust and WarpBuf ChuGins.

This is the minimum version, defined for command line usage on systems
as small as the Raspberry Pi Zero 2 W running Raspberry Pi OS Lite.
On larger systems - at least two GiB of RAM and four cores, running the
Raspberry Pi OS Desktop - ChucK-in-the-Box also contains

1. The [miniAudicle](https://audicle.cs.princeton.edu/mini/)
integrated development environment for ChucK,
2. the [FluidSynth](https://www.fluidsynth.org/) and
[Polyphone](https://www.polyphone.io/en)
[SoundFont](https://en.wikipedia.org/wiki/SoundFont) synthesis tools, and
3. the FluidSynth ChuGin.

## Audio Hardware Notes
 
All of the Raspberry Pi boards I use - Raspberry Pi Zero 2 W,
Raspberry Pi 4 and Raspberry Pi 5 - have HDMI output. So if you're
hooked up to an HDMI monitor with audio, you don't need to buy
anything for audio output.

If you're running headless, you can use an HDMI audio extractor
or HDMI capture card that has audio outputs. However, I don't
own one, so I can't recommend one. And there's no audio _input_
by default on a Raspberry Pi - if you need audio input, you'll
need additional hardware.

Another option is a plug-and-play USB audio device. There are
expensive ones and inexpensive ones. Most of the inexpensive ones
only do 16 bit / 48 kilohertz audio, so check the specifications
carefully. I have had good results with USB gaming headsets,
although you'll have to use great caution to protect your ears
as you would with any headset.

There are a number of audio HATs for the Raspberry Pi boards, and
probably dozens of DIY setups if you want to go that route. I have a
[Blokas Pisound HAT](https://blokas.io/pisound/) on one of my
Raspberry Pi 5s and Chuck-in-the-Box supports it.

Finally, ChucK-in-the-Box supports Bluetooth audio, including
microphones, speakers, headphones and headsets. Pairing and
connection setup is done with the control panel on the Raspberry
Pi 4 and 5 PiOS desktop and from the command line in the Raspberry
Pi Zero 2 W.

## [Full-Size System Setup](docs/Full-Size-System-Setup.md)
 
## [Raspberry Pi Zero 2 W Setup](docs/Raspberry-Pi-Zero-2-W-Setup.md)
