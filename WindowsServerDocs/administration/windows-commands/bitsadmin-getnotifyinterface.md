---
title: bitsadmin getnotifyinterface
description: Reference article for the bitsadmin getnotifyinterface command, which determines if another program has registered a COM callback interface for the specified job.
ms.topic: reference
ms.assetid: 40bf9dd8-b167-406a-80a6-a5a6f1b8cf7f
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin getnotifyinterface

Determines whether another program has registered a COM callback interface (the notify interface) for the specified job.

## Syntax

```
bitsadmin /getnotifyinterface <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

#### Output

The output for this command displays either, **Registered** or **Unregistered**.

> [!NOTE]
> It's not possible to determine the program that registered the callback interface.

## Examples

To retrieve the notify interface for the job named *myDownloadJob*:

```
bitsadmin /getnotifyinterface myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
