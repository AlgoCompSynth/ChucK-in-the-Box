# Full-Sized System Setup

## Introduction

For graphical / desktop applications, ChucK-in-the-Box requires
a full-sized system - a 64-bit Raspberry Pi with at least two
GiB of RAM and four cores. This includes some Raspberry 3 and
4 models and all Raspberry Pi 5s. For smaller quad-core 64-bit
models, use the
[Raspberry Pi Zero 2 W Setup](Raspberry-Pi-Zero-2-W-Setup.md)
instructions.

## Flashing the microSD card

You will need at least a 64 GB microSD card and a card writer
on a Windows, MacOS or Linux computer. Use the
[Raspberry Pi Imager](https://www.raspberrypi.com/software/).

On the first page, press the `Operating System` button and
select the Raspberry Pi OS Desktop (64-bit) operating system.
This is currently the first and recommended option for those
systems.  ***Make sure you are flashing the most recent
version, based on Debian `trixie`. Older versions contain
an obsolete version of ChucK!*** 

Next, press the `Storage` button and select the microSD
card. Then press the `Next` button.

Now press the `Edit Settings` button to enter your login and
WiFi credentials. On the `General` tab, you will need to set

1. the hostname,
2. the username and password,
3. the wireless LAN SSID, password and wireless LAN country, and
4. the time zone and keyboard layout.

On the `Services` tab, make sure the `Enable SSH` checkbox and
`Use password authentication` radio button are selected. Then
press the `Save` button and continue with the flashing.

Once the flashing is complete, remove the card from the writer, insert
it into the Raspberry Pi and boot the system up. Then use Secure Shell
(`ssh`) to log in and verify that the system is accessible.

## Setting up remote access

As noted above, you should already have command line remote access
on your local area network (LAN) via `ssh`. But if you
plan to use the ChucK
[miniAudicle](https://github.com/ccrma/miniAudicle/blob/main/README.md)
interactive development environment (IDE) from ChucK-in-the-Box,
or other desktop applications, you will need either a keyboard, HDMI
monitor and mouse or remote desktop access.

The instructions for setting up remote access are here:
<https://www.raspberrypi.com/documentation/computers/remote-access.html>.
In the remainder of this guide, I will only be using command-line access
via `ssh`. You can also do this from the terminal application of
the Raspberry Pi desktop.

## Installing

First, clone the ChucK-in-the-Box repository:

```
mkdir Projects
cd Projects
git clone https://github.com/AlgoCompSynth/ChucK-in-the-Box.git
```

Next, run the install scripts:

```
cd ChucK-in-the-Box
./1-pios-setup.sh
```

This takes about 20 minutes. When it is done you will see

```
Probe results have been saved in /home/znmeb/Logfiles/probe-ChucK.log


** Finished Probe ChucK **

Updating apt-file database
Updating locate database

Reboot to reset audio daemons

* Finished PiOS Host Setup *
```

If you don't see that, an error has occurred. You can open an issue by
typing

```
./scripts/open-issue.sh
```

and filling out the form the script displays after archiving the logfiles
from the install.

## Next steps

The system should be ready to use after a reboot. If you're new to ChucK,
the book
[Programming for Musicians and Digital Artists: Creating music with ChucK](https://www.manning.com/books/programming-for-musicians-and-digital-artists)
and the YouTube playlist
[Creating Electronic Music with ChucK](https://youtube.com/playlist?list=PL-9SSIBe1phI_r3JsylOZXZyAXuEKRJOS&si=48f53yc_keycYWE0)
will get you going. USB audio devices and HDMI audio devices should just
just work in either ALSA (`chuck --driver:alsa`, which is the default) or
PulseAudio (`chuck --driver:pulse`) mode. Although the JACK driver
(`chuck --driver:jack`) is present in the version of ChucK installed from
the system repositories, the supporting software is not installed. You will
need to use either ALSA or PulseAudio.

You can connect Bluetooth audio devices using the Bluetooth and Volume
control tools in the upper right corner of the taskbar. Once connected,
do `chuck --probe --driver:pulse` in a terminal window to find the
device number.
