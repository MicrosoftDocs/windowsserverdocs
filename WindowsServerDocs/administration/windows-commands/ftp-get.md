---
title: ftp get
description: "Windows Commands topic for ftp get"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d70355c4-58ef-43e0-916b-c7ecf77e6ee4 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ftp: get

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Copies a remote file to the local computer using the current file transfer type.   
## Syntax  
```  
get <remoteFile> [<LocalFile>]  
```  
### Parameters  

|   Parameter   |                                                              Description                                                               |
|---------------|----------------------------------------------------------------------------------------------------------------------------------------|
| <remoteFile>  |                                                   Specifies the remote file to copy.                                                   |
| [<LocalFile>] | Specifies the name of the file to use on the local computer. If *LocalFile* is not specified, the file is given the *remoteFile* name. |

## Remarks  
The **get** command is identical to the **recv** command.  
## <a name="BKMK_Examples"></a>Examples  
copy **test.txt** to the local computer using the current file transfer type.  
```  
get test.txt  
```  
copy **test.txt** to the local computer as **test1.txt** using the current file transfer type.  
```  
Get test.txt test1.txt  
```  
## additional references  
-   [ftp: ascii](ftp-ascii.md)  
-   [ftp: binary](ftp-binary.md)  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
