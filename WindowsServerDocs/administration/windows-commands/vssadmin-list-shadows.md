---
title: vssadmin list shadows
description: A description of the vssadmin list shadows command, which lists all existing shadow copies of a specified volume.
ms.topic: reference
author: JasonGerend
ms.author: jgerend
ms.date: 05/18/2018
---

# vssadmin list shadows

>Applies to: Windows Server 2022, Windows Server 2019, Windows 10, Windows 8.1, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

Lists all existing shadow copies of a specified volume. If you use this command without parameters, it displays all volume shadow copies on the computer in the order dictated by **Shadow Copy Set**.

## Syntax

```
vssadmin list shadows [/for=<ForVolumeSpec>] [/shadow=<ShadowID>]
```

### Parameters

| Parameter | Description |
|--|--|
| /for=`<ForVolumeSpec>` | Specifies which volume the shadow copies will be listed for. |
| /shadow=`<ShadowID>` | Lists the shadow copy specified by ShadowID. To get the shadow copy ID, use the [vssadmin list shadows command](vssadmin-list-shadows.md). When you type a shadow copy ID, use the following format, where each *X* represents a hexadecimal character:<p>XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [vssadmin command](vssadmin.md)

- [vssadmin list shadows command](vssadmin-list-shadows.md)
