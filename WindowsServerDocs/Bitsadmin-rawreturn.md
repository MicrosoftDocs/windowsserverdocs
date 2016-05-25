---
title: Bitsadmin rawreturn
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bbe97130-26f6-4cdd-84f1-baf530ce38b7
author: britw
---
# Bitsadmin rawreturn
Returns data suitable for parsing.  
  
## Syntax  
  
```  
bitsadmin /RawReturn  
```  
  
## Remarks  
Strips new line characters and formatting from the output.  
  
Typically, you use this command in conjunction with the **Create** and **Get\*** commands to receive only the value. You must specify this command before other commands.  
  
## <a name="BKMK_examples"></a>Examples  
The following example retrieves the raw data for the state of the job named *myDownloadJob*.  
  
```  
C:\>bitsadmin /RawReturn /GetState myDownloadJob  
```  
  
## Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

