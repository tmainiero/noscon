# How to Install Interception Tools in a Debian-based distro:
(c.f. https://gitlab.com/interception/linux/tools and https://askubuntu.com/questions/979359/how-do-i-install-caps2esc)

1. First make sure the following dependencies exist (libyaml-cpp-dev is ~150 MB):

```
sudo apt-get install libyaml-cpp-dev 
sudo apt install libdev-dev
sudo apt install libudev-dev
```

2. Then:

```
mkdir ~/interception_tools
cd interception_tools
git clone https://gitlab.com/interception/linux/tools.git
cd tools
mkdir build
cd build
cmake ..
make
sudo make install
```

3. Now for the plugins: (Plugin inspired by https://github.com/vyp/dots/tree/master/interception-tools/plugins)

```
cd plugins
mkdir build  (makes a directory to put build files)
cd build
cmake ..
make
sudo make install
```

4. Finally:

    - udevmon.yaml is copied into /etc/udevmon.yaml
    - udevmon.service is copied into /etc/systemd/udevmon.service
    - sudo systemctl enable udevmon

5. To remove:

    - Get rid of /usr/bin/enter+rightctrl and other plugins
    - Git rid of /etc/udevmon.yaml
    - Get rid of /etc/systemd/udevmon.service

# Notes

## Finding Keycodes and Event Codes
To find keycodes and event codes use `sudo libinput debug-events --show keycodes` then press key of interest.

Sometimes `xev` is suggested to determine keycodes, then we can look up event codes via: (https://github.com/torvalds/linux/blob/master/include/uapi/linux/input-event-codes.h).
I've noticed, however, sometimes `xev` fails altogether or (seems to?) give the wrong keycode (e.g. pressing super gives Keycode 133 = KEY_COPY) while the `libinput` method above seems to be more reliable.

## References
Examples inspired from:

    - (https://github.com/keepclean/win2alt/blob/master/win2alt.c): simple key replacement
    - (https://gitlab.com/oarmstrong/ralt2hyper/-/blob/master/ralt2hyper.c): (combination key replacement)

Alternatives to the manual approach I use here:

    - Dual function keys plugin (probably what you want if you want tap/hold configurations and don't simultaneously need "instant" key swaps)
    - KMonad (way more powerful as far as I can tell; cross-platform)
