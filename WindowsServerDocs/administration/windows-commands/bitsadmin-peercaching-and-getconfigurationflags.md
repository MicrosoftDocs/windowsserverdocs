---
title: bitsadmin peercaching and getconfigurationflags
description: Reference article for the bitsadmin peercaching and getconfigurationflags command, which gets the configuration flags that determine if the computer serves content to peers and if it can download content from peers.
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

## Examples

To get the configuration flags for the job named *myDownloadJob*:

```
bitsadmin /peercaching /getconfigurationflags myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)

- [bitsadmin peercaching command](bitsadmin-peercaching.md)
