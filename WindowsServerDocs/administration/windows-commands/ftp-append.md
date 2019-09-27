---
title: ftp append
description: "Windows Commands topic for ftp append "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7c1a133c-31dc-41a4-9eb9-258efd79804d vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ftp: append

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

appends a local file to a file on the remote computer using the current file type setting.   
## Syntax  
```  
append <LocalFile> [remoteFile]  
```  
### Parameters  

|  Parameter   |                               Description                                |
|--------------|--------------------------------------------------------------------------|
| <LocalFile>  |                     Specifies the local file to add.                     |
| [remoteFile] | Specifies the file on the remote computer to which <LocalFile> is added. |

## Remarks  
if *remoteFile* is omitted, the *LocalFile* name is used in place of the remote file name.  
## <a name="BKMK_Examples"></a>Examples  
append file1.txt to file2.txt on the remote computer.  
```  
append file1.txt file2.txt  
```  
append the local file1.txt to a file named file1.txt on the remote computer.  
```  
append file1.txt  
```  
## additional references  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
