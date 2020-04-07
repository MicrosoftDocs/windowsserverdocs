---
title: bitsadmin peercaching and getconfigurationflags
description: Windows Commands topic for **bitsadmin peercaching** and **getconfigurationflags**, which gets the configuration flags that determine if the computer serves content to peers and if it can download content from peers.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 124ddc15-3444-4bd5-96e5-c6bfabe4f9c2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin peercaching and getconfigurationflags

Gets the configuration flags that determine if the computer serves content to peers and if it can download content from peers.

## Syntax

```
bitsadmin /peercaching /getconfigurationflags <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## <a name=BKMK_examples></a>Examples

The following example gets the configuration flags for the job named *myDownloadJob*.

```
C:\> bitsadmin /peercaching /getconfigurationflags myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)