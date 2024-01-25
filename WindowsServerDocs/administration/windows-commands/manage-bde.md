---
title: manage-bde
description: Reference article for the manage-bde command, which turns on or turns off BitLocker, specifies unlock mechanisms, updates recovery methods, and unlocks BitLocker-protected data drives.
ms.topic: reference
ms.assetid: 276a7841-7289-48d4-a57d-bc7c300affbb
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# manage-bde

Turns on or turns off BitLocker, specifies unlock mechanisms, updates recovery methods, and unlocks BitLocker-protected data drives.

> [!NOTE]
> This command-line tool can be used in place of the **BitLocker Drive Encryption** Control Panel item.

## Syntax

```
manage-bde [-status] [–on] [–off] [–pause] [–resume] [–lock] [–unlock] [–autounlock] [–protectors] [–tpm]
[–setidentifier] [-forcerecovery] [–changepassword] [–changepin] [–changekey] [-keypackage] [–upgrade] [-wipefreespace] [{-?|/?}] [{-help|-h}]
```

### Parameters

| Parameter | Description |
| --------- |------------ |
| [manage-bde status](manage-bde-status.md) | Provides information about all drives on the computer, whether or not they are BitLocker-protected. |
| [manage-bde on](manage-bde-on.md) | Encrypts the drive and turns on BitLocker. |
| [manage-bde off](manage-bde-off.md) | Decrypts the drive and turns off BitLocker. All key protectors are removed when decryption is complete. |
| [manage-bde pause](manage-bde-pause.md) | Pauses encryption or decryption. |
| [manage-bde resume](manage-bde-resume.md) | Resumes encryption or decryption. |
| [manage-bde lock](manage-bde-lock.md) | Prevents access to BitLocker-protected data. |
| [manage-bde unlock](manage-bde-unlock.md) | Allows access to BitLocker-protected data with a recovery password or a recovery key. |
| [manage-bde autounlock](manage-bde-autounlock.md) | Manages automatic unlocking of data drives. |
| [manage-bde protectors](manage-bde-protectors.md) | Manages protection methods for the encryption key. |
| [manage-bde tpm](manage-bde-tpm.md) | Configures the computer's Trusted Platform Module (TPM). This command isn't supported on computers running Windows 8 or **win8_server_2**. To manage the TPM on these computers, use either the TPM Management MMC snap-in or the TPM Management cmdlets for Windows PowerShell. |
| [manage-bde setidentifier](manage-bde-setidentifier.md)   | Sets the drive identifier field on the drive to the value specified in the **Provide the unique identifiers for your organization** Group Policy setting. |
| [manage-bde ForceRecovery](manage-bde-forcerecovery.md) | Forces a BitLocker-protected drive into recovery mode on restart. This command deletes all TPM-related key protectors from the drive. When the computer restarts, only a recovery password or recovery key can be used to unlock the drive. |
| [manage-bde changepassword](manage-bde-changepassword.md) | Modifies the password for a data drive. |
| [manage-bde changepin](manage-bde-changepin.md) | Modifies the PIN for an operating system drive. |
| [manage-bde changekey](manage-bde-changekey.md) | Modifies the startup key for an operating system drive. |
| [manage-bde KeyPackage](manage-bde-keypackage.md) | Generates a key package for a drive. |
| [manage-bde upgrade](manage-bde-upgrade.md) | Upgrades the BitLocker version. |
| [manage-bde WipeFreeSpace](manage-bde-wipefreespace.md) | Wipes the free space on a drive. |
| -? or /? | Displays brief Help at the command prompt. |
| -help or -h | Displays complete Help at the command prompt. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Enabling BitLocker by Using the Command Line](/previous-versions/windows/it-pro/windows-7/dd894351(v=ws.10))
