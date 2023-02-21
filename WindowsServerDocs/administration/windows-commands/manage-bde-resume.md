---
title: manage-bde resume
description: Reference article for the manage-bde resume command, which resumes BitLocker encryption or decryption after it has been paused.
ms.topic: reference
ms.assetid: ca3cd1ca-6f2c-4190-b68f-27816635facb
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# manage-bde resume

Resumes BitLocker encryption or decryption after it has been paused.

## Syntax

```
manage-bde -resume [<drive>] [-computername <name>] [{-?|/?}] [{-help|-h}]
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

To resume BitLocker encryption on drive C, type:

```
manage-bde –resume C:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [manage-bde on command](manage-bde-on.md)

- [manage-bde off command](manage-bde-off.md)

- [manage-bde pause command](manage-bde-pause.md)

- [manage-bde command](manage-bde.md)
