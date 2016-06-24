---
title: Ftp: dir
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a29a92a5-7b79-4e6e-95cf-2ccb38bb6fb2
author: vhorne
---
# Ftp: dir
Displays a list of directory files and subdirectories on a remote computer. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
dir [<RemoteDirectory>] [<LocalFile>]  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|[<RemoteDirectory>]|Specifies the directory for which you want to see a listing. If no directory is specified, the current working directory on the remote computer is used.|  
|[<LocalFile>]|Specifies a local file in which to store the directory listing. If a local file is not specified, results are displayed on the screen.|  
  
## <a name="BKMK_Examples"></a>Examples  
Display a directory listing for **Dir1** on the remote computer.  
  
```  
dir Dir1  
```  
  
Save a list of the current directory on the remote computer in the local file **DirList.txt**.  
  
```  
dir . DirList.txt  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](../commands/Command-Line-Syntax-Key.md)  
  

