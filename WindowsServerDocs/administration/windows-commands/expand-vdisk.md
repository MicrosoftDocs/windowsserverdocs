---
title: expand vdisk
description: Reference article for the expand vdisk command, which expands a virtual hard disk (VHD) to a specified size.
ms.topic: reference
ms.assetid: 3ae547b4-3813-4b86-bacd-bc273c028a2a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# expand vdisk

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Expands a virtual hard disk (VHD) to a specified size.

A VHD must be selected and detached for this operation to succeed. Use the [select vdisk command](select-vdisk.md) to select a volume and shift the focus to it.

## Syntax

```
expand vdisk maximum=<n>
```

### Parameters

 | Parameter | Description |
 |---------- | ----------- |
 | maximum=`<n>` | Specifies the new size for the VHD in megabytes (MB). |

### Examples

To expand the selected VHD to 20 GB, type:

```
expand vdisk maximum=20000
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [select vdisk command](select-vdisk.md)

- [attach vdisk command](attach-vdisk.md)

- [compact vdisk command](compact-vdisk.md)

- [detach vdisk command](detach-vdisk.md)

- [detail vdisk command](detail-vdisk.md)

- [merge vdisk command](merge-vdisk.md)

- [list command](list.md)
