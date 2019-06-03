---
title: ftp mput_1
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 980f15e7-7cf1-4813-9946-a8cc4edfb198 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ftp: mput_1

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Copies local files to the remote computer using the current file transfer type.   
## Syntax  
```  
mput <LocalFile>[ ]  
```  
### Parameters  

|  Parameter  |                       Description                        |
|-------------|----------------------------------------------------------|
| <LocalFile> | Specifies the local file to copy to the remote computer. |

## <a name="BKMK_Examples"></a>Examples  
copy **Program1.exe** and **Program2.exe** to the remote computer using the current file transfer type.  
```  
mput Program1.exe Program2.exe  
```  
## additional references  
-   [ftp: ascii](ftp-ascii.md)  
-   [ftp: binary](ftp-binary.md)  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
