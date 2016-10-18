---
title: Ftp: mls_1
description: "Windows Commands topic for **** -- "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4738fd49-0e80-4bdf-a773-0f973db3a710 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Ftp: mls_1

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Displays an abbreviated list of files and subdirectories in a remote directory.   
## Syntax  
```  
mls <RemoteFile>[???] <LocalFile>  
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
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
