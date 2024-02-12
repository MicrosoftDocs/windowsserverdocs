---
title: manage-bde -pause
description: Reference article for the manage-bde -pause command, which pauses BitLocker encryption or decryption.
ms.topic: reference
ms.assetid: efda0e08-b9ff-4e71-83d8-bb666b3032bd
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# manage-bde -pause

Pauses BitLocker encryption or decryption.

## Syntax

```
manage-bde -pause [<volume>] [-computername <name>] [{-?|/?}] [{-help|-h}]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<volume>` | Specifies a drive letter followed by a colon, a volume GUID path, or a mounted volume. |
| -computername | Specifies that manage-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command. |
| `<name>` | Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address. |
| -? or /? | Displays brief Help at the command prompt. |
| -help or -h | Displays complete Help at the command prompt. |

### Examples

To pause BitLocker encryption on drive C, type:

```Output
manage-bde -pause C:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [manage-bde on command](manage-bde-on.md)

- [manage-bde off command](manage-bde-off.md)

- [manage-bde resume command](manage-bde-resume.md)

- [manage-bde command](manage-bde.md)
