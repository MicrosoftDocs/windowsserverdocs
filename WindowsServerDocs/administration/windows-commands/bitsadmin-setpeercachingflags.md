---
title: bitsadmin setpeercachingflags
description: Reference article for the bitsadmin setpeercachingflags command, which sets flags that determine if the files of the job can be cached and served to peers and if the job can download content from peers.
ms.topic: reference
ms.assetid: 3f54a127-fb68-49a5-b843-664ec833df67
ms.author: jgerend
author: JasonGerend
manager: mtillman
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

To allow the job named *myDownloadJob* to download content from peers:

```
bitsadmin /setpeercachingflags myDownloadJob 1
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
