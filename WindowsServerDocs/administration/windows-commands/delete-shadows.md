---
title: delete shadows
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e29a84d2-04d1-4eb1-910a-5a47bddbc24d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# delete shadows



Deletes shadow copies.

## Syntax

```
delete shadows [all | volume <Volume> | oldest <Volume> | set <SetID> | id <ShadowID> | exposed {<Drive> | <MountPoint>}]
```

## Parameters

|     Parameter     |                                                                             Description                                                                              |
|-------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|        all        |                                                                      Deletes all shadow copies.                                                                      |
| volume \<Volume>  |                                                            Deletes all shadow copies of the given volume.                                                            |
| oldest \<Volume>  |                                                         Deletes the oldest shadow copy of the given volume.                                                          |
|   set \<SetID>    | Deletes the shadow copies in the Shadow Copy Set of the given ID. You can specify an alias by using the **%** symbol if the alias exists in the current environment. |
|  id \<ShadowID>   |              Deletes a shadow copy of the given ID. You can specify an alias by using the **%** symbol if the alias exists in the current environment.               |
| exposed {\<Drive> |                                                                            <MountPoint>}                                                                             |

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)