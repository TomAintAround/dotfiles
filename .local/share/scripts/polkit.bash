#!/usr/bin/env bash

$(nix eval -f '<nixpkgs>' --raw polkit_gnome)/libexec/polkit-gnome-authentication-agent-1 &
