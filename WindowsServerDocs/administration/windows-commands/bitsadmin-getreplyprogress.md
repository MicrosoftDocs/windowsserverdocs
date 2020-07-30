---
title: bitsadmin getreplyprogress
description: Reference article for the bitsadmin getreplyprogress command, which retrieves the size and progress of the server upload-reply.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 7f7cb0b4-ad95-44fd-a35d-0ddf5fc0b0d0
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getreplyprogress

Retrieves the size and progress of the server upload-reply.

> [!NOTE]
> This command isn't supported by BITS 1.2 and earlier.

## Syntax

```
bitsadmin /getreplyprogress <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the upload-reply progress for the job named *myDownloadJob*:

```
bitsadmin /getreplyprogress myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
