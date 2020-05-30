---
title: bitsadmin gettype
description: Reference topic for the bitsadmin gettype command, which retrieves the job type of the specified job.
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

#### Output

The returned output values can be:

| Type | Description |
| --------------- | ----------- |
| Download | The job is a download. |
| Upload | The job is an upload. |
| Upload-Reply | The job is an upload-reply. |
| Unknown | The job has an unknown type. |

## Examples

To retrieve the job type for the job named *myDownloadJob*:

```
bitsadmin /gettype myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
