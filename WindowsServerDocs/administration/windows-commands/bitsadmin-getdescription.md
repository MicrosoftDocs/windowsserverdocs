---
title: bitsadmin getdescription
description: Windows Commands topic for **bitsadmin getdescription**, which retrieves the description of the specified job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: f3974603-ebbe-4d31-8217-040fe2d90c85
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getdescription

Retrieves the description of the specified job.

## Syntax

```
bitsadmin /getdescription <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## <a name=BKMK_examples></a>Examples

The following example retrieves the description for the job named *myDownloadJob*.

```
C:\>bitsadmin /getdescription myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)