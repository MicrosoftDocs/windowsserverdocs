---
title: bitsadmin replaceremoteprefix
description: Windows Commands topic for **bitsadmin replaceremoteprefix**, which changes the remote URL for all files in the job from *oldprefix* to *newprefix*, as necessary.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: d0e0abb1-bdb4-4c74-abbc-16c809f5fd81
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin replaceremoteprefix

Changes the remote URL for all files in the job from *oldprefix* to *newprefix*, as necessary.

## Syntax

```
bitsadmin /replaceremoteprefix <job> <oldprefix> <newprefix>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |
| oldprefix | Existing URL prefix. |
| newprefix | New URL prefix. |

## Examples

The following example changes the remote URL for all files in job named *myDownloadJob*, from *http://stageserver* to *http://prodserver*.

```
C:\>bitsadmin /replaceremoteprefix myDownloadJob http://stageserver http://prodserver
```

## Additional information

- [Command-Line Syntax Key](command-line-syntax-key.md)