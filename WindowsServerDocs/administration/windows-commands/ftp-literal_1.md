---
title: ftp literal_1
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fb81aa2d-07fa-4e79-bf44-1fb5526fdf14 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ftp: literal_1

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012
Sends verbatim arguments to the remote ftp server. A single ftp reply code is returned.   

## Syntax  
```  
literal <Argument> [ ]  
```  
### Parameters  

| Parameter  |                    Description                    |
|------------|---------------------------------------------------|
| <Argument> | Specifies the argument to send to the ftp server. |

## Remarks  
The **literal** command is identical to the **quote** command.  
## <a name="BKMK_Examples"></a>Examples  
Send a **quit** command to the remote ftp server.  
```  
literal quit  
```  
## additional references  
-   [ftp: quote](ftp-quote.md)  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
