---
title: bitsadmin gettype
description: Windows Commands topic for **bitsadmin gettype**, which retrieves the job type of the specified job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: bec16f04-3e95-4587-889e-3de6ad03c9c8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin gettype

Retrieves the job type of the specified job.

## Syntax

```
bitsadmin /gettype <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Output

The output values include:

| Type | Description |
| --------------- | ----------- |
| Download | The job is a download. |
| Upload | The job is an upload. |
| Upload-Reply | The job is an upload-reply. |
| Unknown | The job has an unknown type. |

## <a name=BKMK_examples></a>Examples

The following example retrieves the job type for the job named *myDownloadJob*.

```
C:\>bitsadmin /gettype myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)