# 🌐 Cloudflare WARP GUI (Bash + Zenity)

> This script was born out of personal experience and the desire for a simpler, more direct way to control Cloudflare WARP features on Linux. Dealing with complex command-line arguments and frequent pkexec prompts became tedious. This graphical interface aims to wrap the power of warp-cli into a user-friendly, single-click solution, making essential functions like mode switching and connection status immediate and effortless.

This Bash script provides a simple and intuitive **Graphical User Interface (GUI)** for managing the Cloudflare WARP service on Linux systems, utilizing Zenity for dialog windows.

## ✨ Key Features

  * **Multilingual Support:** Select your preferred language (English or Indonesian) upon launching the script.
  * **Mode Management:** Easily switch between **Family Mode Full**, **Malware Mode**, or **Off**.
  * **Connection Control:** Quickly Connect or Disconnect the WARP service.
  * **Service Management:** Start and Stop the underlying `warp-svc` system service.
  * **Status Check:** View the current WARP connection status.


## 🛠️ Prerequisites

Ensure you have the following components installed on your Linux system before running the script:

1.  **Cloudflare WARP CLI:** The official Linux client must be installed and the `warp-cli` command must be available in your system's PATH.
2.  **Zenity:** The tool used to create the GUI dialog boxes.
      * **Debian/Ubuntu:** `sudo apt install zenity`
3.  **pkexec:** Used to safely execute administrative commands (`warp-cli` and `systemctl`) by prompting the user for their password.

## 🚀 How to Use

Follow these steps to download and run the updated script:

### 1\. Download the Script

Save the code above into a file named, for example, `warp-gui-zenity.sh`.

### 2\. Grant Execution Permissions

Open your terminal and make the file executable:

```bash
chmod +x warp-gui-zenity.sh
```

### 3\. Run the Script

You have two ways to execute the script:

  * **A. Via Terminal (Recommended for Debugging):**
    ```bash
    ./warp-gui-zenity.sh
    ```
  * **B. Via Desktop Double-Click:**
    1.  Navigate to the location of the `warp-gui-zenity.sh` file in your file manager (e.g., Nautilus, Dolphin, Thunar).
    2.  **Double-click** the file.
    3.  A dialog box should appear asking what you want to do. Choose **"Run"** or **"Execute"**. *(Note: This behavior may vary slightly depending on your specific Linux Desktop Environment, such as GNOME, KDE, XFCE, etc.)*

### 4\. Select Language

The first dialog box will prompt you to **select your language** (English or Indonesian) before the Main Menu appears.

### 5\. Navigate the Menu

Use the **Main Menu** to control WARP:

| Menu Option | Function | Important Notes |
| :--- | :--- | :--- |
| **Start Service (warp-svc)** | Starts the background WARP service. **Required** before connecting WARP. | Requires `pkexec` (password prompt). |
| **Stop Service (warp-svc)** | Stops the background WARP service. | Requires `pkexec` (password prompt). |
| **Set Mode (Family, Malware, Off)** | Opens a submenu to set the filtering mode. | Automatically connects WARP after setting the mode. |
| **Connect WARP** | Connects to the WARP network. | Service must be running. |
| **Disconnect WARP** | Disconnects the WARP connection. | --- |
| **Status** | Shows the current WARP connection status. | If the result is empty, ensure the service is running and the client is registered (`warp-cli register`). |
| **Exit** | Closes the GUI and exits the script. | --- |

**Important:** Any operation requiring root privileges (like starting the service or connecting WARP) will trigger a password prompt managed by `pkexec`.

## 📸 Screenshots

| Language Selection | Main Menu | Menu Mode |
| :---: | :---: | :---: |
| ![Menu Language](https://i.imgur.com/UnvTrxn.png) | ![Main Menu](https://i.imgur.com/xEcarsG.png) | ![Menu Mode](https://i.imgur.com/9HFI6RA.png) |

## 🤝 Support and Contributions

If you find this project useful, feel free to star the repo. Your support helps maintain and develop new features!

[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/sponsors/ruddypranata)&nbsp;&nbsp;&nbsp;[![Support Me on Ko-fi](https://img.shields.io/badge/Support%20Me-Ko--fi-29ABAE?style=for-the-badge&logo=kofi&logoColor=white&logoSize=auto)](https://ko-fi.com/L4L01O3OW1)&nbsp;&nbsp;&nbsp;[![Dukung via Saweria](https://img.shields.io/badge/Donasi%20Rupiah-Saweria-E05D44?style=for-the-badge&logo=cashapp&logoColor=white&logoSize=auto)](https://saweria.co/ruddypranata)

Jika Anda berada di Indonesia dan ingin mendukung melalui QRIS / GoPay / OVO / DANA / Link Aja, silakan gunakan opsi Saweria di atas.