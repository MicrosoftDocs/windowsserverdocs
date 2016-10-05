---
title: Ftp: mdir
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 90eec45b-558b-4b8d-bbe4-b56d98e1ca70 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Ftp: mdir
Displays a directory list of files and subdirectories in a remote directory. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
## Syntax  
```  
mdir <RemoteFile>[…] <LocalFile>  
```  
### Parameters  
|Parameter|Description|  
|-------------|---------------|  
|<RemoteFile>|Specifies the directory or file for which you want to see a listing.|  
|<LocalFile>|Specifies a local file to store the listing. This parameter is required.|  
## Remarks  
-   You can use **mdir** to specify multiple files.  
-   Specifying *RemoteFile*  
    Type a hyphen (**-**) to use the current working directory on the remote computer.  
-   Specifying a *LocalFile*  
    Type a hyphen (**-**) to display the listing on the screen.  
## <a name="BKMK_Examples"></a>Examples  
Display a directory listing of **Dir1** and **Dir2** on the screen  
```  
mdir Dir1 Dir2 -  
```  
Save the combined directory listing of **Dir1** and **Dir2** in a local file called **dirlist.txt**  
```  
mdir Dir1 Dir2 dirlist.txt  
```  
## Additional references  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
