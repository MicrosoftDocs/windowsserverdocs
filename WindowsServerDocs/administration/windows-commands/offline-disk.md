---
title: offline disk
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8fb9b3c3-0b2c-4192-a2e7-f706292653e3
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# offline disk



Takes the online disk with focus to the offline state.

> [!IMPORTANT]
> This DiskPart command is not available in any edition of Windows Vista.

## Syntax

```
offline disk [noerr]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|

## Remarks

-   This command operates on disks that are in SAN online mode. It changes their SAN mode to offline.
-   If a dynamic disk in a disk group is taken offline, the status of the disk changes to **missing** and the group shows a disk that is offline. The missing disk is moved to the invalid group. If the dynamic disk is the last disk in the group, then the status of the disk will change to **offline**, and the empty group will be removed.
-   A disk must be selected for the **offline disk** command to succeed. Use the **select disk** command to select a disk and shift the focus to it.

## <a name="BKMK_examples"></a>Examples

To take the disk with focus offline, type:
```
offline disk
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

