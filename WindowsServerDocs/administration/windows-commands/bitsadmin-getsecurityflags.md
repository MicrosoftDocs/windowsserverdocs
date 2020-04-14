---
title: bitsadmin getsecurityflags
description: Windows Commands topic for **bitsadmin getsecurityflags**, which reports the HTTP security flags for URL redirection and checks performed on the server certificate during the transfer.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: c2e73519-34f4-487b-af11-97d5d08ef9bb
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# bitsadmin getsecurityflags

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Reports the HTTP security flags for URL redirection and checks performed on the server certificate during the transfer.

## Syntax

```
bitsadmin /getsecurityflags <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## <a name=BKMK_examples></a>Examples

The following example retrieves the security flags from a job named *myDownloadJob*.

```
C:\>bitsadmin /getsecurityflags myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)