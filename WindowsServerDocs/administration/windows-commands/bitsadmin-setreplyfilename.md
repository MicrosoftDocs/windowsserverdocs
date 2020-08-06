---
title: bitsadmin setreplyfilename
description: Reference article for the bitsadmin setreplyfilename command, which specifies the path of the file that contains the server upload-reply.
ms.topic: article
ms.assetid: c26d3342-0533-40b1-a13e-e09678232b25
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin setreplyfilename

Specifies the path of the file that contains the server upload-reply.

> [!NOTE]
> This command isn't supported by BITS 1.2 and earlier.

## Syntax

```
bitsadmin /setreplyfilename <job> <file_path>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |
| file_path | Location to put the server upload-reply. |

## Examples

To set the upload-reply filename file path for the job named *myDownloadJob*:

```
bitsadmin /setreplyfilename myDownloadJob c:\upload-reply
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
