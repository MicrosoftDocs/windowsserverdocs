---
title: online volume
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5da073fd-578d-4691-ad0f-605ba66e0c7e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# online volume



Brings volumes that are currently offline to an online state

> [!IMPORTANT]
> This command is not available in any edition of Windows Vista.

> [!IMPORTANT]
> This command will fail if it is used on a read-only volume.

## Syntax

```
online volume [noerr]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|

## Remarks

-   This command operates on volumes that have failed, are failing, or are in failed redundancy state.
-   A volume must be selected for this command to succeed. Use the **select volume** command to select a volume and shift the focus to it.

## <a name="BKMK_examples"></a>Examples

To bring the volume with focus online, type:
```
online volume
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

