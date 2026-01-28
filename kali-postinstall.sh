#!/bin/bash
set -euo pipefail

echo "Step 1: Purge Kali desktop metas and Firefox ESR"
sudo apt-get purge -y --allow-remove-essential \
  kali-desktop-xfce \
  kali-desktop-core

sudo apt-get purge -y firefox-esr

echo "Step 2: Reinstall XFCE, LightDM, NetworkManager, Kali customizations"
sudo apt install -y \
  xfce4 \
  xfce4-goodies \
  lightdm \
  lightdm-gtk-greeter \
  lightdm-gtk-greeter-settings \
  network-manager \
  network-manager-gnome \
  kali-defaults \
  kali-defaults-desktop \
  kali
  kali-root-login \
  kali-menu \
  kali-undercover

echo "Step 3: Mark all essential desktop packages as manual (prevent autoremove)"
sudo apt-mark manual \
  xfce4 \
  xfce4-goodies \
  lightdm \
  lightdm-gtk-greeter \
  network-manager \
  network-manager-gnome \
  kali-defaults \
  kali-defaults-desktop \
  kali-root-login \
  kali-menu \
  kali-undercover

  echo "Installing Brave Browser"
  curl -fsS https://dl.brave.com/install.sh | sh

  echo "Installing FirewallD and starting the service"
  sudo apt install -y firewalld
  systemctl enable --now firewalld
