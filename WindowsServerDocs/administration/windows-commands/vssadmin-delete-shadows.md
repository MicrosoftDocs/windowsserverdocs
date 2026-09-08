---
title: vssadmin delete shadows
description: A description of the vssadmin delete shadows command, which deletes a specified volume's shadow copies.
ms.topic: reference
author: robinharwood
ms.author: roharwoo
ms.date: 05/18/2018
ai-usage: ai-assisted
---

# vssadmin delete shadows



Deletes a specified volume's shadow copies. You can only delete shadow copies with the *client-accessible* type.

> [!NOTE]
> If you encounter the error "Error: Snapshots were found, but they were outside of your allowed context," the shadow copies are not client-accessible and cannot be deleted with `vssadmin`. Use the [diskshadow](diskshadow.md) command instead to manage and delete those shadow copies.

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

> [!CAUTION]
> Deleting a shadow copy is permanent. You can't recover a deleted shadow copy, and you lose any previous versions or restore points that depend on it. Target only the volume or shadow copy you intend to remove, and confirm the shadow copy IDs with [vssadmin list shadows](vssadmin-list-shadows.md) before you delete anything. This command deletes only shadow copies that have the *client-accessible* type.

To delete the oldest shadow copy of volume C, type:

```
vssadmin delete shadows /for=c: /oldest
```

To delete all client-accessible shadow copies of volume D, type:

```
vssadmin delete shadows /for=d: /all
```

To delete a single client-accessible shadow copy by its ID, first run [vssadmin list shadows](vssadmin-list-shadows.md) to find the shadow copy ID. Then run the following command, replacing `c:` with the volume that hosts the shadow copy and `<ShadowID>` with the ID you want to delete. Enter the ID in the format *XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX*, where each *X* is a hexadecimal character:

```
vssadmin delete shadows /for=c: /shadow=<ShadowID>
```

To delete all client-accessible shadow copies of volume D without showing progress messages, add the `/quiet` parameter:

```
vssadmin delete shadows /for=d: /all /quiet
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [vssadmin command](vssadmin.md)

- [vssadmin list shadows command](vssadmin-list-shadows.md)

- [diskshadow command](diskshadow.md)
