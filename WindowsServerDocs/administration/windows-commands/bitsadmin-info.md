---
title: bitsadmin info
description: Windows Commands topic for **bitsadmin info**, which displays summary information about the specified job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 5c306677-0d64-41c0-8276-5bba7750cecb
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin info

Displays summary information about the specified job.

## Syntax

```
bitsadmin /info <job> [/verbose]
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |
| /verbose | Optional. Provides detailed information about each job. |

## <a name=BKMK_examples></a>Examples

The following example retrieves information about the job named *myDownloadJob*.

```
C:\>bitsadmin /info myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin info](bitsadmin-info.md)