# Raspberry Pi Zero 2 W Setup

## Introduction

The Raspberry Pi Zero 2 W was the initial target configuration for
ChucK-in-the-Box. When compared with other small boards for
embedded audio - for example, the Electro-Smith Daisy or a Teensy
4.1 - the Pi Zero 2 W has a lot going for it:

- $15US purchase price,
- Four 1 GHz 64-bit Arm cores,
- 512 MiB of RAM,
- Full 32-bit or 64-bit Linux OS: ALSA, JACK, PulseAudio, PipeWire, and
- It will run ChucK!

The only major downsides are that it uses more electrical power
than a Daisy or Teensy, and 512 MB isn't enough RAM to support
multi-job GCC compiles or a graphical desktop.

Because of the RAM limitation, ChucK-in-the-Box on the Raspberry
Pi Zero 2 W differs from the Raspberry Pi 4 and 5 versions:

- The Zero 2 W is based on the PiOS Lite version - there is
no desktop,
- miniAudicle, FluidSynth, the FluidSynth ChuGin and other SoundFont
tools are only supported on the larger Pis.

## Flashing the microSD card

You will need at least a 32 GB microSD card and a card writer
on a Windows, MacOS or Linux computer. Use the
[Raspberry Pi Imager](https://www.raspberrypi.com/software/).

On the first page, select the Raspberry Pi OS Lite (64-bit)
operating system . ***Make sure you are flashing the most
recent version, based on Debian `trixie`. Older versions
contain an obsolete version of ChucK!*** Select the microSD
card and press the `Next` button.

Now press the `Edit Settings` button to enter your login and
WiFi credentials. On the "General" tab, you will need to set

1. the hostname,
2. the username and password,
3. the wireless LAN SSID, password and wireless LAN country, and
4. the time zone and keyboard layout.

On the "Services" tab, make sure the "Use password authentication"
radio button is selected. Then press the "Save" button and
continue with the flashing.

Once the flashing is complete, remove the card from the writer, insert
it into the Raspberry Pi and boot the system up. Then use Secure Shell
(`ssh`) to log in and verify that the system is accessible.

## Installing

Raspberry Pi OS (PiOS) Lite does not have `git` installed. So to
install ChucK-in-the-Box, log in with `ssh` and type:

```
sudo apt update
sudo apt full-upgrade -y
sudo apt install -y git
```

Next, clone the ChucK-in-the-Box repository:

```
mkdir Projects
cd Projects
git clone https://github.com/AlgoCompSynth/ChucK-in-the-Box.git
```

Finally, run the install scripts:

```
cd ChucK-in-the-Box
./1-pios-setup.sh
```
