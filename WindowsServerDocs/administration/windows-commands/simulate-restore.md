---
title: simulate restore
description: Reference article for simulate restore, which tests writer involvement in restore sessions on the computer without issuing PreRestore or PostRestore events to writers.
ms.topic: reference
ms.assetid: d883d94c-3cb1-4848-9d74-1b4378044b31
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---

# Simulate restore

Tests writer involvement in restore sessions on the computer without issuing **PreRestore** or **PostRestore** events to writers.

## Syntax

```
simulate restore
```

## Remarks

-   **Simulate restore** is used to test whether or not restore with writers can be successful.
-   Before you can use **simulate restore**, you must load a DiskShadow metadata file by using the **load metadata** command. This loads the selected writers and components for the restore.

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)