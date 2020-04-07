---
title: bitsadmin getnotifycmdline
description: Windows Commands topic for **bitsadmin getnotifycmdline**, which retrieves the command-line command that is run when the job finishes transferring data.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 90fa33e6-aca5-4a23-82bd-19a9f13f8416
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getnotifycmdline

Retrieves the command-line command to execute when the job finishes transferring data.

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

## <a name=BKMK_examples></a>Examples

The following example retrieves the command-line command used by the service when the job named *myDownloadJob* completes.

```
C:\>bitsadmin /getnotifycmdline myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)