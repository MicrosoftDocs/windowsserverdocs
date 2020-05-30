---
title: query termserver
description: Reference topic for **** -

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 3b89d3b4-236f-4376-90b6-939a0ec4b288
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# query termserver

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays a list of all Remote Desktop Session Host (rd Session Host) servers on the network.

> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What s New in Remote Desktop Services in Windows Server 2012](https://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.
> ## Syntax
> ```
> query termserver [<ServerName>] [/domain:<Domain>] [/address] [/continue]
> ```
> ### Parameters
>
> |    Parameter     |                                                                        Description                                                                         |
> |------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
> |   <ServerName>   |                                               Specifies the name that identifies the rd Session Host server.                                               |
> | /domain:<Domain> | Specifies the domain to query for terminal servers. You do not need to specify a domain if you are querying the domain in which you are currently working. |
> |     /address     |                                                  Displays the network and node addresses for each server.                                                  |
> |    /continue     |                                              Prevents pausing after each screen of information is displayed.                                               |
> |        /?        |                                                            Displays help at the command prompt.                                                            |
>
>#### Remarks
> - **query termserver** searches the network for all attached rd Session Host servers and returns the following information:
>   - The name of the server
>   - The network (and node address if the /address option is used)
>     ## Examples
> - To display information about all rd Session Host servers on the network, type:
>   ```
>   query termserver
>   ```
> - To display information about the rd Session Host server named Server3, type:
>   ```
>   query termserver Server3
>   ```
> - To display information about all rd Session Host servers in domain CONTOSO, type:
>   ```
>   query termserver /domain:CONTOSO
>   ```
> - To display the network and node address for the rd Session Host server named Server3, type:
>   ```
>   query termserver Server3 /address
>   ```
>   ## Additional References
>   - [Command-Line Syntax Key](command-line-syntax-key.md)
>   [query](query.md)
>   [Remote Desktop Services (Terminal Services) Command Reference](remote-desktop-services-terminal-services-command-reference.md)
