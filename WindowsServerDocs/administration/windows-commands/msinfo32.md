---
title: msinfo32
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a38f31d7-1766-4103-becc-9d0b87c2826d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# msinfo32

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Opens the System Information tool to display a comprehensive view of the hardware, system components, and software environment on the local computer. 
## Syntax
```
msinfo32 [/pch] [/nfo <path>] [/report <path>] [/computer <computerName>] [/showcategories] [/category <CategoryID>] [/categories {+<CategoryID>(+<CategoryID>)|+all(-<CategoryID>)}]
```
### Parameters

|    Parameter    |                                                                                                                                 Description                                                                                                                                  |
|-----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     <path>      | Specifies the file to be opened in the format *C:\Folder1\File1.XXX*, where *C* is the drive letter, *Folder1* is the folder, *File1* is the file name, and *XXX* is the file name extension.<br /><br />This file can be an **.nfo**, **.xml**, **.txt**, or **.cab** file. |
| <computerName>  |                                                                             Specifies the name of the target or local computer. This can be a UNC name, an IP address, or a full computer name.                                                                              |
|  <CategoryID>   |                                                                                     Specifies the ID of the category item. You can obtain the category ID by using **/showcategories**.                                                                                      |
|      /pch       |                                                                                                       Displays the System History view in the System Information tool.                                                                                                       |
|      /nfo       |                                     Saves the exported file as an **.nfo** file. If the file name that is specified in *path* does not end in an **.nfo** extension, the **.nfo** extension is automatically appended to the file name.                                      |
|     /report     |                                               Saves the file in *path* as a text file. The file name is saved exactly as it appears in *path*. The .txt extension is not appended to the file unless it is specified in path.                                                |
|    /computer    |                                                                starts the System Information tool for the specified remote computer. You must have the appropriate permissions to access the remote computer.                                                                |
| /showcategories |                         starts the System Information tool with all available category IDs displayed, rather than displaying the friendly or localized names. For example, the Software Environment category is displayed as the **SWEnv** category.                         |
|    /category    |                                                                     starts System Information with the specified category selected. Use **/showcategories** to display a list of available category IDs.                                                                     |
|   /categories   |                          starts System Information with only the specified category or categories displayed. It also limits the output to the selected category or categories. Use **/showcategories** to display a list of available category IDs.                          |
|       /?        |                                                                                                                     Displays help at the command prompt.                                                                                                                     |

## Remarks
Some System Information categories contain large amounts of data. You can use the **start /wait** command to optimize reporting performance for these categories. For more information, see [System Information](https://technet.microsoft.com/library/cc783305(v=ws.10).aspx).
## <a name="BKMK_Examples"></a>Examples
To list the available category IDs, type:
```
msinfo32 /showcategories
```
To start the System Information tool with all available information displayed, except Loaded Modules, type:
```
msinfo32 /categories +all -loadedmodules
```
To display only System Summary information and create an .nfo file called syssum.nfo that contains information in the System Summary category, type:
```
msinfo32 /nfo syssum.nfo /categories +systemsummary
```
To display resource conflict information and create an .nfo file called conflicts.nfo that contains information about resource conflicts, type:
```
msinfo32 /nfo conflicts.nfo /categories    +componentsproblemdevices+resourcesconflicts+resourcesforcedhardware
```
## additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)

