# Usage notes

1. `git` is not installed by default on PiOS Lite 32-bit. So you
will need to do

    ```
    sudo apt update && sudo apt install git -qqy --no-install-recommends
    ```

    first.

2. Once you have `git` installed, do

    ```
    git clone https://github.com/AlgoCompSynth/ChucK-in-the-Box.git
    cd ChucK-in-the-Box
    ./0_pios_setup.sh
    ```

3. Reboot

4. After the reboot, run the install scripts:

    ```
    ./1_global_installs.sh # Linux packages
    ./2_local_installs.sh # command line conveniences
    ./3_upgrades.sh # package database updates / upgrades
    ./4_install_ChucK.sh # ChucK, ChuGins and Linux dependencies
    ```
