---
title: import
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7bd78d76-0560-4d47-944c-fe960be2c10b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# import

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

imports a transportable shadow copy from a loaded metadata file into the system.  
  
for examples of how to use this command, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
import  
```  
  
## remarks  
  
-   Transportable shadow copies are not stored on the system immediately. Their details are stored in a Backup components Document XML file, which diskshadow automatically requests and saves in a .cab metadata file in the working directory. You can change the path and name of this file using the **set metadata** command.  
  
-   Before you can use **import**, you must load a diskshadow metadata file using the **load metadata** command.  
  
## <a name="BKMK_examples"></a>Examples  
The following is a sample diskshadow script that demonstrates the use of the **import** command:  
  
```  
#Sample diskshadow script demonstrating import  
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
[Command-Line Syntax Key](command-line-syntax-key.md)  
  

