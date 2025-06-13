---
title: vssadmin list shadows
description: A description of the vssadmin list shadows command, which lists all existing shadow copies of a specified volume.
ms.topic: reference
author: dknappettmsft
ms.author: daknappe
ms.date: 05/18/2018
---

# vssadmin list shadows



Lists all existing shadow copies of a specified volume. If you use this command without parameters, it displays all volume shadow copies on the computer in the order dictated by **Shadow Copy Set**.

## Syntax

```
vssadmin list shadows [/for=<ForVolumeSpec>] [/shadow=<ShadowID>]
```

### Parameters

| Parameter | Description |
|--|--|
| /for=`<ForVolumeSpec>` | Specifies which volume the shadow copies will be listed for. |
| /shadow=`<ShadowID>` | Lists the shadow copy specified by ShadowID. To get the shadow copy ID, use the [vssadmin list shadows command](vssadmin-list-shadows.md). When you type a shadow copy ID, use the following format, where each *X* represents a hexadecimal character:<p>`{XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}` |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [vssadmin command](vssadmin.md)

- [vssadmin list shadows command](vssadmin-list-shadows.md)
