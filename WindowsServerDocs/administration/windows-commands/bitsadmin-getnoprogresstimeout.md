---
title: bitsadmin getnoprogresstimeout
description: Windows Commands topic for **bitsadmin getnoprogresstimeout**, which retrieves the length of time, in seconds, that the service will try to transfer the file after a transient error occurs.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 9cd9b19b-cbb4-4352-8419-978080f016b6
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getnoprogresstimeout

Retrieves the length of time, in seconds, that the service will try to transfer the file after a transient error occurs.

## Syntax

```
bitsadmin /getnoprogresstimeout <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## <a name=BKMK_examples></a>Examples

The following example retrieves the progress time out value for the job named *myDownloadJob*.

```
C:\>bitsadmin /getnoprogresstimeout myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)