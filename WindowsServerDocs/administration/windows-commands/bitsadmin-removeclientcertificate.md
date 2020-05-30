---
title: bitsadmin removeclientcertificate
description: Reference topic for the bitsadmin removeclientcertificate command, which removes the client certificate from the job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: b417c3e5-aadd-4fcc-968f-45d8b67ca516
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin removeclientcertificate

Removes the client certificate from the job.

## Syntax

```
bitsadmin /removeclientcertificate <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To remove the client certificate from the job named *myDownloadJob*:

```
bitsadmin /removeclientcertificate myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
