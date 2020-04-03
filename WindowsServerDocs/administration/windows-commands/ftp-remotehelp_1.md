---
title: ftp remotehelp_1
description: Windows Commands topic for **** - 

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: ef23adf3-ead4-44c8-ac1d-c8a6f4b2bf73 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ftp: remotehelp_1

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays help for remote commands.   
## Syntax  
```  
remotehelp [<Command>]  
```  
#### Parameters  
|Parameter|Description|  
|-------|--------|  
|[<Command>]|Specifies the name of the command about which you want help. If *Command* is not specified, **ftp** displays a list of all remote commands.|  
## Remarks  
You can run remote commands using **quote** or **literal**.  
## <a name=BKMK_Examples></a>Examples  
Display a list of remote commands.  
```  
remotehelp  
```  
Display the syntax for the **feat** remote command.  
```  
remotehelp feat  
```  
## Additional References  
-   [ftp: quote](ftp-quote.md)  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
