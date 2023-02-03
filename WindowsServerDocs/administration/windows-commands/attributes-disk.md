---
title: attributes disk
description: Reference article for the attributes disk command, which displays, sets, or clears the attributes of a disk.
ms.topic: reference
ms.assetid: eed57071-c1c6-4394-9542-62b52a878c92
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# attributes disk

Displays, sets, or clears the attributes of a disk. When this command is used to display the current attributes of a disk, the startup disk attribute denotes the disk used to start the computer. For a dynamic mirror, it displays the disk that contains the boot plex of the boot volume.

> [!IMPORTANT]
> A disk must be selected for the **attributes disk** command to succeed. Use the **select disk** command to select a disk and shift the focus to it.

## Syntax

```
attributes disk [{set | clear}] [readonly] [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| set | Sets the specified attribute of the disk with focus. |
| clear | Clears the specified attribute of the disk with focus. |
| readonly | Specifies that the disk is read-only. |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

## Examples

To view the attributes of the selected disk, type:

```
attributes disk
```

To set the selected disk as read-only, type:

```
attributes disk set readonly
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [select disk command](select-disk.md)
