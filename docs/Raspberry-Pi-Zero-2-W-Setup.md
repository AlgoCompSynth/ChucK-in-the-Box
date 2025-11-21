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
multi-job GCC compiles or a graphical desktop. But it's plenty
for many audio applications, even two-dimensional physical models.

Because of the RAM limitation, ChucK-in-the-Box on the Raspberry
Pi Zero 2 W differs from the Raspberry Pi 4 and 5 versions:

- The Zero 2 W is based on the PiOS Lite version - there is
no desktop,
- miniAudicle and qpwgraph are only supported on the larger
Pis, and
- only ALSA and PulseAudio are supported - JACK, PipeWire and
WirePlumber are not installed.

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
sudo apt dist-upgrade -y
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
(`chuck --driver:jack`) is installed, the supporting software is not
installed. You will need to use either ALSA or PulseAudio.

## Audio example walkthrough

### Connecting a Bluetooth device - you can skip this for wired devices

The following is how I connect my Sony ULT Wear Bluetooth headset. The
steps should be similar for other Bluetooth audio devices, but the MAC
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
hci0 new_settings: powered bondable ssp br/edr le secure-conn 
Agent registered
[CHG] Controller B8:27:EB:F0:C4:E3 Pairable: yes
[bluetoothctl]> scan on
SetDiscoveryFilter success
Discovery started
[CHG] Controller B8:27:EB:F0:C4:E3 Discovering: yes
    . . .
[NEW] Device 40:72:18:EF:03:18 ULT WEAR
    . . .
[CHG] Device 40:72:18:EF:03:18 RSSI: 0xffffffd5 (-43)
[CHG] Device 40:72:18:EF:03:18 Class: 0x00240404 (2360324)
[CHG] Device 40:72:18:EF:03:18 Icon: audio-headset
[CHG] Device 40:72:18:EF:03:18 UUIDs: fa349b5f-8050-0030-0010-00001bbb231d
[CHG] Device 40:72:18:EF:03:18 UUIDs: 00000000-deca-fade-deca-deafdecacaff
[bluetoothctl]> scan off
Discovery stopped
    . . .
