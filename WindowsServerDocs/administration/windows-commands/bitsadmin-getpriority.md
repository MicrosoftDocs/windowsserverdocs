---
title: bitsadmin getpriority
description: Windows Commands topic for **bitsadmin getpriority**, which retrieves the priority of the specified job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 03/01/2019
---

# bitsadmin getpriority

Retrieves the priority of the specified job.

## Syntax

```
bitsadmin /getpriority <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Remarks

The priority for this command can be:

- **FOREGROUND**

- **HIGH**

- **NORMAL**

- **LOW**

- **UNKNOWN**

## <a name=BKMK_examples></a>Examples

The following example retrieves the priority for the job named *myDownloadJob*.

```
C:\>bitsadmin /getpriority myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
