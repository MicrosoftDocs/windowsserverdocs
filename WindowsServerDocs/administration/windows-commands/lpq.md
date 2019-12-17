---
title: lpq
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bb6abcc4-310a-4fa4-927b-4084b62ca02e vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# lpq

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays the status of a print queue on a computer running Line printer Daemon (LPD).  

## Syntax  
```  
lpq -S <ServerName> -P <printerName> [-l]  
```  
## Parameters  

|    Parameter     |                                                                        Description                                                                        |
|------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
| -S <ServerName>  | Specifies (by name or IP address) the computer or printer sharing device that hosts the LPD print queue with a status that you want to display. Required. |
| -P <printerName> |                           Specifies (by name) the printer for the print queue with a status that you want to display. Required.                           |
|        -l        |                                      Specifies that you want to display details about the status of the print queue.                                      |
|        /?        |                                                           Displays help at the command prompt.                                                            |

## Remarks  
The **-S** and **-P** parameters are case sensitive and must be typed in upper-case letters.  
## <a name="BKMK_examples"></a>Examples  
This example shows how to display the status of the Laserprinter1 printer queue on an LPD host at 10.0.0.45:  
```  
lpq -S 10.0.0.45 -P Laserprinter1  
```  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
[print Command Reference](print-command-reference.md)  
