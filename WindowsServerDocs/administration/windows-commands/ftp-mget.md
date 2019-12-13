---
title: ftp mget
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6c85ae96-ec51-48a9-a227-7f02c7332c69 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ftp: mget

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Copies remote files to the local computer using the current file transfer type.   
## Syntax  
```  
mget <remoteFile>[ ]  
```  
### Parameters  

|  Parameter   |                        Description                        |
|--------------|-----------------------------------------------------------|
| <remoteFile> | Specifies the remote files to copy to the local computer. |

## <a name="BKMK_Examples"></a>Examples  
copy remote files **a.exe** and **b.exe** to the local computer using the current file transfer type.  
```  
mget a.exe b.exe  
```  
## additional references  
-   [ftp: ascii](ftp-ascii.md)  
-   [ftp: binary](ftp-binary.md)  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
