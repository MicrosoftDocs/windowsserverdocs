---
title: ftp dir
description: "Windows Commands topic for ftp dir"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a29a92a5-7b79-4e6e-95cf-2ccb38bb6fb2 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ftp: dir

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays a list of directory files and subdirectories on a remote computer.   
## Syntax  
```  
dir [<remotedirectory>] [<LocalFile>]  
```  
### Parameters  
|Parameter|Description|  
|-------|--------|  
|[<remotedirectory>]|Specifies the directory for which you want to see a listing. If no directory is specified, the current working directory on the remote computer is used.|  
|[<LocalFile>]|Specifies a local file in which to store the directory listing. If a local file is not specified, results are displayed on the screen.|  
## <a name="BKMK_Examples"></a>Examples  
Display a directory listing for **dir1** on the remote computer.  
```  
dir dir1  
```  
Save a list of the current directory on the remote computer in the local file **dirlist.txt**.  
```  
dir . dirlist.txt  
```  
## additional references  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
