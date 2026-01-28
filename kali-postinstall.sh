sudo apt-get purge -y kali-desktop-core kali-desktop-xfce --allow-remove-essential

sudo apt purge -y firefox-esr

sudo apt-mark manual xfce4 xfce4-goodies lightdm network-manager network-manager-gnome

sudo apt purge -y firefox-esr

sudo apt install --reinstall -y xfce4 xfce4-goodies lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings network-manager
