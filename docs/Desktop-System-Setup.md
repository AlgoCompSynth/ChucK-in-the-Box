# Desktop System Setup

## Introduction

For graphical / desktop applications, ChucK-in-the-Box requires
a full-sized system - a 64-bit Raspberry Pi with at least one
GiB of RAM and four cores. For smaller quad-core 64-bit models,
use the
[Raspberry Pi Zero 2 W Setup](Raspberry-Pi-Zero-2-W-Setup.md)
instructions.

## Flashing the microSD card

You will need at least a 64 GB microSD card and a card writer
on a Windows, MacOS or Linux computer. Use the
[Raspberry Pi Imager](https://www.raspberrypi.com/software/).

On the first page, press the `Operating System` button and
select the Raspberry Pi OS (64-bit) operating system. This
is currently the first and recommended option for those
systems.  ***Make sure you are flashing the most recent
version, based on Debian `trixie`.***

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

## Installing

You can do the installation either

- via an `ssh` command-line connection,
- in a terminal window on a keyboard / monitor / mouse system, or
- in a terminal window in a remote access session.

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

This takes about 20 minutes on a Raspberry Pi 4 and about 9 on a
Raspberry Pi 5. When it is done you will see

```

Install finished! Do

    sudo raspi-config

and set your locale in the 'Localisation Options' menu.
Then 'Finish' and reboot to start the audio daemons.

* Finished PiOS Host Setup *
```

If you don't see that, an error has occurred. You can open an issue by
typing

```
./scripts/open-issue.sh
```

and filling out the form at
<https://github.com/AlgoCompSynth/ChucK-in-the-Box/issues/new>.

Raspberry Pi OS ships with the locale set to English Great Britain (en_GB).
If that's where you are, you don't need to change it. But if you're anywhere
else, follow the instructions the script displays.

## Next steps

The system should be ready to use after a reboot. If you're new to ChucK,
the book
[Programming for Musicians and Digital Artists: Creating music with ChucK](https://www.manning.com/books/programming-for-musicians-and-digital-artists)
and the YouTube playlist
[Creating Electronic Music with ChucK](https://youtube.com/playlist?list=PL-9SSIBe1phI_r3JsylOZXZyAXuEKRJOS&si=48f53yc_keycYWE0)
will get you going. USB audio devices and HDMI audio devices should just
just work in either ALSA (`chuck --driver:alsa`, which is the default) or
PulseAudio (`chuck --driver:pulse`) mode. Although the JACK driver
(`chuck --driver:jack`) is present in the version of ChucK installed,
the supporting software is not installed. You will need to use either
ALSA or PulseAudio.

## Testing miniAudicle

### Running miniAudicle

The install process adds miniAudicle to the menu under the "Sound &
Video" category. So you can start miniAudicle from the menu. You can
also right-click on the menu entry and add the miniAudicle to your
desktop or as a launcher on the taskbar.

1. Start miniAudicle. You will get three windows: a virtual machine
control window, a console log window, and a ChucK code editor window;
the editor window is the main one. 

    In the main "miniAudicle" window, go to "Edit -> Preferences".
    On the "Audio" tab, select the "Pulse" driver and enter your audio
    device settings. On the "ChuGins" tab, press the "+" button and add
    `/usr/local/lib/chuck`. Press the "Probe ChuGins" button and verify
    in the "Console Log" window that the ChuGins are loaded. Then press
    "OK" in the "Preferences" window.

2. Start the virtual machine in the "Virtual Machine" control window,
then move it and the console log window out of the way.

3. In the "File" menu, select "Open". You will be in a file browser.
You should be in your home directory. There will be a file
"WowExample.ck". This is a copy of an example from the book referenced
above. Open the file.

4. Press the "Add Shred" button and the music will start. The first
time you do this, there may be a startup lag.

### Bluetooth device setup

1. Put your Bluetooth device in pairing mode.

2. Click the Bluetooth icon in the upper right corner of the taskbar
and add the device.

3. Right-click the Speaker icon. Make sure your Bluetooth device is
selected and the device profile is set to "High Fidelity Playback".
Then left-click the Speaker icon and set the volume.
