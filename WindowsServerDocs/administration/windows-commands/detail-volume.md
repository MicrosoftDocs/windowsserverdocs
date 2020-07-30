---
title: detail volume
description: Reference article for detail volume, which displays the disks on which the current volume resides.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 38f2bc75-2ed6-4e80-aa74-ab83133db1cd
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# detail volume

Displays the disks on which the current volume resides. Before you begin, you must select a volume for this operation to succeed. Use the [select volume](select-volume.md) command to select a volume and shift the focus to it. The volume details aren't applicable to read-only volumes, such as a DVD-ROM or CD-ROM drive.

## Syntax

```
detail volume
```

## Examples

To see all the disks in which the current volume resides, type:

```
detail volume
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [select volume](select-volume.md)

- [detail command](detail.md)