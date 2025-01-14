#!/bin/bash

# Exit immediately if a command fails
set -e

LOGFILE="/var/log/enable_serial_console.log"

echo "== Starting serial console activation on ttyS0 ==" | tee -a $LOGFILE

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root or with sudo." | tee -a $LOGFILE
    exit 1
fi

# Add 'console=ttyS0' to GRUB configuration
echo "Adding 'console=ttyS0' to GRUB configuration..." | tee -a $LOGFILE
if grep -q "console=ttyS0" /etc/default/grub; then
    echo "Parameter 'console=ttyS0' is already present in GRUB configuration." | tee -a $LOGFILE
else
    sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="[^"]*/& console=ttyS0/' /etc/default/grub
    sed -i 's/^GRUB_CMDLINE_LINUX="[^"]*/& console=ttyS0/' /etc/default/grub
    echo "Addition completed." | tee -a $LOGFILE
fi

# Update GRUB
echo "Updating GRUB..." | tee -a $LOGFILE
if update-grub; then
    echo "GRUB updated successfully." | tee -a $LOGFILE
else
    echo "Error: Failed to update GRUB." | tee -a $LOGFILE
    exit 1
fi

# Create the configuration directory for serial-getty if it does not exist
echo "Creating configuration directory for serial-getty..." | tee -a $LOGFILE
mkdir -p /etc/systemd/system/serial-getty@ttyS0.service.d

# Create override.conf for serial-getty@ttyS0
echo "Creating override.conf for serial-getty@ttyS0..." | tee -a $LOGFILE
cat > /etc/systemd/system/serial-getty@ttyS0.service.d/override.conf <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --keep-baud 115200,38400,9600 ttyS0 vt220
EOF

echo "Configuration for serial-getty created." | tee -a $LOGFILE

# Reload systemd configuration
echo "Reloading systemd configuration..." | tee -a $LOGFILE
if systemctl daemon-reload; then
    echo "Systemd configuration reloaded successfully." | tee -a $LOGFILE
else
    echo "Error: Failed to reload systemd configuration." | tee -a $LOGFILE
    exit 1
fi

# Enable and start serial-getty@ttyS0
echo "Enabling and starting serial-getty@ttyS0..." | tee -a $LOGFILE
if systemctl enable --now serial-getty@ttyS0.service; then
    echo "Serial-getty@ttyS0 enabled and started successfully." | tee -a $LOGFILE
else
    echo "Error: Failed to enable and start serial-getty@ttyS0." | tee -a $LOGFILE
    exit 1
fi

echo "!! Serial console activated! Please reboot the VM to apply the changes. !!" | tee -a $LOGFILE
