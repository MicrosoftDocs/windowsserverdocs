---
title: expand
description: Windows Commands topic for **** - 

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 66de0488-a0c4-40c2-9b03-e40c107ba343
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# expand

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

expands one or more compressed files. You can use this command to retrieve compressed files from distribution disks.  
## Syntax  
```  
expand [/r] <source> <destination>  
expand /r <source> [<destination>]  
expand /i <source> [<destination>]  
expand /d <source>.cab [/f:<files>]  
expand <source>.cab /f:<files> <destination>  
```  
#### Parameters  

|  Parameter  |                                                                                                                                                                   Description                                                                                                                                                                    |
|-------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     /r      |                                                                                                                                                             renames expanded files.                                                                                                                                                              |
|   source    |                                                                              Specifies the files to expand. *Source* can consist of a drive letter and colon, a directory name, a file name, or a combination of these. You can use wildcards (**\\**\* or **?**).                                                                               |
| destination | Specifies where files are to be expanded.<p>if *source* consists of multiple files and you do not specify **/r**, *destination* must be a directory.<p>*Destination* can consist of a drive letter and colon, a directory name, a file name, or a combination of these.<p>Destination file &#124; path specification. |
|     /i      |                                                                                                   renames expanded files but ignores the directory structure.<p>This parameter applies to:  Windows Server 2008 R2  and  Windows 7 .                                                                                                    |
|     /d      |                                                                                                                              Displays a list of files in the source location. Does not expand or extract the files.                                                                                                                              |
|     /f:     |                                                                                                                 Specifies the files in a cabinet (.cab) file that you want to expand. You can use wildcards (**\\**\* or **?**).                                                                                                                 |
|     /?      |                                                                                                                                                       Displays help at the command prompt.                                                                                                                                                       |

## Remarks  
- Using **expand** at the recovery Console  
  The **expand** command, with different parameters, is available from the recovery Console. For more information about the recovery Console, see [article 314058](https://support.microsoft.com/kb/314058) in the Microsoft Knowledge Base.  
  ## Additional References  
  [Command-Line Syntax Key](command-line-syntax-key.md)  
