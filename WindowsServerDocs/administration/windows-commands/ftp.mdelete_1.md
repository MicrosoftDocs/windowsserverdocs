---
title: ftp mdelete_1
description: Reference topic for **** - 

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 8a80a8f5-e880-40a8-abc9-29a41836844f vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ftp: mdelete_1

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

deletes files on the remote computer.   
## Syntax  
```  
mdelete <remoteFile>[ ]  
```  
#### Parameters  

|  Parameter   |             Description              |
|--------------|--------------------------------------|
| <remoteFile> | Specifies the remote file to delete. |

## Examples  
delete remote files **a.exe** and **b.exe**.  
```  
mdelete a.exe b.exe  
```  
## Additional References  
-   - [Command-Line Syntax Key](command-line-syntax-key.md)  
