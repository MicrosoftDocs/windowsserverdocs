---
title: simulate restore
description: Reference article for the simulate restore command, which tests whether writer involvement in restore sessions will be successful on the computer without issuing PreRestore or PostRestore events to writers.
ms.topic: reference
ms.assetid: d883d94c-3cb1-4848-9d74-1b4378044b31
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# Simulate restore

Tests whether writer involvement in restore sessions will be successful on the computer without issuing **PreRestore** or **PostRestore** events to writers.

> [!NOTE]
> A DiskShadow metadata file must be selected for the **simulate restore** command to succeed. Use the [load metadata command](load-metadata.md) to load the selected writers and components for the restore.

## Syntax

```
simulate restore
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [load metadata command](load-metadata.md)
