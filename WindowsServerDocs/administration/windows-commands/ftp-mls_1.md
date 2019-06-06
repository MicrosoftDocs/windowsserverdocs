---
title: ftp mls_1
description: "Windows Commands topic for **** - "
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
ms.date: 10/16/2017
---
# ftp: mls_1

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays an abbreviated list of files and subdirectories in a remote directory.   
## Syntax  
```  
mls <remoteFile>[ ] <LocalFile>  
```  
### Parameters  

|  Parameter   |                       Description                       |
|--------------|---------------------------------------------------------|
| <remoteFile> | Specifies the file for which you want to see a listing. |
| <LocalFile>  |  Specifies a local file in which to store the listing.  |

## Remarks  
- Specifying *remoteFiles*  
  type a hyphen (**-**) to use the current working directory on the remote computer.  
- Specifying *LocalFile*  
  type a hyphen (**-**) to display the listing on the screen.  
  ## <a name="BKMK_Examples"></a>Examples  
  Display an abbreviated list of files and subdirectories for **dir1** and **dir2**.  
  ```  
  mls dir1 dir2 -  
  ```  
  Save an abbreviated list of files and subdirectories for **dir1** and **dir2** in the local file **dirlist.txt**  
  ```  
  mls dir1 dir2 dirlist.txt   
  ```  
  ## additional references  
- [Command-Line Syntax Key](command-line-syntax-key.md)  
