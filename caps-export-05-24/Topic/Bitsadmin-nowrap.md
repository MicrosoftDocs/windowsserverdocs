---
title: Bitsadmin nowrap
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 85a47b90-783a-41e4-96f2-81f26ae8ca93
author: britw
---
# Bitsadmin nowrap
Truncates any line of output text extending beyond the rightmost edge of the command window.  
  
## Syntax  
  
```  
bitsadmin /NoWrap  
```  
  
## Remarks  
By default, all commands, except the **Monitor** command, wrap the output. Specify the **NoWrap** command before other commands.  
  
## <a name="BKMK_examples"></a>Examples  
The following example retrieves the state for the job named *myDownloadJob* and does not wrap the output  
  
```  
C:\>bitsadmin /NoWrap /GetState myDownloadJob  
```  
  
## Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
