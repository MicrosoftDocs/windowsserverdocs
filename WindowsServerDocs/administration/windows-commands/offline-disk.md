---
title: offline disk
description: Reference article for the offline disk command, which takes the online disk with focus to the offline state.
ms.topic: reference
ms.assetid: 8fb9b3c3-0b2c-4192-a2e7-f706292653e3
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# offline disk

Takes the online disk with focus to the offline state. If a dynamic disk in a disk group is taken offline, the status of the disk changes to **missing** and the group shows a disk that's offline. The missing disk is moved to the invalid group. If the dynamic disk is the last disk in the group, then the status of the disk changes to **offline**, and the empty group is removed.

> [!NOTE]
> A disk must be selected for the **offline disk** command to succeed. Use the [select disk](select-disk.md) command to select a disk and shift the focus to it.
>
> This command also works on disks in SAN online mode by changing the SAN mode to offline.

## Syntax

```
offline disk [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

### Examples

To take the disk with focus offline, type:

```
offline disk
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
