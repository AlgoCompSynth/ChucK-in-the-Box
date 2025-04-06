# Usage notes

1. `git` is not installed by default on PiOS Lite 32-bit. So you
will need to do

    ```
    sudo apt update && sudo apt install -y git
    ```

    first.

2. Once you have `git` installed, do

    ```
    git clone https://github.com/AlgoCompSynth/ChucK-in-the-Box.git
    cd ChucK-in-the-Box
    ./0_pios_setup.sh 2>&1 | tee 0_pios_setup.log
    ```

3. Reboot

4. After the reboot, install the command line conveniences, `ChucK` and `pforth`:

    ```
    ./1_command_line.sh
    ./2_install_ChucK.sh
    ./3_install_pforth.sh
    ```

5. Update the system databases:

    ```
    upgrades.sh
    ```
