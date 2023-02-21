---
title: manage-bde wipefreespace
description: Reference article for the manage-bde wipefreespace command, which wipes the free space on the volume removing any data fragments that may have existed in the space.
ms.topic: reference
ms.assetid: b8d83a2a-c5c8-4019-9041-23d1d6abf282
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# manage-bde wipefreespace

Wipes the free space on the volume, removing any data fragments that may have existed in the space. Running this command on a volume encrypted using the **Used Space Only** encryption method provides the same level of protection as the **Full Volume Encryption** encryption method.

## Syntax

```
manage-bde -wipefreespace|-w [<drive>] [-cancel] [-computername <name>] [{-?|/?}] [{-help|-h}]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<drive>` | Represents a drive letter followed by a colon. |
| -cancel | Cancels a wipe of free space that is in process. |
| -computername | Specifies that manage-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command. |
| `<name>` | Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address. |
| -? or /? | Displays brief Help at the command prompt. |
| -help or -h | Displays complete Help at the command prompt. |

### Examples

To wipe the free space on drive C, type either:

```
manage-bde -w C:
```

```
manage-bde -wipefreespace C:
```

To cancel the wipe of tje free space on drive C, type either:

```
manage-bde -w -cancel C:
```

```
manage-bde -wipefreespace -cancel C:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [manage-bde command](manage-bde.md)
