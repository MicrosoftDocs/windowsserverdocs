---
title: bitsadmin gethttpmethod
description: Reference article for the bitsadmin gethttpmethod command, which gets the HTTP verb to use with the job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 03/01/2019
---

# bitsadmin gethttpmethod

Gets the HTTP verb to use with the job.

## Syntax

```
bitsadmin /gethttpmethod <Job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the HTTP verb to use with the job named *myDownloadJob*:

```
bitsadmin /gethttpmethod myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
