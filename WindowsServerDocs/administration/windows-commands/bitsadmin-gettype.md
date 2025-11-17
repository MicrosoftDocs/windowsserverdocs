---
title: bitsadmin gettype
description: Reference article for the bitsadmin gettype command, which retrieves the job type of the specified job.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
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

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
