---
title: manage-bde forcerecovery
description: Reference article for the manage-bde forcerecovery command, which forces a BitLocker-protected drive into recovery mode on restart.
ms.topic: reference
ms.assetid: eecae37c-c9a3-46c5-b615-a0ace1f1d778
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# manage-bde forcerecovery

Forces a BitLocker-protected drive into recovery mode on restart. This command deletes all Trusted Platform Module (TPM)-related key protectors from the drive. When the computer restarts, only a recovery password or recovery key can be used to unlock the drive.

## Syntax

```
manage-bde –forcerecovery <drive> [-computername <name>] [{-?|/?}] [{-help|-h}]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<drive>` | Represents a drive letter followed by a colon. |
| -computername | Specifies that manage-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command. |
| `<name>` | Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address. |
| -? or /? | Displays brief Help at the command prompt. |
| -help or -h | Displays complete Help at the command prompt. |

### Examples

To cause BitLocker to start in recovery mode on drive C, type:

```
manage-bde –forcerecovery C:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [manage-bde command](manage-bde.md)
