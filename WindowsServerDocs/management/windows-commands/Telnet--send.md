---
title: Telnet: send
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7c217abc-1182-466e-914c-1ff16755021b vhorne
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Telnet: send
Sends Telnet commands to the Telnet server. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
## Syntax  
```  
sen[d] {ao | ayt | brk | esc | ip | synch | <string>} [?]  
```  
### Parameters  
|Parameter|Description|  
|-------------|---------------|  
|ao|Sends the Telnet command “Abort Output�?.|  
|ayt|Sends the Telnet command “Are You There�?.|  
|brk|Sends the Telnet command “brk�?.|  
|esc|Sends the current Telnet escape character.|  
|ip|Sends the Telnet command “Interrupt Process�?.|  
|synch|Sends the Telnet command “synch�?.|  
|<string>|Sends whatever string you type to the Telnet server.|  
|?|Displays Help associated with this command.|  
## <a name="BKMK_Examples"></a>Examples  
Send “Are you there�? to the Telnet server.  
```  
sen ayt  
```  
## Additional references  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
