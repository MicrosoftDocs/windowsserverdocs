---
title: detach vdisk
description: Reference article for the detach vdisk command, which stops the selected virtual hard disk (VHD) from appearing as a local hard disk drive on the host computer.
ms.topic: reference
ms.assetid: 5f01dcb8-9237-4564-ad94-8a8dd0fd0cca
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# detach vdisk

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

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
