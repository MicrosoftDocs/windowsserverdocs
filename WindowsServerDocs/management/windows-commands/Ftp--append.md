---
title: Ftp: append
description: "Windows Commands topic for **** -- "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7c1a133c-31dc-41a4-9eb9-258efd79804d vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Ftp: append

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Appends a local file to a file on the remote computer using the current file type setting.   
## Syntax  
```  
Append <LocalFile> [RemoteFile]  
```  
### Parameters  
|Parameter|Description|  
|-------------|---------------|  
|<LocalFile>|Specifies the local file to add.|  
|[RemoteFile]|Specifies the file on the remote computer to which <LocalFile> is added.|  
## Remarks  
If *RemoteFile* is omitted, the *LocalFile* name is used in place of the remote file name.  
## <a name="BKMK_Examples"></a>Examples  
Append file1.txt to file2.txt on the remote computer.  
```  
append file1.txt file2.txt  
```  
Append the local file1.txt to a file named file1.txt on the remote computer.  
```  
Append file1.txt  
```  
## Additional references  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
