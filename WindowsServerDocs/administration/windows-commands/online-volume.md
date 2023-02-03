---
title: online volume
description: Reference article for the online volume command, which takes the offline volume to the online state.
ms.topic: reference
ms.assetid: 5da073fd-578d-4691-ad0f-605ba66e0c7e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# online volume

Takes the offline volume to the online state. This command works on volumes that have failed, are failing, or are in failed redundancy state.

> [!NOTE]
> A volume must be selected for the **online volume** command to succeed. Use the [select volume](select-volume.md) command to select a volume and shift the focus to it.

> [!IMPORTANT]
> This command will fails if it's used on a read-only disk.

## Syntax

```
online volume [noerr]
```

### Parameters

| Parameter | Description |
|--|--|
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

### Examples

To take the volume with focus online, type:

```
online volume
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
