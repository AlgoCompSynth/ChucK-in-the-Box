# Setting up ChucK-in-the-Box on a Raspberry Pi with a [Blokas Pisound Card](https://blokas.io/pisound/docs/)

## Flashing the microSD card

Use the
[Raspberry Pi Imager](https://www.raspberrypi.com/software/)
to flash the card. Use the default Raspberry Pi OS (64-bit) and make
sure you have the settings filled out. On the "General" tab, you will
need to set

1. the hostname,
2. the username and password,
3. the WiFi SSID and password, and
4. the time zone and keyboard layout.

On the "Services" tab, make sure the "Use password authentication" radio
button is selected. Then press the "Save" button and continue with the
flashing.

Once the flashing is complete, remove the card from the writer, insert
it into the Raspberry Pi and boot the system up. Then use Secure Shell
(`ssh`) to log in and verify that the system is accessible.

## Setting up remote access

The Blokas Pisound hardware and software are designed for headless
operation. As noted above, you should already have command line
remote access on your local area network (LAN) via `ssh`. But if you
plan to use the ChucK
[miniAudicle](https://github.com/ccrma/miniAudicle/blob/main/README.md)
interactive development environment (IDE) from ChucK-in-the-Box,
the Pure Data GUI from the Blokas Pisound software that ChucK-in-the-Box
installs, or any other desktop audio application, you will need either a
keyboard, video monitor and mouse or remote desktop access.

The instructions for setting up remote access are here:
<https://www.raspberrypi.com/documentation/computers/remote-access.html>.
In the remainder of this guide, I will only be using command-line access
via `ssh`.

## Verifying that Linux can access the Pisound hardware

1. Use Secure Shell (`ssh`) to log in with the username and password you
set when you formatted the microSD card. For example, my system is
`partch.local` on my WiFi network, so I do `ssh partch.local`:

    ❯ ssh partch.local 
    Linux partch 6.12.34+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.12.34-1+rpt1~bookworm (2025-06-26) aarch64

    The programs included with the Debian GNU/Linux system are free software;
    the exact distribution terms for each program are described in the
    individual files in /usr/share/doc/*/copyright.

    Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
    permitted by applicable law.
    Last login: Fri Sep  5 21:55:37 2025

2. Verify that the PiOS operating system software can access the Blokas
Pisound and Raspberry Pi audio hardware: At the base level, Linux audio
is managed by the
[Advanced Linux Sound Architecture](https://www.alsa-project.org/wiki/Main_Page)
(ALSA) subsystem. ALSA provides playback, capture and sequencing
capabilities.

    - Playback devices - `aplay -l`:

        ```
        $ aplay -l
        **** List of PLAYBACK Hardware Devices ****
        card 0: vc4hdmi0 [vc4-hdmi-0], device 0: MAI PCM i2s-hifi-0 [MAI PCM i2s-hifi-0]
          Subdevices: 1/1
          Subdevice #0: subdevice #0
        card 1: vc4hdmi1 [vc4-hdmi-1], device 0: MAI PCM i2s-hifi-0 [MAI PCM i2s-hifi-0]
          Subdevices: 1/1
          Subdevice #0: subdevice #0
        card 2: pisound [pisound], device 0: PS-21N472P snd-soc-dummy-dai-0 [PS-21N472P snd-soc-dummy-dai-0]
          Subdevices: 1/1
          Subdevice #0: subdevice #0
        ```

        My Raspberry Pi 5 has two HDMI adapters. The first two cards in this list are
        the audio channels for those adapters. The third card is the Blokas Pisound.
        Your system may vary but you should see the Pisound and all HDMI adapters.

    - Capture devices - `arecord -l`:

        ```
        $ arecord -l
        **** List of CAPTURE Hardware Devices ****
        card 2: pisound [pisound], device 0: PS-21N472P snd-soc-dummy-dai-0 [PS-21N472P snd-soc-dummy-dai-0]
          Subdevices: 1/1
          Subdevice #0: subdevice #0
        ```

        On my system, the only capture device I have is the Blokas Pisound,
        and it has the same card number - 2 - as the Pisound playback device.

    - Sequencer connections - `aconnect -l`:

        ```
        $ aconnect -l
        client 0: 'System' [type=kernel]
            0 'Timer           '
	        Connecting To: 142:0
            1 'Announce        '
	        Connecting To: 142:0
        client 14: 'Midi Through' [type=kernel]
            0 'Midi Through Port-0'
        client 24: 'pisound' [type=kernel,card=2]
            0 'pisound MIDI PS-21N472P'
        client 142: 'PipeWire-System' [type=user,pid=848]
            0 'input           '
	        Connected From: 0:1, 0:0
        client 143: 'PipeWire-RT-Event' [type=user,pid=848]
            0 'input
        ```

    Clients 0 and 14 are part of the base Linux kernel and would be seen
    on any Raspberry Pi system. Client 24 is the Pisound hardware MIDI
    connectors. Clients 142 and 143 are part of the
    [PipeWire](https://www.pipewire.org/) multimedia management system.

    PipeWire is a relative newcomer to Linux audio tooling. For more
    information on how PipeWire integrates with the base Debian
    `bookworm` system on a Raspberry Pi, see
    <https://wiki.debian.org/PipeWire#Debian_12>.

## Full software upgrade

Before proceeding further, do a package database update - `sudo apt update` - 
and then a full system upgrade - `sudo apt full-upgrade -qqy`.

    $ sudo apt update # update the package database
    Hit:1 http://deb.debian.org/debian bookworm InRelease
    Get:2 http://deb.debian.org/debian-security bookworm-security InRelease [48.0 kB]
    Get:3 http://deb.debian.org/debian bookworm-updates InRelease [55.4 kB]
    Get:4 http://deb.debian.org/debian-security bookworm-security/main arm64 Packages [273 kB]
    Get:5 http://deb.debian.org/debian-security bookworm-security/main armhf Packages [258 kB]
    Hit:6 http://archive.raspberrypi.com/debian bookworm InRelease
    Fetched 634 kB in 6s (114 kB/s)
    Reading package lists... Done
    Building dependency tree... Done
    Reading state information... Done
    223 packages can be upgraded. Run 'apt list --upgradable' to see them.
    $ sudo apt full-upgrade -qqy # be as quiet as possible

At the time of this writing (2025-09-05), upgrading a freshly-installed
system will stop for user input:

    Configuration file '/etc/initramfs-tools/initramfs.conf'
     ==> Modified (by you or by a script) since installation.
     ==> Package distributor has shipped an updated version.
       What would you like to do about it ?  Your options are:
        Y or I  : install the package maintainer's version
        N or O  : keep your currently-installed version
          D     : show the differences between the versions
          Z     : start a shell to examine the situation
     The default action is to keep your current version.
    *** initramfs.conf (Y/I/N/O/D/Z) [default=N] ?

If this happens, answer "Y".

When the upgrade finishes, reboot the system with `sudo reboot` and
log back in again.

## Installing the ChucK-in-the-Box software

### Cloning the GitHub repository

Currently, ChucK-in-the-Box is in a pre-release state and the way
to install it is from a `git` repository. First, log in with `ssh`
and create a `Projects` directory. `cd` into this directory and
clone the repository.

```
cd ~
mkdir Projects
cd Projects
git clone https://github.com/AlgoCompSynth/ChucK-in-the-Box.git
```

### Setting up the PiOS host software

The script `1-pios-host-setup.sh` installs some base Linux packages,
including the dependencies for building ChucK and the miniAudicle.
Then it patches the Bluetooth configuration to eliminate some errors
in the system logs.  Finally it installs the Blokas Pisound software.

```
$ cd ~/Projects/ChucK-in-the-Box
$ ./1-pios-host-setup.sh 

* PiOS Host Setup *
LOGFILE: /home/znmeb/Logfiles/pios-host-setup.log
Installing Linux base tools
Reconfiguring Bluetooth
117c117
< Experimental = true
---
> #Experimental = false
Installing Blokas Pisound software
Updating apt-file database
Updating locate database
* Finished PiOS Host Setup *
```

If you don't see the "* Finished PiOS Host Setup *" message,
the script probably has a bug. In that case, open a GitHub
issue at
<https://github.com/AlgoCompSynth/ChucK-in-the-Box/issues/new>
and attach the LOGFILE so I can troubleshoot it on my machine.
Note that the LOGFILE will probably be in a different place
on your machine!!

### Installing ChucK, the ChuGins and the miniAudicle

Script `2-install-miniAudicle.sh` recursively clones the
miniAudicle GitHub repository, which includes ChucK and the
ChuGins. Then it builds ChucK, the ChuGins and the miniAudicle
from source and installs them in `/usr/local`.

```
$ cd ~/Projects/ChucK-in-the-Box
$ ./2-install-miniAudicle.sh 

* miniAudicle *
LOGFILE: /home/znmeb/Logfiles/miniaudicle.log
Setting Qt version
Recursively cloning miniAudicle repository - this takes some time
Building ChucK
Installing ChucK
chuck --probe
[chuck]: [ALSA] driver found 4 audio device(s)...
[chuck]: 
[chuck]: ------( audio device: 1 )------
[chuck]: device name = "default"
[chuck]: probe [success]...
[chuck]: # output channels = 64
[chuck]: # input channels  = 64
[chuck]: # duplex Channels = 64
[chuck]: default output = YES
[chuck]: default input = YES
[chuck]: natively supported data formats:
[chuck]:   16-bit int
[chuck]:   24-bit int
[chuck]:   32-bit int
[chuck]:   32-bit float
[chuck]: supported sample rates:
[chuck]:   4000 Hz
[chuck]:   5512 Hz
[chuck]:   8000 Hz
[chuck]:   9600 Hz
[chuck]:   11025 Hz
[chuck]:   16000 Hz
[chuck]:   22050 Hz
[chuck]:   32000 Hz
[chuck]:   44100 Hz
[chuck]:   48000 Hz
[chuck]:   88200 Hz
[chuck]:   96000 Hz
[chuck]:   176400 Hz
[chuck]:   192000 Hz
[chuck]: 
[chuck]: 
[chuck]: 
[chuck]: ------( audio device: 4 )------
[chuck]: device name = "hw:pisound,0"
[chuck]: probe [success]...
[chuck]: # output channels = 2
[chuck]: # input channels  = 2
[chuck]: # duplex Channels = 2
[chuck]: default output = NO
[chuck]: default input = NO
[chuck]: natively supported data formats:
[chuck]:   16-bit int
[chuck]:   24-bit int
[chuck]:   32-bit int
[chuck]: supported sample rates:
[chuck]:   48000 Hz
[chuck]:   96000 Hz
[chuck]:   192000 Hz
[chuck]: 
[chuck]: 
[chuck]: ------( 3 MIDI inputs  )------
[chuck]:     [0] : "Midi Through:Midi Through Port-0 14:0"
[chuck]:     [1] : "pisound:pisound MIDI PS-21N472P 24:0"
[chuck]:     [2] : "pisound-ctl:pisound-ctl 128:0"
[chuck]: 
[chuck]: ------( 3 MIDI outputs )-----
[chuck]:     [0] : "Midi Through:Midi Through Port-0 14:0"
[chuck]:     [1] : "pisound:pisound MIDI PS-21N472P 24:0"
[chuck]:     [2] : "pisound-ctl:pisound-ctl 128:0"
[chuck]: 
[chuck]: ------( 3 keyboard devices )------
[chuck]:     [0] : "vc4-hdmi-1 HDMI Jack"
[chuck]:     [1] : "vc4-hdmi-0 HDMI Jack"
[chuck]:     [2] : "pwr_button"
[chuck]: 
```

The above listing shows the audio hardware visible to ChucK.
It is saved on the LOGFILE, which you should keep for
reference in coding.

```
Building ChuGins
Installing ChuGins
chuck --chugin-probe
[chuck:2:SYSTEM]: chugin system: ON
[chuck:2:SYSTEM]: chugin host API version: 10.2
[chuck:2:SYSTEM]:  | chugin major version must == host major version
[chuck:2:SYSTEM]:  | chugin minor version must <= host minor version
[chuck:2:SYSTEM]:  | language version: 1.5.5.2 (chai)
[chuck:2:SYSTEM]: probing chugins (.chug)...
[chuck:2:SYSTEM]: probing specified chugins (e.g., via --chugin)...
[chuck:2:SYSTEM]: probing chugins in search paths...
[chuck:2:SYSTEM]:  | searching '/usr/lib/chuck/'
[chuck:2:SYSTEM]:  | searching '/usr/local/lib/chuck/'
[chuck:2:SYSTEM]:  |  | [chugin] ABSaturator.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] AmbPan.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] Binaural.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] Bitcrusher.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] Elliptic.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] ExpDelay.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] ExpEnv.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] FIR.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] FoldbackSaturator.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] GVerb.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] KasFilter.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] Ladspa.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] Line.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] MagicSine.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] Mesh2D.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] Multicomb.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] NHHall.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] Overdrive.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] PanN.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] Patch.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] Perlin.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] PitchTrack.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] PowerADSR.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] Random.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] Range.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] RegEx.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] Sigmund.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] Spectacle.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] Wavetable.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] WinFuncEnv.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] WPDiodeLadder.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] WPKorg35.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  |  | [chugin] XML.chug [OK] (API version: 10.2)
[chuck:2:SYSTEM]:  | searching '/home/znmeb/.chuck/packages/'
[chuck:2:SYSTEM]:  | searching '/home/znmeb/.chuck/lib/'
[chuck:2:SYSTEM]: probing chuck files (.ck)...
[chuck:2:SYSTEM]: global cleanup initiating...
[chuck:2:SYSTEM]: shutting down ChucK instance...
[chuck:2:SYSTEM]:  | ChucK instance shutdown complete.
```

The above listing shows the ChuGins that were installed.
Those are the defaults; there are some others in the
repository that have more dependencies and are thus not
installed by default. This list is also saved to LOGFILE.

```
Building miniAudicle
Installing miniAudicle
* Finished miniAudicle *
```

As with the first script, if you don't see the "* Finished
miniAudicle *" message, the script probably has a bug and
you should open a GitHub issue at
<https://github.com/AlgoCompSynth/ChucK-in-the-Box/issues/new>
and attach the LOGFILE so I can troubleshoot it on my machine.
