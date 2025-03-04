#!/bin/bash
# Changes to System Utils workspace, then back again

sleep 2

wmctrl -s 1

sleep 1

# studio-controls &>/dev/null & disown
pavucontrol &>/dev/null & disown

sleep 3

# sudo python3 ~/dns-changer/main.py & disown
dns_changer &>/dev/null & disown

sleep 6

carla ~/Carla/default.carxp &>/dev/null & disown

