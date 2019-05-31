---
title: ftp open_1
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4b61926a-dc60-4b4c-96d3-64e5c91c18ba vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ftp: open_1

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Connects to the specified ftp server.   
## Syntax  
```  
open <computer> [<Port>]  
```  
### Parameters  

| Parameter  |                                           Description                                            |
|------------|--------------------------------------------------------------------------------------------------|
| <computer> |                Specifies the remote computer to which you are trying to connect.                 |
|  [<Port>]  | Specifies a TCP port number to use to connect to an ftp server. By default, TCP port 21 is used. |

## Remarks  
You can use an IP address or computer name (in which case a DNS server or Hosts file must be available) to specify **computer**.  
## <a name="BKMK_Examples"></a>Examples  
Connect to the ftp server at **ftp.microsoft.com**.  
```  
Open ftp.microsoft.com  
```  
Connect to the ftp server at **ftp.microsoft.com** that is listening on TCP port 755.  
```  
open ftp.microsoft.com 755  
```  
## additional references  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
