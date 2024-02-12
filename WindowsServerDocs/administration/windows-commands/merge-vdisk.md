---
title: merge vdisk
description: Reference article for the merge vdisk command, which merges a differencing virtual hard disk (VHD) with its corresponding parent VHD.
ms.topic: reference
ms.assetid: 5865bb08-89a3-406c-8328-0ef8868d03e8
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# merge vdisk

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Merges a differencing virtual hard disk (VHD) with its corresponding parent VHD. The parent VHD will be modified to include the modifications from the differencing VHD. This command modifies the parent VHD. As a result, other differencing VHDs that are dependent on the parent will no longer be valid.

> [!IMPORTANT]
> You must choose and detach a VHD for this operation to succeed. Use the **select vdisk** command to select a VHD and shift the focus to it.

## Syntax

```
merge vdisk depth=<n>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| depth=`<n>` | Indicates the number of parent VHD files to merge together. For example, `depth=1` indicates that the differencing VHD will be merged with one level of the differencing chain. |

### Examples

To merge a differencing VHD with its parent VHD, type:

```
merge vdisk depth=1
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [attach vdisk command](attach-vdisk.md)

- [compact vdisk command](compact-vdisk.md)

- [detail vdisk command](detail-vdisk.md)

- [detach vdisk command](detach-vdisk.md)

- [expand vdisk command](expand-vdisk.md)

- [select vdisk command](select-vdisk.md)

- [list command](list.md)
