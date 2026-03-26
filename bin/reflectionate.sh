#!/bin/sh

# Just my default reflector command.
reflector --sort rate -p "https" | sudo tee /etc/pacman.d/mirrorlist
