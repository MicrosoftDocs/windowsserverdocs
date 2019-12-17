---
title: ftp quote
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4500a1d3-c091-42c7-a909-f61df7f2e993 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ftp: quote

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sends verbatim arguments to the remote ftp server. A single ftp reply code is returned.   
## Syntax  
```  
quote <Argument>[ ]  
```  
### Parameters  

| Parameter  |                    Description                    |
|------------|---------------------------------------------------|
| <Argument> | Specifies the argument to send to the ftp server. |

## Remarks  
The **quote** command is identical to the **literal** command.  
## <a name="BKMK_Examples"></a>Examples  
Send a **quit** command to the remote ftp server.  
```  
quote quit  
```  
## additional references  
-   [ftp: literal_1](ftp-literal_1.md)  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
