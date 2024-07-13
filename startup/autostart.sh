#!/bin/bash
# Changes to System Utils workspace, then back again

sleep 1

wmctrl -s 1

sleep 1

/opt/docker-desktop/bin/docker-desktop

sleep 1

# sudo python3 ~/dns-changer/main.py & disown
dns_changer & disown

sleep 1

studio-controls &>/dev/null & disown

sleep 10

carla ~/Carla/default.carxp &>/dev/null & disown

sleep 2

wmctrl -s 0
