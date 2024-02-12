---
title: bitsadmin getnotifycmdline
description: Reference article for the bitsadmin getnotifycmdline command, which retrieves the command-line command that is run when the job finishes transferring data.
ms.topic: reference
ms.assetid: 90fa33e6-aca5-4a23-82bd-19a9f13f8416
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin getnotifycmdline

Retrieves the command-line command to run after the specified job finishes transferring data.

> [!NOTE]
> This command isn't supported by BITS 1.2 and earlier.

## Syntax

```
bitsadmin /getnotifycmdline <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the command-line command used by the service when the job named *myDownloadJob* completes.

```
bitsadmin /getnotifycmdline myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
