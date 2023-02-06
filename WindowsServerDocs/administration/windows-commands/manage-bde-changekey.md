---
title: manage-bde changekey
description: Reference article for the manage-bde changekey command, which modifies the startup key for an operating system drive.
ms.topic: reference
ms.assetid: 69463db9-7e03-47ff-b233-a95d5055725f
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# manage-bde changekey

Modifies the startup key for an operating system drive.

## Syntax

```
manage-bde -changekey [<drive>] [<pathtoexternalkeydirectory>] [-computername <name>] [{-?|/?}] [{-help|-h}]
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

To create a new startup key on drive E, to use with BitLocker encryption on drive C, type:

```
manage-bde -changekey C: E:\
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [manage-bde command](manage-bde.md)
