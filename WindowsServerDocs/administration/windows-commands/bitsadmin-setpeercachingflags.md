---
title: bitsadmin setpeercachingflags
description: Windows Commands topic for **bitsadmin setpeercachingflags**, which sets flags that determine if the files of the job can be cached and served to peers and if the job can download content from peers.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 3f54a127-fb68-49a5-b843-664ec833df67
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin setpeercachingflags

Sets flags that determine if the files of the job can be cached and served to peers and if the job can download content from peers.

## Syntax

```
bitsadmin /setpeercachingflags <job> <value>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |
| value | An unsigned integer, including:<ul><li>**1.** The job can download content from peers.</li><li>**2.** The files of the job can be cached and served to peers.</li></ul> |

## Examples

The following example sets flags for the job named *myDownloadJob*, allowing it to download content from peers.

```
C:\>bitsadmin /setpeercachingflags myDownloadJob 1
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)