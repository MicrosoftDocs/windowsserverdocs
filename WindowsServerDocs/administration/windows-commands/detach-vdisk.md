---
title: detach vdisk
description: Reference article for the detach vdisk command, which stops the selected virtual hard disk (VHD) from appearing as a local hard disk drive on the host computer.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# detach vdisk



Stops the selected virtual hard disk (VHD) from appearing as a local hard disk drive on the host computer. When a VHD is detached, you can copy it to other locations. Before you begin, you must select a VHD for this operation to succeed. Use the [select vdisk](select-vdisk.md) command to select a VHD and shift the focus to it.


## Syntax

```
detach vdisk [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

## Examples

To detach the selected VHD, type:

```
detach vdisk
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [attach vdisk command](attach-vdisk.md)

- [compact vdisk command](compact-vdisk.md)

- [detail vdisk command](detail-vdisk.md)

- [expand vdisk command](expand-vdisk.md)

- [Merge vdisk command](merge-vdisk.md)

- [select vdisk command](select-vdisk.md)

- [list command](list.md)
