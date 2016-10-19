---
title: Ftp: get
description: "Windows Commands topic for **** - "
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
ms.date: 10/12/2016
---
# Ftp: get

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Copies a remote file to the local computer using the current file transfer type.   
## Syntax  
```  
get <RemoteFile> [<LocalFile>]  
```  
### Parameters  
|Parameter|Description|  
|-------|--------|  
|<RemoteFile>|Specifies the remote file to copy.|  
|[<LocalFile>]|Specifies the name of the file to use on the local computer. If *LocalFile* is not specified, the file is given the *RemoteFile* name.|  
## Remarks  
The **get** command is identical to the **recv** command.  
## <a name="BKMK_Examples"></a>Examples  
Copy **test.txt** to the local computer using the current file transfer type.  
```  
get test.txt  
```  
Copy **test.txt** to the local computer as **test1.txt** using the current file transfer type.  
```  
Get test.txt test1.txt  
```  
## Additional references  
-   [Ftp: ascii](Ftp-ascii.md)  
-   [Ftp: binary](Ftp-binary.md)  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
