#!/usr/bin/env bash

#######################################################################
# https://wiki.hyprland.org/Useful-Utilities/Hyprland-desktop-portal/ #
#######################################################################

sleep 1
killall -e xdg-desktop-portal-hyprland
killall xdg-desktop-portal
$(nix eval -f '<nixpkgs>' --raw xdg-desktop-portal-hyprland)/libexec/xdg-desktop-portal-hyprland &
sleep 2
$(nix eval -f '<nixpkgs>' --raw xdg-desktop-portal)/libexec/xdg-desktop-portal &
