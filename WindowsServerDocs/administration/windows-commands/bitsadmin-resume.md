---
title: bitsadmin resume
description: Windows Commands topic for **bitsadmin resume**, which activates a new or suspended job in the transfer queue.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 7c7540a9-a11a-4910-923a-2a2a61cbf11d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin resume

Activates a new or suspended job in the transfer queue.

## Syntax

```
bitsadmin /resume <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## <a name=BKMK_examples></a>Examples

The following example resumes the job named *myDownloadJob*.

```
C:\>bitsadmin /resume myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)