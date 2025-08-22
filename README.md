# ChucK-in-the-Box - computer music in a container!

## What is this?

ChucK-in-the-Box is a container-based computer music development
environment.

1. Container-based: ChucK-in-the-Box uses
[Distrobox](https://distrobox.it/) containers. A Distrobox container
can run on most recent Linux hosts. The host runs the Linux kernel,
and manages all the devices, processes, and memory. The container runs
the application software and has access to both the user's files on the
host and its own dedicated files.

    The key advantages of containers:

    1. Efficiency - unlike a full virtual machine, a container's processes
       are managed directly by the host OS - there's no hypervisor overhead.
    2. Flexibility - a Distrobox container can use any Linux distribution
       for which a base image exists. For example, my primary container host
       is [Universal Blue Bluefin](https://projectbluefin.io/), which is
       based on Fedora Linux, but the ChucK-in-the-Box containers run on
       Debian 12 or 13 or Ubuntu 24.04 LTS or Ubuntu 25.04.
    3. Access to host devices and files - like an [Appimage](https://appimage.org/)
       or [Flatpak](https://flatpak.org/), applications in a Distrobox container
       can show up on the host desktop. But a Distrobox container can export
       multiple applications instead of being a packaged single application like
       an Appimage or Flatpak.

2. Computer music development environment: ChucK-in-the-Box contains

    1. The [ChucK](https://chuck.stanford.edu/) ecosystem: ChucK, miniAudicle,
     ChuGins and [ChuGL](https://chuck.stanford.edu/chugl/),
    2. [FluidSynth](https://www.fluidsynth.org/) SoundFont-based tools, and
    3. The [Faust](https://faust.grame.fr/) audio programming language.  

## Status / Roadmap

My main deployment at the moment is on a 2020-vintage gaming PC with an 8-core
Intel i7 CPU and an NVIDIA RTX 3090 GPU. I have some experimental builds for
a 16 GB Raspberry Pi 5, and ChucK, most of the ChuGins and the miniAudicle seem
to be working. However, the ChuGL graphics library is not working on the Pi.

So I'm going to call this release 0.2.5. I have a ChuGL project in the works
that I'm going to do using the gaming PC and the fallout from that should
take ChucK-in-the-Box to at least 0.7.5. Somewhere in the process I'll be
adding some R tools so everything I use is packaged together.
