---
title: fsutil clfs
description: Reference article for the fsutil clfs command.
manager: nealch
ms.author: brajackson
author: bjax15
ms.assetid: 3a5851ad-664c-4467-9ac9-132c3e4b2f7c
ms.topic: reference
ms.date: 08/27/2024
---

# fsutil clfs

>Applies to: Windows Server 2022, Windows Server 2019, Windows 11, Windows 10
Provides administrative functionality for CLFS logfiles, including the management of logfile authentication codes.

## CLFS commands supported

| Command | Description |
| ------- | ----------- |
| authenticate | Adds authentication codes to an existing CLFS logfile. |

### Syntax

```
fsutil clfs authenticate [<Logfile BLF path>]
```

## fsutil clfs authenticate

Add authentication support to a CLFS logfile that has invalid or missing authentication codes. Authentication codes will be written to the Base Logfile (.blf) and all containers associated with the logfile.

When authentication is enforced, CLFS will only open a logfile if it has valid authentication codes

### Example

The following example adds authentication codes to the "C:\example_log" logfile:

```
fsutil clfs authenticate "C:\example_log.blf"
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
- [fsutil](fsutil.md)
- [CLFS] (/previous-versions/windows/desktop/clfs/common-log-file-system-api)
- [CLFS - Windows Hardware](/windows-hardware/drivers/kernel/introduction-to-the-common-log-file-system)