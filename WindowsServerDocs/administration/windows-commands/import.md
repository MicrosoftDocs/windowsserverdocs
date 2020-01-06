---
title: import
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7bd78d76-0560-4d47-944c-fe960be2c10b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# import



Imports a transportable shadow copy from a loaded metadata file into the system.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
import
```

## Remarks

-   Transportable shadow copies are not stored on the system immediately. Their details are stored in a Backup Components Document XML file, which DiskShadow automatically requests and saves in a .cab metadata file in the working directory. You can change the path and name of this file using the **set metadata** command.
-   Before you can use **import**, you must load a DiskShadow metadata file using the **load metadata** command.

## <a name="BKMK_examples"></a>Examples

The following is a sample DiskShadow script that demonstrates the use of the **import** command:
```
#Sample DiskShadow script demonstrating IMPORT
SET CONTEXT PERSISTENT
SET CONTEXT TRANSPORTABLE
SET METADATA transHWshadow_p.cab
#P: is the volume supported by the Hardware Shadow Copy provider
ADD VOLUME P:
CREATE
END BACKUP
#The (transportable) shadow copy is not in the system yet.
#You can reset or exit now if you wish.

LOAD METADATA transHWshadow_p.cab
IMPORT
#The shadow copy will now be loaded into the system.
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)