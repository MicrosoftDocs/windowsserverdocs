---
title: Query termserver
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3b89d3b4-236f-4376-90b6-939a0ec4b288
author: jaimeo
---
# Query termserver
Displays a list of all Remote Desktop Session Host \(RD Session Host\) servers on the network.  
  
For examples of how to use this command, see [Examples](#BKMK_examples).  
  
> [!NOTE]  
> [!INCLUDE[rd_note-cmd-line-ref](../Token/rd_note-cmd-line-ref_md.md)]  
  
## Syntax  
  
```  
query termserver [<ServerName>] [/domain:<Domain>] [/address] [/continue]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<ServerName>|Specifies the name that identifies the RD Session Host server.|  
|\/domain:<Domain>|Specifies the domain to query for terminal servers. You do not need to specify a domain if you are querying the domain in which you are currently working.|  
|\/address|Displays the network and node addresses for each server.|  
|\/continue|Prevents pausing after each screen of information is displayed.|  
|\/?|Displays help at the command prompt.|  
  
## Remarks  
  
-   **Query termserver** searches the network for all attached RD Session Host servers and returns the following information:  
  
    -   The name of the server  
  
    -   The network \(and node address if the \/address option is used\)  
  
## <a name="BKMK_examples"></a>Examples  
  
-   To display information about all RD Session Host servers on the network, type:  
  
    ```  
    query termserver  
    ```  
  
-   To display information about the RD Session Host server named Server3, type:  
  
    ```  
    query termserver Server3  
    ```  
  
-   To display information about all RD Session Host servers in domain CONTOSO, type:  
  
    ```  
    query termserver /domain:CONTOSO  
    ```  
  
-   To display the network and node address for the RD Session Host server named Server3, type:  
  
    ```  
    query termserver Server3 /address  
    ```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Query](../Topic/Query.md)  
  
[Remote Desktop Services &#40;Terminal Services&#41; Command Reference](../Topic/Remote-Desktop-Services--Terminal-Services--Command-Reference.md)  
  
