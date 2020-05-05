---
title: ftp ls_1
description: Reference topic for **** - 

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 5e03c7db-1e2b-419c-acb2-8a68f3db9615 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ftp: ls_1

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012
> 
> 
> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays an abbreviated list of files and subdirectories from the remote computer.   
## Syntax  
```  
ls [<remotedirectory>] [<LocalFile>]  
```  
#### Parameters  

|      Parameter      |                                                                       Description                                                                        |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| [<remotedirectory>] | Specifies the directory for which you want to see a listing. If no directory is specified, the current working directory on the remote computer is used. |
|    [<LocalFile>]    |               Specifies a local file in which to store the listing. If a local file is not specified, results are displayed on the screen.               |

## Examples  
Display an abbreviated list of files and subdirectories from the remote computer.  
```  
ls  
```  
Get an abbreviated directory listing of **dir1** on the remote computer and save it in a local file called **dirlist.txt**  
```  
ls dir1 dirlist.txt   
```  
## Additional References  
-   - [Command-Line Syntax Key](command-line-syntax-key.md)  
