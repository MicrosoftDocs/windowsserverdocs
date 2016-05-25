---
title: Ftp: remotehelp_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ef23adf3-ead4-44c8-ac1d-c8a6f4b2bf73
author: vhorne
---
# Ftp: remotehelp_1
Displays help for remote commands. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
remotehelp [<Command>]  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\[<Command>\]|Specifies the name of the command about which you want help. If *Command* is not specified, **ftp** displays a list of all remote commands.|  
  
## Remarks  
You can run remote commands using **quote** or **literal**.  
  
## <a name="BKMK_Examples"></a>Examples  
Display a list of remote commands.  
  
```  
remotehelp  
```  
  
Display the syntax for the **feat** remote command.  
  
```  
remotehelp feat  
```  
  
## Additional references  
  
-   [Ftp: quote](../Topic/Ftp--quote.md)  
  
-   [Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
