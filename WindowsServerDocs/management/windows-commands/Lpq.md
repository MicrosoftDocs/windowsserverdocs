---
title: Lpq
description: "Windows Commands topic for **** -- "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bb6abcc4-310a-4fa4-927b-4084b62ca02e vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Lpq

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Displays the status of a print queue on a computer running Line Printer Daemon (LPD).  
  
## Syntax  
```  
Lpq -S <ServerName> -P <PrinterName> [-l]  
```  
## Parameters  
|Parameter|Description|  
|-------------|---------------|  
|-S <ServerName>|Specifies (by name or IP address) the computer or printer sharing device that hosts the LPD print queue with a status that you want to display. Required.|  
|-P <PrinterName>|Specifies (by name) the printer for the print queue with a status that you want to display. Required.|  
|-l|Specifies that you want to display details about the status of the print queue.|  
|/?|Displays help at the command prompt.|  
## Remarks  
The **-S** and **-P** parameters are case sensitive and must be typed in upper-case letters.  
## <a name="BKMK_examples"></a>Examples  
This example shows how to display the status of the LaserPrinter1 printer queue on an LPD host at 10.0.0.45:  
```  
Lpq -S 10.0.0.45 -P LaserPrinter1  
```  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
[Print Command Reference](Print-Command-Reference.md)  
