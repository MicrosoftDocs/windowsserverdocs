---
title: Ftp: quote
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4500a1d3-c091-42c7-a909-f61df7f2e993 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Ftp: quote

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Sends verbatim arguments to the remote FTP server. A single FTP reply code is returned.   
## Syntax  
```  
quote <Argument>[???]  
```  
### Parameters  
|Parameter|Description|  
|-------------|---------------|  
|<Argument>|Specifies the argument to send to the FTP server.|  
## Remarks  
The **quote** command is identical to the **literal** command.  
## <a name="BKMK_Examples"></a>Examples  
Send a **quit** command to the remote FTP server.  
```  
quote quit  
```  
## Additional references  
-   [Ftp: literal_1](Ftp--literal_1.md)  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
