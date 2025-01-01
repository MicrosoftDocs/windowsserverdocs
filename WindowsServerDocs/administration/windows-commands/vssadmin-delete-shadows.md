---
title: vssadmin delete shadows
description: A description of the vssadmin delete shadows command, which deletes a specified volume's shadow copies.
ms.topic: reference
author: robinharwood
ms.author: roharwoo
ms.date: 05/18/2018
---

# vssadmin delete shadows



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
