---
title: vssadmin delete shadows
description: A description of the vssadmin delete shadows command, which deletes a specified volume's shadow copies.
ms.topic: reference
author: JasonGerend
ms.author: jgerend
ms.date: 05/18/2018
---

# vssadmin delete shadows

>Applies to: Windows Server 2022, Windows Server 2019, Windows 10, Windows 8.1, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

Deletes a specified volume's shadow copies. You can only delete shadow copies with the *client-accessible* type.

## Syntax

```
vssadmin delete shadows /for=<ForVolumeSpec> [/oldest | /all | /shadow=<ShadowID>] [/quiet]
```

### Parameters

| Parameter | Description |
|--|--|
| /for=`<ForVolumeSpec>` | Specifies which volume's shadow copy will be deleted. |
| /oldest | Deletes only the oldest shadow copy. |
| /all | Deletes all of the specified volume's shadow copies. |
| /shadow=`<ShadowID>` | Deletes the shadow copy specified by ShadowID. To get the shadow copy ID, use the [vssadmin list shadows command](vssadmin-list-shadows.md). When you enter a shadow copy ID, use the following format, where each *X* represents a hexadecimal character:<p>XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX |
| /quiet | Specifies that the command won't display messages while running. |

## Examples

To delete the oldest shadow copy of volume C, type:

```
vssadmin delete shadows /for=c: /oldest
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [vssadmin command](vssadmin.md)

- [vssadmin list shadows command](vssadmin-list-shadows.md)
