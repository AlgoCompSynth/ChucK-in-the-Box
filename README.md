# Usage notes

1. `git` is not installed by default on PiOS Lite 32-bit. So you
will need to do

    ```
    sudo apt update && sudo apt install -qqy --no-install-recommends git
    ```

    first.

2. Once you have `git` installed, do

    ```
    git clone https://github.com/AlgoCompSynth/ChucK-in-the-Box.git
    cd ChucK-in-the-Box
    ./0_pios_setup.sh # system level configuration
    ./1_terminal_setup.sh # Nerd fonts and Starship prompt
    ./2_basic_devel.sh # basic development Linux packages
    ./3_ChucK.sh # ChucK, ChuGins and Linux dependencies
    ./pkg_db_updates.sh package database updates
    ```

3. Reboot.
