---
title: bitsadmin makecustomheaderswriteonly
description: Windows Commands topic for **bitsadmin makecustomheaderswriteonly**, which make a job's Custom HTTP Headers write-only.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 03/01/2019
---

# bitsadmin makecustomheaderswriteonly

Make a job's Custom HTTP Headers write-only.

> [!Important]
> This action can't be undone.

## Syntax

```
bitsadmin /makecustomheaderswriteonly <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## <a name=BKMK_examples></a>Examples

The following example makes Custom HTTP Headers write-only for the job named *myDownloadJob*.

```
C:\>bitsadmin /makecustomheaderswriteonly myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)