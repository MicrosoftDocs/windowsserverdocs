---
title: bitsadmin removeclientcertificate
description: Reference article for the bitsadmin removeclientcertificate command, which removes the client certificate from the job.
ms.topic: reference
ms.assetid: b417c3e5-aadd-4fcc-968f-45d8b67ca516
ms.author: jgerend
author: JasonGerend
manager: mtillman
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

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
