#!/bin/bash
# Changes to System Utils workspace, then back again

sleep 3

wmctrl -s 1

sleep 1

/opt/docker-desktop/bin/docker-desktop

sleep 2

# sudo python3 ~/dns-changer/main.py & disown
dns_changer & disown

sleep 2

studio-controls &>/dev/null & disown

sleep 6

carla ~/Carla/default.carxp &>/dev/null & disown

sleep 2

wmctrl -s 0
