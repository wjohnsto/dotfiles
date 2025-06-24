#!/bin/bash
# Changes to System Utils workspace, then back again

sleep 1

tailscale up --accept-dns=false & disown

sleep 1

wmctrl -s 2

sleep 1

# studio-controls &>/dev/null & disown
pavucontrol &>/dev/null & disown

sleep 1

carla ~/Carla/default.carxp &>/dev/null & disown

sleep 18

wmctrl -s 0
