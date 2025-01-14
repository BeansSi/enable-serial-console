# Enable Serial Console Script

## Description
This script configures an Ubuntu VM running in Proxmox to use a **serial console** via `ttyS0`. This setup allows you to use the following Proxmox commands directly from the terminal:

- `qm list`: Lists all virtual machines running on the Proxmox server.
- `qm terminal <VMID>`: Opens a terminal session directly to the VM using its serial console.

## Prerequisites

Before running the script, you need to ensure that the VM has a **serial port** added in Proxmox:

1. Open the Proxmox web interface.
2. Select your VM from the left-hand menu.
3. Go to the **Hardware** tab.
4. Click **Add > Serial Port**.
5. Set **Port** to `0` and click **Add**.
6. Restart the VM.

Once the serial port has been added, proceed with the steps below to configure the VM for serial console access.

## Usage

### Step 1: Download and run the script

#### **Option 1: Without sudo**

```bash
wget https://raw.githubusercontent.com/BeansSi/test/main/enable_serial_console.sh
chmod +x enable_serial_console.sh
sudo ./enable_serial_console.sh
```

#### **Option 2: Using sudo for download**

```bash
sudo wget https://raw.githubusercontent.com/BeansSi/test/main/enable_serial_console.sh
sudo chmod +x enable_serial_console.sh
sudo ./enable_serial_console.sh
```

In some environments, you may need to use `sudo` when downloading the script if you do not have write permissions in the current directory.

## Notes

- Ensure that you run the script as **root** or with **sudo**, as it requires access to system configurations.
- Once the script has run, you need to restart the VM for the changes to take effect.

  You can restart the VM using:
  ```bash
  sudo reboot
  ```

## Purpose

This script is useful for enabling direct terminal access to a VM in Proxmox using commands like `qm list` and `qm terminal <VMID>`. It simplifies management of virtual machines without needing to rely on the Proxmox web interface.

## License
This script is released under the MIT license. You are free to use, modify, and distribute it.
