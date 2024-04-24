---
title: delete volume
description: Reference article for the delete volume command, which deletes the selected volume.
ms.topic: reference
ms.assetid: f625933d-0f47-409e-93b2-a3e234049a5d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# delete volume

Deletes the selected volume. Before you begin, you must select a volume for this operation to succeed. Use the [select volume](select-volume.md) command to select a volume and shift the focus to it.

> [!IMPORTANT]
> You can't delete the system volume, boot volume, or any volume that contains the active paging file or crash dump (memory dump).

## Syntax

```
delete volume [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

## Examples

To delete the volume with focus, type:

```
delete volume
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [select volume](select-volume.md)

- [delete command](delete.md)