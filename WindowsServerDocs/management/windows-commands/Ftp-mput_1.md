---
title: Ftp: mput_1
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 980f15e7-7cf1-4813-9946-a8cc4edfb198 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Ftp: mput_1

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Copies local files to the remote computer using the current file transfer type.   
## Syntax  
```  
mput <LocalFile>[ ]  
```  
### Parameters  
|Parameter|Description|  
|-------|--------|  
|<LocalFile>|Specifies the local file to copy to the remote computer.|  
## <a name="BKMK_Examples"></a>Examples  
Copy **Program1.exe** and **Program2.exe** to the remote computer using the current file transfer type.  
```  
mput Program1.exe Program2.exe  
```  
## Additional references  
-   [Ftp: ascii](Ftp-ascii.md)  
-   [Ftp: binary](Ftp-binary.md)  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
