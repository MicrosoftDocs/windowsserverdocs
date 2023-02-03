---
title: bitsadmin getreplyfilename
description: Reference article for the bitsadmin getreplyfilename command, which gets the path of the file that contains the server upload-reply for the job.
ms.topic: reference
ms.assetid: 85447184-1732-4816-a365-2e3599551bf8
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin getreplyfilename

Gets the path of the file that contains the server upload-reply for the job.

> [!NOTE]
> This command isn't supported by BITS 1.2 and earlier.

## Syntax

```
bitsadmin /getreplyfilename <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the upload-reply filename for the job named *myDownloadJob*:

```
bitsadmin /getreplyfilename myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
