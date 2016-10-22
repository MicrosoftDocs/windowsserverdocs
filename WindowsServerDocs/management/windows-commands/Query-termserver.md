---
title: Query termserver
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3b89d3b4-236f-4376-90b6-939a0ec4b288
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Query termserver

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Displays a list of all Remote Desktop Session Host (RD Session Host) servers on the network.
For examples of how to use this command, see [Examples](#BKMK_examples).
> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What s New in Remote Desktop Services in Windows Server 2012](http://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.
## Syntax
```
query termserver [<ServerName>] [/domain:<Domain>] [/address] [/continue]
```
## Parameters
|Parameter|Description|
|-------|--------|
|<ServerName>|Specifies the name that identifies the RD Session Host server.|
|/domain:<Domain>|Specifies the domain to query for terminal servers. You do not need to specify a domain if you are querying the domain in which you are currently working.|
|/address|Displays the network and node addresses for each server.|
|/continue|Prevents pausing after each screen of information is displayed.|
|/?|Displays help at the command prompt.|
## Remarks
-   **Query termserver** searches the network for all attached RD Session Host servers and returns the following information:
    -   The name of the server
    -   The network (and node address if the /address option is used)
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
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Query](Query.md)
[Remote Desktop Services &#40;Terminal Services&#41; Command Reference](Remote-Desktop-Services-Terminal-Services-Command-Reference.md)
