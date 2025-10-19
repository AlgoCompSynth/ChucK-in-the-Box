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

You will need at least a 64 GB microSD card and a card writer
on a Windows, MacOS or Linux computer. Use the
[Raspberry Pi Imager](https://www.raspberrypi.com/software/).

On the first page, press the `Operating System` button and
select the Raspberry Pi OS Lite (64-bit) operating system .
***Make sure you are flashing the most recent version, based
on Debian `trixie`.***

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

This takes about 40 minutes. When it is done you will see

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

## Next steps

The system should be ready to use after a reboot. If you're new to ChucK,
the book
[Programming for Musicians and Digital Artists: Creating music with ChucK](https://www.manning.com/books/programming-for-musicians-and-digital-artists)
and the YouTube playlist
[Creating Electronic Music with ChucK](https://youtube.com/playlist?list=PL-9SSIBe1phI_r3JsylOZXZyAXuEKRJOS&si=48f53yc_keycYWE0)
will get you going. USB audio devices and HDMI audio devices should just
just work in either ALSA (`chuck --driver:alsa`, which is the default) or
PulseAudio (`chuck --driver:pulse`) mode. Although the JACK driver
(`chuck --driver:jack`) is installed, the supporting software is not
installed. You will need to use either ALSA or PulseAudio.

## Bluetooth audio example

### Connecting the device

The following is how I connect my Sony ULT Wear Bluetooth headset. The
steps should be the same for other Bluetooth audio devices, but the MAC
address and name will differ.

1. Make sure the Bluetooth radio is unblocked.

```
❯ rfkill list
0: hci0: Bluetooth
        Soft blocked: yes
        Hard blocked: no
1: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no
```

On my system, the Bluetooth radio is soft blocked. To fix this, do

```
❯ sudo rfkill unblock all
```

2. Pair, connect and trust the device. First, put your device in
pairing mode. On the ULT Wear this is done by holding the 'On' button
until you hear "pairing". Then enter `bluetoothctl` and at the
`[bluetoothctl]> ` prompt enter `scan on`:

```
❯ bluetoothctl
Agent registered
hci0 new_settings: powered bondable ssp br/edr le secure-conn 
[CHG] Controller B8:27:EB:12:87:E8 Pairable: yes
[bluetoothctl]> scan on
SetDiscoveryFilter success
Discovery started
[CHG] Controller B8:27:EB:12:87:E8 Discovering: yes

...


[CHG] Device 40:72:18:EF:03:18 RSSI: 0xffffffc9 (-55)
[CHG] Device 40:72:18:EF:03:18 Name: ULT WEAR
[CHG] Device 40:72:18:EF:03:18 Alias: ULT WEAR
[CHG] Device 40:72:18:EF:03:18 Class: 0x00240404 (2360324)
[CHG] Device 40:72:18:EF:03:18 Icon: audio-headset
[CHG] Device 40:72:18:EF:03:18 UUIDs: fa349b5f-8050-0030-0010-00001bbb231d
[CHG] Device 40:72:18:EF:03:18 UUIDs: 00000000-deca-fade-deca-deafdecacaff
```

The string of bytes after the "Device" is the MAC address for my ULT Wear.
You'll see a lot of stuff go by before and after that, but don't worry, 
eventually you'll get another `[bluetoothctl]> ` prompt. At that point, enter
`pair ` followed by the device MAC address. There's tab completion, so you
only need to type the first three characters and `tab` and the rest will be
filled in!

```
[bluetoothctl]> pair 40:72:18:EF:03:18 
Attempting to pair with 40:72:18:EF:03:18
[CHG] Device 40:72:18:EF:03:18 Connected: yes
[CHG] Device 40:72:18:EF:03:18 Bonded: yes
[CHG] Device 40:72:18:EF:03:18 Modalias: usb:v054Cp0F1Ed0207
...

[CHG] Device 40:72:18:EF:03:18 ServicesResolved: yes
[CHG] Device 40:72:18:EF:03:18 Paired: yes
Pairing successful
[CHG] Device 40:72:18:EF:03:18 ServicesResolved: no
[CHG] Device 40:72:18:EF:03:18 Connected: no
```

At the next `[bluetoothctl]> ` prompt enter `connect ` followed by the
MAC address.

```
[bluetoothctl]> connect 40:72:18:EF:03:18 
Attempting to connect to 40:72:18:EF:03:18
[CHG] Device 40:72:18:EF:03:18 Connected: yes

...

Connection successful

...

```

Now that you're connected, the prompt will change to the device name. In my
case that's `[ULT WEAR]> `. Enter `trust ` and the MAC address and you're done! 

```
[ULT WEAR]> trust 40:72:18:EF:03:18 
[CHG] Device 40:72:18:EF:03:18 Trusted: yes
Changing 40:72:18:EF:03:18 trust succeeded

...

[ULT WEAR]> 
```

Type a `CTRL-D` to exit `bluetoothctl`.

### Testing ChucK

1. Go to the examples directory for Chapter 1 of the book referenced above.

```
pushd ~/Projects/miniAudicle/src/chuck/examples/book/digital-artists/chapter1
```

2. Type `chuck --verbose --driver:pulse ./WowExample.ck`. You'll see a
collection of diagnostic information, and then you'll hear random short
notes from ChucK!

```
❯ chuck --verbose --driver:pulse ./WowExample.ck 
[chuck:5:INFORM]: setting log level to: 5 (INFORM)...
[chuck:2:SYSTEM]: initializing chuck...
[chuck:2:SYSTEM]:  | initializing system settings...
[chuck:3:HERALD]:  |  | allocating buffers for 256 x 2 samples...
[chuck:2:SYSTEM]:  | initializing virtual machine...
[chuck:3:HERALD]:  |  | locking down special objects...
[chuck:2:SYSTEM]:  |  | allocating shreduler...
[chuck:2:SYSTEM]:  |  | allocating messaging buffers...
[chuck:2:SYSTEM]:  |  | allocating globals manager...
[chuck:2:SYSTEM]:  | initializing compiler...

...

[chuck:2:SYSTEM]:  | starting OTF command listener on port: 8888...
[chuck:2:SYSTEM]:  | local time: Sat Oct 18 18:33:56 2025
[chuck:2:SYSTEM]:  | initializing audio I/O...
[chuck:2:SYSTEM]:  |  | real-time audio: YES
[chuck:2:SYSTEM]:  |  | mode: CALLBACK
[chuck:2:SYSTEM]:  |  | sample rate: 48000
[chuck:2:SYSTEM]:  |  | buffer size: 256
[chuck:2:SYSTEM]:  |  | num buffers: 8
[chuck:2:SYSTEM]:  |  | adaptive block processing: 0
[chuck:2:SYSTEM]:  |  | audio driver: Pulse
[chuck:2:SYSTEM]:  |  | adc:1 "Monitor of ULT WEAR"
[chuck:2:SYSTEM]:  |  | dac:2 "ULT WEAR"
[chuck:2:SYSTEM]:  |  | channels in: 2 out: 2
[chuck:2:SYSTEM]:  | chuck version: 1.5.5.5 (chai)
[chuck:2:SYSTEM]: starting chuck...
[chuck:2:SYSTEM]:  | starting compilation...
[chuck:3:HERALD]:  |  | compiling './WowExample.ck'...
[chuck:5:INFORM]:  |  |  | @import scanning within target 'WowExample.ck'...
[chuck:2:SYSTEM]:  | starting real-time audio...
[chuck:2:SYSTEM]:  | starting virtual machine...
[chuck:2:SYSTEM]:  | starting main loop...
```

To stop the music, type `CTRL-C`.
