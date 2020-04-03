---
title: bitsadmin getpriority
description: Windows Commands topic for bitsadmin getpriority, which retrieves the priority of the specified job.
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
bitsadmin /GetPriority <Job>
```

### Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## Remarks

The priority is either **FOREGROUND**, **HIGH**, **NORMAL**, **LOW**, or **UNKNOWN**.

## <a name=BKMK_examples></a>Examples

The following example retrieves the priority for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetPriority myDownloadJob
```

## Additional References

[Command-Line Syntax Key](command-line-syntax-key.md)
