# Setting up ChucK-in-the-Box on a Raspberry Pi with a [Blokas Pisound Card](https://blokas.io/pisound/docs/)

## Formatting the microSD card

Use the
[Raspberry Pi Imager](https://www.raspberrypi.com/software/)
to format the card. Use the default Raspberry Pi OS and make sure you
have the settings filled out. On the "General" tab, you will need to set

1. the hostname,
2. the username and password,
3. the WiFi SSID and password, and
4. the time zone and keyboard layout.

On the "Services" tab, make sure the "Use password authentication" radio
button is selected. Then press the "Save" button and continue with the
formatting.

## Verifying the hardware accessibility

Insert the formatted microSD card in the Raspberry Pi and boot the system
up. Then

1. Use Secure Shell (`ssh`) to log in with the username and password you
set when you formatted the microSD card.
2. Verify that the PiOS operating system software can access the Blokas
Pisound and Raspberry Pi audio hardware.

    At the base level, Linux audio is managed by the
    [Advanced Linux Sound Architecture](https://www.alsa-project.org/wiki/Main_Page)
    (ALSA) subsystem. ALSA provides playback, capture and sequencing capabilities.

    - Playback devices:

        ```
        znmeb@partch:~ $ aplay -l
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

    - Capture devices:

        ```
        znmeb@partch:~ $ arecord -l
        **** List of CAPTURE Hardware Devices ****
        card 2: pisound [pisound], device 0: PS-21N472P snd-soc-dummy-dai-0 [PS-21N472P snd-soc-dummy-dai-0]
          Subdevices: 1/1
          Subdevice #0: subdevice #0
        ```

        On my system, the only capture device I have is the Blokas Pisound,
        and it has the same card number - 2 - as the Pisound playback device.

    - Sequencer connections:

        ```
        znmeb@partch:~ $ aconnect -l
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


## Setting up remote access

The Blokas Pisound hardware and software are designed for headless
operation, so even if you have an attached keyboard, video monitor and
mouse, you should set up remote access.
