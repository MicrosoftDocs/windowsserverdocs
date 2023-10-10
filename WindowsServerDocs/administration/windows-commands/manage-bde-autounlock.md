---
title: manage-bde autounlock
description: Reference article for the manage-bde autounlock command, which manages the automatic unlocking of BitLocker-protected data drives.
ms.topic: reference
ms.assetid: 063528bf-d235-4b44-887a-52a7d983e01a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# manage-bde autounlock

Manages the automatic unlocking of BitLocker-protected data drives.

## Syntax

```
manage-bde -autounlock [{-enable|-disable|-clearallkeys}] <drive> [-computername <name>] [{-?|/?}] [{-help|-h}]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -enable | Enables automatic unlocking for a data drive. |
| -disable | Disables automatic unlocking for a data drive. |
| -clearallkeys | Removes all stored external keys on the operating system drive. |
| `<drive>` | Represents a drive letter followed by a colon. |
| -computername | Specifies that manage-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command. |
| `<name>` | Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address. |
| -? or /? | Displays brief Help at the command prompt. |
| -help or -h | Displays complete Help at the command prompt. |

## Examples

To enable automatic unlocking of data drive E, type:

```
manage-bde –autounlock -enable E:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [manage-bde command](manage-bde.md)