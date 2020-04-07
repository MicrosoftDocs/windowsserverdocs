---
title: bitsadmin getreplydata
description: Windows Commands topic for **bitsadmin getreplydata**, which retrieves the server's upload reply data in hexadecimal format for the job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 819f97d5-b255-4b2d-9f63-0daa73915434
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getreplydata

Retrieves the server's upload reply data in hexadecimal format for the job.

> [!NOTE]
> This command isn't supported by BITS 1.2 and earlier.

## Syntax

```
bitsadmin /getreplydata <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## <a name=BKMK_examples></a>Examples

The following example retrieves the upload reply data for the job named *myDownloadJob*.

```
C:\>bitsadmin /getreplydata myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)