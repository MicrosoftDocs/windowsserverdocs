---
title: manage-bde setidentifier
description: Reference article for the manage-bde setidentifier command, which sets the drive identifier field on the drive to the value specified in the Provide the unique identifiers for your organization Group Policy setting.
ms.topic: reference
ms.assetid: 7092d18f-4ac9-4c73-a20f-1246ca60e75e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# manage-bde setidentifier

Sets the drive identifier field on the drive to the value specified in the **Provide the unique identifiers for your organization** Group Policy setting.

## Syntax

```
manage-bde –setidentifier <drive> [-computername <name>] [{-?|/?}] [{-help|-h}]
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

To set BitLocker drive identifier field for C, type:

```
manage-bde –setidentifier C:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [manage-bde command](manage-bde.md)

- [BitLocker Recovery Guide](/windows/security/information-protection/bitlocker/bitlocker-recovery-guide-plan)
