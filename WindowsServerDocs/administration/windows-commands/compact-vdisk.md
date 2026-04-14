---
title: compact vdisk
description: Reference article for the compact vdisk command, which reduces the physical size of a dynamically expanding virtual hard disk (VHD) file.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---
# compact vdisk



Reduces the physical size of a dynamically expanding virtual hard disk (VHD) file. This parameter is useful because dynamically expanding VHDs increase in size as you add files, but they do not automatically reduce in size when you delete files.

## Syntax

```
compact vdisk
```

### Remarks

- A dynamically expanding VHD must be selected for this operation to succeed. Use the [select vdisk command](select-vdisk.md) to select a VHD and shift the focus to it.

- You can only use compact dynamically expanding VHDs that are detached or attached as read-only.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [attach vdisk command](attach-vdisk.md)

- [detail vdisk command](detail-vdisk.md)

- [Detach vdisk command](detach-vdisk.md)

- [expand vdisk command](expand-vdisk.md)

- [Merge vdisk command](merge-vdisk.md)

- [select vdisk command](select-vdisk.md)

- [list command](list.md)
