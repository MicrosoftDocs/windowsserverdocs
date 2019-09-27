---
title: delete volume
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f625933d-0f47-409e-93b2-a3e234049a5d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# delete volume



Deletes the selected volume.

## Syntax

```
delete volume [noerr]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|

## Remarks

-   You cannot delete the system volume, boot volume, or any volume that contains the active paging file or crash dump (memory dump).
-   A volume must be selected for this operation to succeed. Use the **select volume** command to select a volume and shift the focus to it.

## <a name="BKMK_examples"></a>Examples

To delete the volume with focus, type:
```
delete volume
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

