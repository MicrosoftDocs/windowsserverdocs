---
title: bitsadmin getpriority
description: Reference article for the bitsadmin getpriority command, which retrieves the priority of the specified job.
ms.topic: reference
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 03/01/2019
---

# bitsadmin getpriority

Retrieves the priority of the specified job.

## Syntax

```
bitsadmin /getpriority <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

#### Output

The returned priority for this command can be:

- **FOREGROUND**

- **HIGH**

- **NORMAL**

- **LOW**

- **UNKNOWN**

## Examples

To retrieve the priority for the job named *myDownloadJob*:

```
bitsadmin /getpriority myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
