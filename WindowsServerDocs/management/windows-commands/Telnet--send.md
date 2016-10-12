---
title: Telnet: send
description: "Windows Commands"
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
ms.date: 10/12/2016
---

# Telnet: send

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Sends Telnet commands to the Telnet server.   
## Syntax  
```  
sen[d] {ao | ayt | brk | esc | ip | synch | <string>} [?]  
```  
### Parameters  
|Parameter|Description|  
|-------------|---------------|  
|ao|Sends the Telnet command ???Abort Output????.|  
|ayt|Sends the Telnet command ???Are You There????.|  
|brk|Sends the Telnet command ???brk????.|  
|esc|Sends the current Telnet escape character.|  
|ip|Sends the Telnet command ???Interrupt Process????.|  
|synch|Sends the Telnet command ???synch????.|  
|<string>|Sends whatever string you type to the Telnet server.|  
|?|Displays Help associated with this command.|  
## <a name="BKMK_Examples"></a>Examples  
Send ???Are you there???? to the Telnet server.  
```  
sen ayt  
```  
## Additional references  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
