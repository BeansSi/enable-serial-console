#!/bin/bash

# Sæt scriptet til at stoppe ved fejl
set -e

LOGFILE="/var/log/enable_serial_console.log"

echo "== Start aktivering af serial console på ttyS0 ==" | tee -a $LOGFILE

# Tjek om scriptet køres med sudo/root
if [ "$EUID" -ne 0 ]; then
    echo "Fejl: Dette script skal køres som root eller med sudo." | tee -a $LOGFILE
    exit 1
fi

# Tilføj 'console=ttyS0' til GRUB-konfigurationen
echo "Tilføjer 'console=ttyS0' til GRUB-konfigurationen..." | tee -a $LOGFILE
if grep -q "console=ttyS0" /etc/default/grub; then
    echo "Parameter 'console=ttyS0' findes allerede i GRUB-konfigurationen." | tee -a $LOGFILE
else
    sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="[^"]*/& console=ttyS0/' /etc/default/grub
    sed -i 's/^GRUB_CMDLINE_LINUX="[^"]*/& console=ttyS0/' /etc/default/grub
    echo "Tilføjelse fuldført." | tee -a $LOGFILE
fi

# Opdater GRUB-konfigurationen
echo "Opdaterer GRUB..." | tee -a $LOGFILE
if update-grub; then
    echo "GRUB opdateret korrekt." | tee -a $LOGFILE
else
    echo "Fejl: Kunne ikke opdatere GRUB." | tee -a $LOGFILE
    exit 1
fi

# Opret konfigurationsmappen for serial-getty, hvis den ikke findes
echo "Opretter konfigurationsmappe for serial-getty..." | tee -a $LOGFILE
mkdir -p /etc/systemd/system/serial-getty@ttyS0.service.d

# Opret override.conf for serial-getty@ttyS0
echo "Opretter override.conf for serial-getty@ttyS0..." | tee -a $LOGFILE
cat > /etc/systemd/system/serial-getty@ttyS0.service.d/override.conf <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --keep-baud 115200,38400,9600 ttyS0 vt220
EOF

echo "Konfiguration af serial-getty oprettet." | tee -a $LOGFILE

# Genindlæs systemd-konfigurationen
echo "Genindlæser systemd-konfiguration..." | tee -a $LOGFILE
if systemctl daemon-reload; then
    echo "Systemd-konfiguration genindlæst korrekt." | tee -a $LOGFILE
else
    echo "Fejl: Kunne ikke genindlæse systemd-konfiguration." | tee -a $LOGFILE
    exit 1
fi

# Aktiver og start serial-getty@ttyS0
echo "Aktiverer og starter serial-getty@ttyS0..." | tee -a $LOGFILE
if systemctl enable --now serial-getty@ttyS0.service; then
    echo "Serial-getty@ttyS0 aktiveret og startet korrekt." | tee -a $LOGFILE
else
    echo "Fejl: Kunne ikke aktivere og starte serial-getty@ttyS0." | tee -a $LOGFILE
    exit 1
fi

echo "== Serial console aktiveret! Genstart venligst VM'en for at anvende ændringerne. ==" | tee -a $LOGFILE
