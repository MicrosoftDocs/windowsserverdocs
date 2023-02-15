---
title: manage-bde status
description: Reference article for the manage-bde status command, which provides information about all drives on the computer, regardless whether they are BitLocker protected.
ms.topic: reference
ms.assetid: 1444a360-fabf-4dd3-b67f-188e6ea3fa5b
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# manage-bde status

Provides information about all drives on the computer; whether or not they are BitLocker-protected, including:

- Size

- BitLocker version

- Conversion status

- Percentage encrypted

- Encryption method

- Protection status

- Lock status

- Identification field

- Key protectors

## Syntax

```
manage-bde -status [<drive>] [-protectionaserrorlevel] [-computername <name>] [{-?|/?}] [{-help|-h}]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<drive>` | Represents a drive letter followed by a colon. |
| -protectionaserrorlevel | Causes the manage-bde command-line tool to send the return code of **0** if the volume is protected and **1** if the volume is unprotected; most commonly used for batch scripts to determine if a drive is BitLocker-protected. You can also use **-p** as an abbreviated version of this command. |
| -computername | Specifies that manage-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command. |
| `<name>` | Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address. |
| -? or /? | Displays brief Help at the command prompt. |
| -help or -h | Displays complete Help at the command prompt. |

### Examples

To display the status of drive C, type:

```
manage-bde –status C:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [manage-bde command](manage-bde.md)
