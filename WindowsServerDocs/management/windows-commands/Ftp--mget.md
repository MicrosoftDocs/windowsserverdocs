---
title: Ftp: mget
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6c85ae96-ec51-48a9-a227-7f02c7332c69 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Ftp: mget

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Copies remote files to the local computer using the current file transfer type.   
## Syntax  
```  
mget <RemoteFile>[???]  
```  
### Parameters  
|Parameter|Description|  
|-------------|---------------|  
|<RemoteFile>|Specifies the remote files to copy to the local computer.|  
## <a name="BKMK_Examples"></a>Examples  
Copy remote files **a.exe** and **b.exe** to the local computer using the current file transfer type.  
```  
mget a.exe b.exe  
```  
## Additional references  
-   [Ftp: ascii](Ftp--ascii.md)  
-   [Ftp: binary](Ftp--binary.md)  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
