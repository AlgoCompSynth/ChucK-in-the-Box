# ChucK-in-the-Box - computer music in a container!

## What is this?

ChucK-in-the-Box is a container-based computer music development
environment. The 10,000-foot level overview:

- Containers: ChucK-in-the-Box uses
[Distrobox](https://distrobox.it/) containers. A Distrobox container
can run on most recent Linux hosts. The host runs the Linux kernel,
manages all the devices, processes, and memory. The container runs
the application software and has both access to the user's home files
and its own dedicated files.

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

    - Computer music: ChucK-in-the-Box contains

        1. The [ChucK](https://chuck.stanford.edu/) ecosystem: ChucK,
           miniAudicle, ChuGins and [ChuGL](https://chuck.stanford.edu/chugl/),
        2. [FluidSynth](https://www.fluidsynth.org/) SoundFont-based tools, and
        3. The [Faust](https://faust.grame.fr/) audio programming language.  
