---
title: bitsadmin geterrorcount
description: Reference topic for the bitsadmin geterrorcount command, which retrieves a count of the number of times the specified job generated a transient error.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 8840ae78-52b0-4c7e-b592-0547359a237e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin geterrorcount

Retrieves a count of the number of times the specified job generated a transient error.

## Syntax

```
bitsadmin /geterrorcount <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve error count information for the job named *myDownloadJob*:

```
bitsadmin /geterrorcount myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
