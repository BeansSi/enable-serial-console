#!/bin/bash

echo "Aktiverer serial console på ttyS0..."

# Tilføj 'console=ttyS0' til GRUB-konfigurationen
sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="[^"]*/& console=ttyS0/' /etc/default/grub
sudo sed -i 's/^GRUB_CMDLINE_LINUX="[^"]*/& console=ttyS0/' /etc/default/grub

# Opdater GRUB-konfigurationen
echo "Opdaterer GRUB..."
sudo update-grub

# Opret konfigurationsmappen for serial-getty, hvis den ikke findes
sudo mkdir -p /etc/systemd/system/serial-getty@ttyS0.service.d

# Opret override.conf for serial-getty@ttyS0
echo "Opretter /etc/systemd/system/serial-getty@ttyS0.service.d/override.conf..."
sudo bash -c 'cat > /etc/systemd/system/serial-getty@ttyS0.service.d/override.conf <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --keep-baud 115200,38400,9600 ttyS0 vt220
EOF'

# Genindlæs systemd-konfigurationen
echo "Genindlæser systemd-konfiguration..."
sudo systemctl daemon-reload

# Aktiver og start serial-getty@ttyS0
echo "Aktiverer og starter serial-getty@ttyS0..."
sudo systemctl enable --now serial-getty@ttyS0.service

echo "Serial console aktiveret! Genstart venligst VM'en for at anvende ændringerne."
