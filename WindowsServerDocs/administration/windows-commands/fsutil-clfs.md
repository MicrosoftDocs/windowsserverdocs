---
title: fsutil clfs
description: Reference article for the fsutil clfs command.
ms.author: roharwoo
author: robinharwood
ms.topic: reference
ms.date: 03/04/2025
---

# fsutil clfs

The `fsutil clfs` command adds authentication support to a Common Log File System (CLFS) logfile that has either invalid or missing authentication codes. Authentication codes are written to the Base Logfile (`.blf`) and all containers associated with the logfile. When authentication is enforced, CLFS opens a logfile if it has valid authentication codes.

## Syntax

```
fsutil clfs authenticate [<BLF Logfile path>]
```

### Parameters

| Parameter | Description |
|--|--|
| authenticate | Adds authentication codes to an existing CLFS logfile. |

### Example

The following example adds authentication codes to the "C:\example_log" logfile:

```
fsutil clfs authenticate "C:\example_log.blf"
```

## Related links

- [Fsutil](fsutil.md)
- [Introduction to the Common Log File System](/windows-hardware/drivers/kernel/introduction-to-the-common-log-file-system)
- [Common Log File System API](/previous-versions/windows/desktop/clfs/common-log-file-system-api)
- [Command-Line Syntax Key](command-line-syntax-key.md)
