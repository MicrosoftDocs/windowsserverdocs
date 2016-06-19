---
title: Ftp: ls_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5e03c7db-1e2b-419c-acb2-8a68f3db9615
author: vhorne
---
# Ftp: ls_1
Displays an abbreviated list of files and subdirectories from the remote computer. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
ls [<RemoteDirectory>] [<LocalFile>]  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\[<RemoteDirectory>\]|Specifies the directory for which you want to see a listing. If no directory is specified, the current working directory on the remote computer is used.|  
|\[<LocalFile>\]|Specifies a local file in which to store the listing. If a local file is not specified, results are displayed on the screen.|  
  
## <a name="BKMK_Examples"></a>Examples  
Display an abbreviated list of files and subdirectories from the remote computer.  
  
```  
ls  
```  
  
Get an abbreviated directory listing of **Dir1** on the remote computer and save it in a local file called **DirList.txt**  
  
```  
ls Dir1 DirList.txt   
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](../commands/Command-Line-Syntax-Key.md)  
  

