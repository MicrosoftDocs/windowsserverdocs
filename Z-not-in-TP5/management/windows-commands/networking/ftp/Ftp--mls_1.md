---
title: Ftp: mls_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4738fd49-0e80-4bdf-a773-0f973db3a710
author: vhorne
---
# Ftp: mls_1
Displays an abbreviated list of files and subdirectories in a remote directory. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
mls <RemoteFile>[…] <LocalFile>  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<RemoteFile>|Specifies the file for which you want to see a listing.|  
|<LocalFile>|Specifies a local file in which to store the listing.|  
  
## Remarks  
  
-   Specifying *RemoteFiles*  
  
    Type a hyphen (**-**) to use the current working directory on the remote computer.  
  
-   Specifying *LocalFile*  
  
    Type a hyphen (**-**) to display the listing on the screen.  
  
## <a name="BKMK_Examples"></a>Examples  
Display an abbreviated list of files and subdirectories for **Dir1** and **Dir2**.  
  
```  
mls Dir1 Dir2 -  
```  
  
Save an abbreviated list of files and subdirectories for **Dir1** and **Dir2** in the local file **Dirlist.txt**  
  
```  
mls Dir1 Dir2 Dirlist.txt   
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](../commands/Command-Line-Syntax-Key.md)  
  

