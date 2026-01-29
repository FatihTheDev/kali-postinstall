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
  echo "Opening ports for LocalSend"
  sudo firewall-cmd --permanent --add-port=53317/tcp
  sudo firewall-cmd --permanent --add-port=53317/udp
  sudo firewall-cmd --reload

  echo "Enabling mac address spoof randomization with macchanger"
  sudo tee /etc/NetworkManager/dispatcher.d/01-macchanger > /dev/null <<'EOF'
#!/bin/sh

INTERFACE="$1"
ACTION="$2"

if [ "$ACTION" = "up" ]; then
    case "$INTERFACE" in
        en*|et*)
            macchanger -e "$INTERFACE"
            ;;
    esac
fi
EOF
sudo chmod +x /etc/NetworkManager/dispatcher.d/01-macchanger

echo "Installing redshift for night light and setting it to always be 1600K"
sudo apt install -y redshift redshift-gtk

# Kill any existing redshift instances
pkill redshift

# Ensure config directory and file exist
mkdir -p ~/.config
cat > ~/.config/redshift.conf << EOF
[redshift]
temp-day=1600
temp-night=1600
transition=0
adjustment-method=randr
location-provider=manual

[manual]
lat=0
lon=0
EOF

# Create autostart directory if it doesn't exist
mkdir -p ~/.config/autostart

# Create desktop entry for redshift
cat > ~/.config/autostart/redshift.desktop << EOF
[Desktop Entry]
Name=Redshift
Comment=Adjust screen color temperature
Exec=redshift
Type=Application
Terminal=false
Hidden=false
EOF
