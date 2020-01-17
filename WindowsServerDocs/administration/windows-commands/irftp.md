---
title: irftp
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e15c60a7-546d-4e9f-9871-43aaa1b569d6 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# irftp

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sends files over an infrared link.    
## Syntax  
```  
irftp [<Drive>:\] [[<path>] <FileName>] [/h][/s]  
```  

### Parameters  
|Parameter|Description|  
|-------|--------|  
|Drive:\|Specifies the drive that contains the files that you want to send over an infrared link.|  
|[path]FileName|Specifies the location and name of the file or set of files that you want to send over an infrared link. If you specify a set of files, you must specify the full path for each file.|  
|/h|Specifies hidden mode. When hidden mode is used, the files are sent without displaying the Wireless Link dialog box.|  
|/s|Opens the Wireless Link dialog box, so that you can select the file or set of files that you want to send without using the command line to specify the drive, path, and file names.|  

## Remarks  
-   Before using this command, verify that the devices that you want to communicate over an infrared link have infrared functionality enabled and working correctly, and that an infrared link is established between the devices.  
-   Used without parameters or used with **/s**, **irftp** opens the **Wireless Link** dialog box, where you can select the files that you want to send without using the command line.  

## <a name="BKMK_Examples"></a>Examples  
Send Example.txt over the infrared link.  
```  
irftp c:\example.txt  
```  

## additional references  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
