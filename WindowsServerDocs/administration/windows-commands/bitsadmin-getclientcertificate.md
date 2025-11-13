---
title: bitsadmin getclientcertificate
description: Reference article for the bitsadmin getclientcertificate command, which retrieves the client certificate from the job.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# bitsadmin getclientcertificate

Retrieves the client certificate from the job.

## Syntax

```
bitsadmin /getclientcertificate <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the client certificate for the job named *myDownloadJob*:

```
bitsadmin /getclientcertificate myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