[CHG] Controller B8:27:EB:F0:C4:E3 Discovering: no
```

Note that these scans can be quite noisy, depending on how many Bluetooth
devices are active in range of the radio on your Raspberry Pi. So at the
first `[bluetoothctl]> ` prompt after your Bluetooth device shows up,
enter `scan off`! This won't eliminate all the noise but it will get rid
of many messages.

The string of bytes after the "Device" is the MAC address for my ULT Wear.
You'll see messages go by before and after that, but don't worry;
eventually you'll get another `[bluetoothctl]> ` prompt. At that point,
enter `pair ` followed by the device MAC address. There's tab completion,
so you only need to type the first few characters and `tab` and the rest
will be filled in!

```
[bluetoothctl]> pair 40:72:18:EF:03:18 
Attempting to pair with 40:72:18:EF:03:18
[CHG] Device 40:72:18:EF:03:18 Connected: yes
[CHG] Device 40:72:18:EF:03:18 Bonded: yes
[CHG] Device 40:72:18:EF:03:18 Modalias: usb:v054Cp0F1Ed0207
[CHG] Device 40:72:18:EF:03:18 UUIDs: 00000000-deca-fade-deca-deafdecacaff
[CHG] Device 40:72:18:EF:03:18 UUIDs: 00001108-0000-1000-8000-00805f9b34fb
[CHG] Device 40:72:18:EF:03:18 UUIDs: 0000110b-0000-1000-8000-00805f9b34fb
[CHG] Device 40:72:18:EF:03:18 UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
[CHG] Device 40:72:18:EF:03:18 UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
[CHG] Device 40:72:18:EF:03:18 UUIDs: 0000111e-0000-1000-8000-00805f9b34fb
[CHG] Device 40:72:18:EF:03:18 UUIDs: 00001124-0000-1000-8000-00805f9b34fb
[CHG] Device 40:72:18:EF:03:18 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
[CHG] Device 40:72:18:EF:03:18 UUIDs: 0000ff01-0000-1000-8000-00805f9b34ff
[CHG] Device 40:72:18:EF:03:18 UUIDs: 0000ff01-0000-1000-8000-504759592966
[CHG] Device 40:72:18:EF:03:18 UUIDs: 7fd78f59-64e6-1abb-5f49-ab7c00cb6af7
[CHG] Device 40:72:18:EF:03:18 UUIDs: 81c2e72a-0591-443e-a1ff-05f988593351
[CHG] Device 40:72:18:EF:03:18 UUIDs: 8901dfa8-5c7e-4d8f-9f0c-c2b70683f5f0
[CHG] Device 40:72:18:EF:03:18 UUIDs: 931c7e8a-540f-4686-b798-e8df0a2ad9f7
[CHG] Device 40:72:18:EF:03:18 UUIDs: 956c7b26-d49a-4ba8-b03f-b17d393cb6e2
[CHG] Device 40:72:18:EF:03:18 UUIDs: 9b26d8c0-a8ed-440b-95b0-c4714a518bcc
[CHG] Device 40:72:18:EF:03:18 UUIDs: df21fe2c-2515-4fdb-8886-f12c4d67927c
[CHG] Device 40:72:18:EF:03:18 UUIDs: f7a96061-a1b3-40de-aff0-e78ec45a151e
[CHG] Device 40:72:18:EF:03:18 UUIDs: f8d1fbe4-7966-4334-8024-ff96c9330e15
[CHG] Device 40:72:18:EF:03:18 UUIDs: fa349b5f-8050-0030-0010-00001bbb231d
[CHG] Device 40:72:18:EF:03:18 ServicesResolved: yes
[CHG] Device 40:72:18:EF:03:18 Paired: yes
Pairing successful
[CHG] Device 40:72:18:EF:03:18 ServicesResolved: no
[CHG] Device 40:72:18:EF:03:18 Connected: no
```

At the next `[bluetoothctl]> ` prompt enter `connect ` followed by the
MAC address. Again, tab completion will work.

```
[bluetoothctl]> connect 40:72:18:EF:03:18 
Attempting to connect to 40:72:18:EF:03:18
    . . .
[CHG] Device 40:72:18:EF:03:18 Connected: yes
[NEW] Endpoint /org/bluez/hci0/dev_40_72_18_EF_03_18/sep1 
[NEW] Endpoint /org/bluez/hci0/dev_40_72_18_EF_03_18/sep2 
[NEW] Transport /org/bluez/hci0/dev_40_72_18_EF_03_18/sep1/fd2 
[CHG] Transport /org/bluez/hci0/dev_40_72_18_EF_03_18/sep1/fd2 State: active
Connection successful
[CHG] Transport /org/bluez/hci0/dev_40_72_18_EF_03_18/sep1/fd2 Volume: 0x0026 (38)
[CHG] Device 40:72:18:EF:03:18 ServicesResolved: yes
[CHG] Transport /org/bluez/hci0/dev_40_72_18_EF_03_18/sep1/fd2 State: idle
```

Now that you're connected, the prompt will change to the device name. In my
case that's `[ULT WEAR]> `. Enter `trust ` and the MAC address and you're done! 

```
[ULT WEAR]> trust 40:72:18:EF:03:18 
[CHG] Device 40:72:18:EF:03:18 Trusted: yes
Changing 40:72:18:EF:03:18 trust succeeded
```

At the next prompt, enter `quit`.

```
[ULT WEAR]> quit

> 

### Choosing a device for ChucK

My test system has, in addition to the default HDMI output, a USB dongle,
a USB gaming headset, and the ULT Wear Bluetooth headset just configured.
When you run ChucK, you need to tell it which one to use.

