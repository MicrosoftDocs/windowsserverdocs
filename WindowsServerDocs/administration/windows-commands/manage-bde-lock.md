---
title: manage-bde lock
description: Reference article for the manage-bde lock command, which locks a BitLocker-protected drive to prevent access to it unless the unlock key is provided.
ms.topic: reference
ms.assetid: b8858e61-3a7e-4d03-8c98-5c09853f35e8
ms.author: alalve
author: JasonGerend
manager: mtillman
ms.date: 01/17/2023
---

# manage-bde lock

Locks a BitLocker-protected drive to prevent access to it unless the unlock key is provided.

## Syntax

```
manage-bde -lock [<drive>] [-computername <name>] [{-?|/?}] [{-help|-h}]
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

To lock data drive D, type:

```
manage-bde -lock D:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [manage-bde command](manage-bde.md)
