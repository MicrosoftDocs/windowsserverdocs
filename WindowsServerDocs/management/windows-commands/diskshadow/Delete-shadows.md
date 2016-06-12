---
title: delete shadows
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e29a84d2-04d1-4eb1-910a-5a47bddbc24d
---
# delete shadows
deletes shadow copies.

## Syntax

```
delete shadows [all | volume <volume> | oldest <volume> | set <SetID> | id <shadowID> | exposed {<Drive> | <mountPoint>}]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|all|deletes all shadow copies.|
|volume <volume>|deletes all shadow copies of the given volume.|
|oldest <volume>|deletes the oldest shadow copy of the given volume.|
|set <SetID>|deletes the shadow copies in the shadow copy Set of the given ID. You can specify an alias by using the **%** symbol if the alias exists in the current environment.|
|id <shadowID>|deletes a shadow copy of the given ID. You can specify an alias by using the **%** symbol if the alias exists in the current environment.|
|exposed {<Drive> &#124; <mountPoint>}|deletes the shadow copy exposed at the specified drive letter or mount point. Specify mount points as c:\\mountPoint or by the drive letter such as p:.|

#### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


