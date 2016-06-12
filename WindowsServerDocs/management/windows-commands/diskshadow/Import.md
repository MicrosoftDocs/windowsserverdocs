---
title: import
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7bd78d76-0560-4d47-944c-fe960be2c10b
---
# import
imports a transportable shadow copy from a loaded metadata file into the system.

for examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
import
```

## remarks

-   Transportable shadow copies are not stored on the system immediately. Their details are stored in a Backup components Document XML file, which Diskshadow automatically requests and saves in a .cab metadata file in the working directory. You can change the path and name of this file using the **set metadata** command.

-   Before you can use **import**, you must load a Diskshadow metadata file using the **load metadata** command.

## <a name="BKMK_examples"></a>Examples
The following is a sample Diskshadow script that demonstrates the use of the **import** command:

```
#Sample Diskshadow script demonstrating import
SET CONTEXT PERSISTENT
SET CONTEXT TRANSPORTABLE
SET METADatA transHWshadow_p.cab
#P: is the volume supported by the Hardware shadow copy provider
add volUME P:
create
END BACKUP
#The (transportable) shadow copy is not in the system yet.
#You can reset or exit now if you wish.

LOAD METADatA transHWshadow_p.cab
import
#The shadow copy will now be loaded into the system.
```

#### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


