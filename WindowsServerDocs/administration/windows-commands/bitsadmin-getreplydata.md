---
title: bitsadmin getreplydata
description: Reference article for the bitsadmin getreplydata command, which retrieves the server's upload-reply data in hexadecimal format for the job.
ms.topic: reference
ms.assetid: 819f97d5-b255-4b2d-9f63-0daa73915434
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin getreplydata

Retrieves the server's upload-reply data in hexadecimal format for the job.

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

## Examples

To retrieve the upload-reply data for the job named *myDownloadJob*:

```
bitsadmin /getreplydata myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
