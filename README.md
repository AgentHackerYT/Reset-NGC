# Windows Hello NGC Reset Tool

Fix for Windows Hello Face (IR camera) failing after a Windows Update.

This script resets the corrupted Windows Hello container (NGC folder) so Face recognition and PIN sign-in can be reconfigured properly.

---

## Download

Download the script directly from the repository:

https://github.com/AgentHackerYT/Reset-NGC/blob/main/Reset-NGC.bat

Click **"Raw"** → then **Save As** → save the file as:

Reset-NGC.bat

Make sure the file extension is `.bat` and not `.txt`.

---

## Overview

After certain cumulative or feature updates, Windows Hello may stop working. Common symptoms include:

- “We couldn’t find a camera compatible with Windows Hello Face”
- Windows Hello Face option disappears
- Face recognition fails instantly
- PIN setup errors after update
- IR camera works in Device Manager but Hello won’t initialize

In many cases, the issue is caused by corruption in:

C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc

Resetting this folder forces Windows to rebuild the authentication container.

---

## What the Script Does

- Requests Administrator privileges
- Takes ownership of the NGC folder
- Grants administrative permissions
- Deletes the folder
- Prompts for reboot

After reboot, Windows recreates the container and you can set up PIN and Face again.

---

## Warning

- This removes your Windows Hello PIN.
- This removes biometric enrollment.
- You must set up sign-in again after reboot.
- Run only as Administrator.

This does NOT fix:
- Missing or broken IR camera drivers
- Disabled camera in BIOS
- TPM hardware failure
- Physically damaged hardware

If the camera is missing in Device Manager, fix the driver first.

---

## Usage

1. Download `Reset-NGC.bat`
2. Right-click → Run as Administrator
3. Accept UAC prompt
4. Let the script finish
5. Reboot when prompted
6. Go to Settings → Accounts → Sign-in options
7. Set up PIN
8. Re-enable Face recognition

---

## When to Use This

Use this tool if:

- Windows Hello stopped working immediately after a Windows Update
- IR camera is still detected in Device Manager
- Windows Biometric Service is running but Hello fails to initialize
- PIN setup throws errors after update

---

## Technical Notes

Windows Hello stores cryptographic keys and biometric trust data inside the NGC folder.

After some updates, the trust relationship between:
- TPM
- Windows Hello
- Biometric services
- Camera drivers

can break.

Deleting the folder forces Windows to regenerate the authentication container and rebind it correctly.

---

## Transparency

The script only uses built-in Windows commands:

- takeown
- icacls
- rd
- shutdown

No registry edits.
No external downloads.
No network activity.

Review the script before running it.

---

### Optional Safety Scan

For transparency, we’ve submitted the script to VirusTotal:

https://www.virustotal.com/gui/file/c303a80f761be4d652fb3e977e4454181511370e0a23218a90e625713d43556e

VirusTotal aggregates results from multiple antivirus engines. A clean report indicates no detections across those engines at the time of scanning.  
Users are encouraged to review scripts before running them, as a best practice.

---

## License

MIT 

---

## Contributing

Pull requests and improvements welcome.
PowerShell version, logging support, and enterprise enhancements are encouraged.