ChucK programs almost always send audio to an output device, which is
given the code name `dac` for digital-analog converter. And they sometimes
read audio from an input device like a microphone or a "line in" jack,
which is given the code name `adc` for analog-digital converter. If
you have multiple devices, like I do, you need to specify `dac` and
`adc` on the ChucK command line.

How do you get those numbers? `chuck --probe`. Since we're using
PulseAudio, it's `chuck --probe --driver:pulse`. The output of
this is lengthy, so I'm only going to show the results in full
for the ULT Wear.

```
❯ chuck --probe --driver:pulse
[chuck]: [Pulse] driver found 8 audio device(s)...
[chuck]: 
[chuck]: ------( audio device: 1 )------
[chuck]: device name = "Monitor of KT USB Audio Analog Stereo"

    . . .

[chuck]: ------( audio device: 2 )------
[chuck]: device name = "ULT WEAR"
[chuck]: probe [success]...
[chuck]: # output channels = 2
[chuck]: # input channels  = 0
[chuck]: # duplex Channels = 0
[chuck]: default output = YES
[chuck]: default input = NO
[chuck]: natively supported data formats:
[chuck]:   16-bit int
[chuck]:   24-bit int
[chuck]:   32-bit int
[chuck]:   32-bit float
[chuck]: supported sample rates:
[chuck]:   8000 Hz
[chuck]:   16000 Hz
[chuck]:   22050 Hz
[chuck]:   32000 Hz
[chuck]:   44100 Hz
[chuck]:   48000 Hz
[chuck]:   96000 Hz
[chuck]:   192000 Hz
[chuck]: 
[chuck]: ------( audio device: 3 )------
[chuck]: device name = "KT USB Audio Analog Stereo"

    . . .

[chuck]: ------( audio device: 4 )------
[chuck]: device name = "Logitech G PRO X Gaming Headset Analog Stereo"

    . . .

[chuck]: ------( audio device: 5 )------
[chuck]: device name = "KT USB Audio Mono"

    . . .

[chuck]: ------( audio device: 6 )------
[chuck]: device name = "Monitor of Logitech G PRO X Gaming Headset Analog Stereo"

    . . .

[chuck]: ------( audio device: 7 )------
[chuck]: device name = "Logitech G PRO X Gaming Headset Mono"

    . . .

[chuck]: ------( audio device: 8 )------
[chuck]: device name = "Monitor of ULT WEAR"
[chuck]: probe [success]...
[chuck]: # output channels = 0
[chuck]: # input channels  = 2
[chuck]: # duplex Channels = 0
[chuck]: default output = NO
[chuck]: default input = NO
[chuck]: natively supported data formats:
[chuck]:   16-bit int
[chuck]:   24-bit int
[chuck]:   32-bit int
[chuck]:   32-bit float
[chuck]: supported sample rates:
[chuck]:   8000 Hz
[chuck]:   16000 Hz
[chuck]:   22050 Hz
[chuck]:   32000 Hz
[chuck]:   44100 Hz
[chuck]:   48000 Hz
[chuck]:   96000 Hz
[chuck]:   192000 Hz
[chuck]: 

    . . .

❯ 
```

In this listing, "Monitor of" refers to the audio input channels -
for ChucK programs that read audio, this is the `adc` number. The
ones without "Monitor of" are the output channels, which will be
the `dac` number. "KT USB Audio" is the USB dongle and "Logitech
G PRO X Gaming Headset" is the gaming headset.

So for the ULT Wear, `dac` is `2` and `adc` is 8.

### Testing ChucK

So to test ChucK, I need to type

```
chuck --driver:pulse --dac:2 --adc:8 ~/WowExample.ck
```

If you're following along at home, use the `dac` number for the device
you chose from your `chuck --probe` listing.

To stop the music, type `CTRL-C`.

If you have problems,
please [open an issue](https://github.com/AlgoCompSynth/ChucK-in-the-Box/issues/new)
at <https://github.com/AlgoCompSynth/ChucK-in-the-Box/issues/new>.
