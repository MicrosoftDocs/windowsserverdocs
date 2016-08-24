---
title: Ftp: recv
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f249ce61-247d-421b-9b93-48bce5108800 vhorneauthor: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Ftp: recv
Copies a remote file to the local computer using the current file transfer type. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
## Syntax  
```  
recv <RemoteFile> [<LocalFile>]  
```  
### Parameters  
|Parameter|Description|  
|-------------|---------------|  
|<RemoteFile>|Specifies the remote file to copy.|  
|[<LocalFile>]|Specifies the name to use on the local computer.|  
## Remarks  
-   The **recv** command is identical to the **get** command.  
-   If *LocalFile* is not specified, the file is given the *RemoteFile* name.  
## <a name="BKMK_Examples"></a>Examples  
Copy **test.txt** to the local computer using the current file transfer type.  
```  
recv test.txt  
```  
Copy **test.txt** to the local computer as **test1.txt** using the current file transfer type.  
```  
recv test.txt test1.txt  
```  
## Additional references  
-   [Ftp: ascii](Ftp--ascii.md)  
-   [Ftp: binary](Ftp--binary.md)  
-   [Ftp: get](Ftp--get.md)  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
