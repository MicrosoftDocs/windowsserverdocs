---
title: Ftp: mput_1
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 980f15e7-7cf1-4813-9946-a8cc4edfb198 vhorne
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Ftp: mput_1
Copies local files to the remote computer using the current file transfer type. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
## Syntax  
```  
mput <LocalFile>[…]  
```  
### Parameters  
|Parameter|Description|  
|-------------|---------------|  
|<LocalFile>|Specifies the local file to copy to the remote computer.|  
## <a name="BKMK_Examples"></a>Examples  
Copy **Program1.exe** and **Program2.exe** to the remote computer using the current file transfer type.  
```  
mput Program1.exe Program2.exe  
```  
## Additional references  
-   [Ftp: ascii](Ftp--ascii.md)  
-   [Ftp: binary](Ftp--binary.md)  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
