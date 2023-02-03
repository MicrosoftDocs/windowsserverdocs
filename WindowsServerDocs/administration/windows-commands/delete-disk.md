---
title: delete disk
description: Reference article for the delete disk command, which deletes a missing dynamic disk from the list of disks.
ms.topic: reference
ms.assetid: 44079900-e4ed-49d0-81e4-d652c38cd636
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# delete disk

Deletes a missing dynamic disk from the list of disks.

> [!NOTE]
> For detailed instructions about how to use this command, see [Remove a Missing Dynamic Disk](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc753029(v=ws.11)).

## Syntax

```
delete disk [noerr] [override]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |
| override | Enables DiskPart to delete all simple volumes on the disk. If the disk contains half of a mirrored volume, the half of the mirror on the disk is deleted. The delete disk override command fails if the disk is a member of a RAID-5 volume. |

## Examples

To delete a missing dynamic disk from the list of disks, type:

```
delete disk
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [delete command](delete.md)
