---
title: unexpose
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 58dc7d0f-52e9-4587-9487-d3b4c3e52640
---
# unexpose
unexposes a shadow copy that was exposed by using the **expose** command. The exposed shadow copy can be specified by its shadow ID, drive letter, share, or mount point.

for examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
unexpose {<shadowID> | <Drive:> | <Share> | <mountPoint>}
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|<shadowID>|unexposes the shadow copy specified by the given shadow ID.|
|<Drive:>|unexposes the shadow copy associated with the specified drive letter \(for example, drive P\).|
|<Share>|unexposes the shadow copy associated with the specified share \(for example, \\\\*MachineName*\\\).|
|<mountPoint>|unexposes the shadow copy associated with the specified mount point \(for example, C:\\shadowcopy\\\).|

## remarks

-   You can use an existing alias or an environment variable in place of *shadowID*. Use **add** without parameters to see existing aliases.

## <a name="BKMK_examples"></a>Examples
To unexpose the shadow copy associated with Drive P, type:

```
unexpose P:
```

#### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


