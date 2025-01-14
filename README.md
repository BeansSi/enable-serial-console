### **README.md**

# Enable Serial Console Script

## Beskrivelse
Dette script konfigurerer en Ubuntu VM i Proxmox til at bruge en **serial console** via `ttyS0`. Dette gør det muligt at tilgå VM’en direkte via Proxmox-terminalen med kommandoen `qm terminal <VMID>`.

## Brugervejledning

### Trin 1: Download og kør scriptet

Du kan nemt hente og køre scriptet fra dette public repository ved at bruge følgende kommandoer:
```bash
wget https://raw.githubusercontent.com/BeansSi/enable-serial-console/main/enable_serial_console.sh
chmod +x enable_serial_console.sh
sudo ./enable_serial_console.sh
```

### Trin 2: Automatisk download og kørsel i én kommando

For at gøre det endnu nemmere kan du kombinere download og kørsel i én kommando:

```bash
bash <(wget -qO- https://raw.githubusercontent.com/BeansSi/enable-serial-console/main/enable_serial_console.sh)
```

## Bemærkninger

- Sørg for at køre scriptet som **root** eller med **sudo**, da det kræver adgang til systemkonfigurationer.
- Når scriptet er kørt, skal du genstarte VM’en for at anvende ændringerne.
  
  Genstart VM’en med:
  ```bash
  sudo reboot
  ```

## Licens
Dette script er udgivet under MIT-licensen. Du kan frit bruge, ændre og distribuere det.
```

---

Denne `README.md` kan kopieres direkte ind i dit public repository som dokumentation.

Fortæl mig, hvis du vil have yderligere ændringer! 😊
