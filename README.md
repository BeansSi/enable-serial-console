### **README.md**

```markdown
# Enable Serial Console Script

## Beskrivelse
Dette script konfigurerer en Ubuntu VM i Proxmox til at bruge en **serial console** via `ttyS0`, hvilket gør det muligt at tilgå VM’en via Proxmox-terminalen med kommandoen `qm terminal <VMID>`.

## Brugervejledning

### Trin 1: Download og kør scriptet

Da dette repository er privat, skal du bruge en **Personal Access Token (PAT)** til at hente scriptet. Erstat `<your-token>` med din token i nedenstående kommando:

```bash
wget --header="Authorization: token <your-token>" https://raw.githubusercontent.com/BeansSi/enable-serial-console/main/enable_serial_console.sh
chmod +x enable_serial_console.sh
sudo ./enable_serial_console.sh
```

Eksempel med token:
```bash
wget --header="Authorization: token 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" https://raw.githubusercontent.com/BeansSi/enable-serial-console/main/enable_serial_console.sh
chmod +x enable_serial_console.sh
sudo ./enable_serial_console.sh
```

### Trin 2: Automatisk download og kørsel

Du kan kombinere download og kørsel i én kommando:

```bash
bash <(wget -qO- --header="Authorization: token <your-token>" https://raw.githubusercontent.com/BeansSi/enable-serial-console/main/enable_serial_console.sh)
```

Eksempel med token:
```bash
bash <(wget -qO- --header="Authorization: token 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" https://raw.githubusercontent.com/BeansSi/enable-serial-console/main/enable_serial_console.sh)
```

## Bemærkninger
- Sørg for at holde din **Personal Access Token** privat, da den giver adgang til dine repositories.
- Hvis du ved en fejl offentliggør din token, kan du slette den og oprette en ny via [GitHub tokens-siden](https://github.com/settings/tokens).

## Licens
Dette script er udgivet under MIT-licensen. Du kan frit bruge, ændre og distribuere det.
```

---

### **Vigtig sikkerhedsadvarsel**
Jeg har brugt en **eksempel-token** i denne README. Du bør oprette en ny token ved at følge instruktionerne i guiden og erstatte tokenet i kommandoerne.

Hvis du vil have flere detaljer eller hjælp til at sætte dette op, så sig endelig til! 😊
