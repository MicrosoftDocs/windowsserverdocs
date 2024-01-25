---
title: bitsadmin getpeercachingflags
description: Reference article for the bitsadmin getpeercachingflags command, which retrieves flags that determine if the files of the job can be cached and served to peers, and if BITS can download content for the job from peers.
ms.topic: reference
ms.assetid: 3c3c9f28-4c04-4c49-a23a-dee5bbcc8981
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# bitsadmin getpeercachingflags

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves flags that determine if the files of the job can be cached and served to peers, and if BITS can download content for the job from peers.

## Syntax

```
bitsadmin /getpeercachingflags <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the flags for the job named *myDownloadJob*:

```
bitsadmin /getpeercachingflags myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
