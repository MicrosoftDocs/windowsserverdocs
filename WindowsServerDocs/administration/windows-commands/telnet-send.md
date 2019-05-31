---
title: telnet send
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7c217abc-1182-466e-914c-1ff16755021b vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# telnet: send

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sends telnet commands to the telnet server.   
## Syntax  
```  
sen[d] {ao | ayt | brk | esc | ip | synch | <string>} [?]  
```  
### Parameters  

| Parameter |                     Description                      |
|-----------|------------------------------------------------------|
|    ao     |       Sends the telnet command  Abort Output.        |
|    ayt    |       Sends the telnet command  Are You There.       |
|    brk    |            Sends the telnet command  brk.            |
|    esc    |      Sends the current telnet escape character.      |
|    ip     |     Sends the telnet command  Interrupt Process.     |
|   synch   |           Sends the telnet command  synch.           |
| <string>  | Sends whatever string you type to the telnet server. |
|     ?     |     Displays help associated with this command.      |

## <a name="BKMK_Examples"></a>Examples  
Send  Are you there to the telnet server.  
```  
sen ayt  
```  
## additional references  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
