---
title: manage-bde unlock
description: Reference article for the manage-bde unlock command, which unlocks a BitLocker-protected drive by using a recovery password or a recovery key.
ms.topic: reference
ms.assetid: 7852bf7d-9102-40be-adcb-71e8f4dfde72
ms.author: alalve
author: JasonGerend
manager: mtillman
ms.date: 01/17/2023
---

# manage-bde unlock

Unlocks a BitLocker-protected drive by using a recovery password or a recovery key.

## Syntax

```
manage-bde -unlock {-recoverypassword -password | -recoverykey <pathtoexternalkeyfile>} <drive> [-certificate {-cf pathtocertificatefile | -ct certificatethumbprint} {-pin}] [-password] [-computername <name>] [{-?|/?}] [{-help|-h}]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -recoverypassword | Specifies that a recovery password will be used to unlock the drive. You can also use **-rp** as an abbreviated version of this command. This is the recovery key that's saved to a text file and must be written exactly as shown including dashes. |
| -password | Represents the recovery password that can be used to unlock the drive that either you or your administrator has set. |
| -recoverykey | Specifies that an external recovery key file will be used to unlock the drive. You can also use **-rk** as an abbreviated version of this command. This method searches for the **.bek** recovery key file that is saved to a USB drive. |
| `<pathtoexternalkeyfile>` | Represents the external recovery key file that can be used to unlock the drive. |
| `<drive>` | Represents a drive letter followed by a colon. |
| -certificate | The local user certificate for a BitLocker certificate to unlock the volume is located in the local user certificate store. You can also use **-cert** as an abbreviated version of this command. |
| -cf `<pathtocertificatefile>` | Path to the certificate file. |
| -ct `<certificatethumbprint>` | Certificate thumbprint which may optionally include the PIN (-pin). |
| -password | Presents a prompt for the password to unlock the volume. You can also use **-pw** as an abbreviated version of this command. |
| -computername | Specifies that manage-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command. |
| `<name>` | Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address. |
| -? or /? | Displays brief Help at the command prompt. |
| -help or -h | Displays complete Help at the command prompt. |

### Examples

To unlock drive E with a password, type:

```cmd
manage-bde -unlock E: -password
```

To unlock drive E with a recovery password, type:

```cmd
manage-bde -unlock E: -recoverypassword xxxxxx-xxxxxx-xxxxxx-xxxxxx-xxxxxx-xxxxxx-xxxxxx-xxxxxx
```

To unlock drive E with a recovery key file that's been saved to a backup folder on another drive, type:

```cmd
manage-bde -unlock E: -recoverykey F:\Backupkeys\recoverykey.bek
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [manage-bde command](manage-bde.md)
