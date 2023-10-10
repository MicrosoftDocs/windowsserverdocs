---
title: manage-bde changepassword
description: Reference article for the manage-bde changepassword command, which modifies the password for a data drive.
ms.topic: reference
ms.assetid: b174e152-8442-4fba-8b33-56a81ff4f547
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# manage-bde changepassword

Modifies the password for a data drive. The user is prompted for a new password.

## Syntax

```
manage-bde -changepassword [<drive>] [-computername <name>] [{-?|/?}] [{-help|-h}]
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

To change the password used to unlock BitLocker on data drive D, type:

```
manage-bde –changepassword D:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [manage-bde command](manage-bde.md)
