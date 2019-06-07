---
title: ftp rename
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 977b7c95-6428-4980-80ec-79c3ae7e8c4d vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ftp: rename

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

renames remote files.   
## Syntax  
```  
rename <FileName> <NewFileName>  
```  
### Parameters  

|   Parameter   |                 Description                 |
|---------------|---------------------------------------------|
|  <FileName>   | Specifies the file that you want to rename. |
| <NewFileName> |        Specifies the new file name.         |

## <a name="BKMK_Examples"></a>Examples  
rename the remote file **example.txt** to **example1.txt**  
```  
rename example.txt example1.txt  
```  
## additional references  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
