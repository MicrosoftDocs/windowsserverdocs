---
title: ftp mdelete_1
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8a80a8f5-e880-40a8-abc9-29a41836844f vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ftp: mdelete_1

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

deletes files on the remote computer.   
## Syntax  
```  
mdelete <remoteFile>[ ]  
```  
### Parameters  

|  Parameter   |             Description              |
|--------------|--------------------------------------|
| <remoteFile> | Specifies the remote file to delete. |

## <a name="BKMK_Examples"></a>Examples  
delete remote files **a.exe** and **b.exe**.  
```  
mdelete a.exe b.exe  
```  
## additional references  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
