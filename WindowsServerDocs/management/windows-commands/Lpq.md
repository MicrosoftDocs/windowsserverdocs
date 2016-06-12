---
title: lpq
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bb6abcc4-310a-4fa4-927b-4084b62ca02e
author: vhorne
---
# lpq
Displays the status of a print queue on a computer running Line printer Daemon \(LPD\).  
  
for examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
lpq -S <ServerName> -P <printerName> [-l]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\-S <ServerName>|Specifies \(by name or IP address\) the computer or printer sharing device that hosts the LPD print queue with a status that you want to display. Required.|  
|\-P <printerName>|Specifies \(by name\) the printer for the print queue with a status that you want to display. Required.|  
|\-l|Specifies that you want to display details about the status of the print queue.|  
|\/?|Displays help at the command prompt.|  
  
## remarks  
The **\-S** and **\-P** parameters are case sensitive and must be typed in upper\-case letters.  
  
## <a name="BKMK_examples"></a>Examples  
This example shows how to display the status of the Laserprinter1 printer queue on an LPD host at 10.0.0.45:  
  
```  
lpq -S 10.0.0.45 -P Laserprinter1  
```  
  
#### additional references  
[Command-Line Syntax Key](commandline-syntax-key.md)  
  
[print Command Reference]()  
  

