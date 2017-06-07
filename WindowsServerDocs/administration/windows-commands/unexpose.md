---
title: unexpose
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 58dc7d0f-52e9-4587-9487-d3b4c3e52640
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# unexpose

> Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Unexposes a shadow copy that was exposed by using the **expose** command. The exposed shadow copy can be specified by its Shadow ID, drive letter, share, or mount point.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
unexpose {<ShadowID> | <Drive:> | <Share> | <MountPoint>}
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<ShadowID>|Unexposes the shadow copy specified by the given Shadow ID.|
|\<Drive:>|Unexposes the shadow copy associated with the specified drive letter (for example, drive P).|
|\<Share>|Unexposes the shadow copy associated with the specified share (for example, \\\\*MachineName*\).|
|\<MountPoint>|Unexposes the shadow copy associated with the specified mount point (for example, C:\shadowcopy\).|

## Remarks

-   You can use an existing alias or an environment variable in place of *ShadowID*. Use **add** without parameters to see existing aliases.

## <a name="BKMK_examples"></a>Examples

To unexpose the shadow copy associated with Drive P, type:
```
unexpose P:
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)