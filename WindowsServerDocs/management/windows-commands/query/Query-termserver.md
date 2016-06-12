---
title: query termserver
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3b89d3b4-236f-4376-90b6-939a0ec4b288
---
# query termserver
Displays a list of all remote Desktop Session Host \(rd Session Host\) servers on the network.

for examples of how to use this command, see [Examples](#BKMK_examples).

> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed remote Desktop Services. To find out what's new in the latest version, see [What’s New in remote Desktop Services in Windows Server 2012](http://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.

## Syntax

```
query termserver [<ServerName>] [/domain:<Domain>] [/address] [/continue]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|<ServerName>|Specifies the name that identifies the rd Session Host server.|
|\/domain:<Domain>|Specifies the domain to query for terminal servers. You do not need to specify a domain if you are querying the domain in which you are currently working.|
|\/address|Displays the network and node addresses for each server.|
|\/continue|Prevents pausing after each screen of information is displayed.|
|\/?|Displays help at the command prompt.|

## remarks

-   **query termserver** searches the network for all attached rd Session Host servers and returns the following information:

    -   The name of the server

    -   The network \(and node address if the \/address option is used\)

## <a name="BKMK_examples"></a>Examples

-   To display information about all rd Session Host servers on the network, type:

    ```
    query termserver
    ```

-   To display information about the rd Session Host server named Server3, type:

    ```
    query termserver Server3
    ```

-   To display information about all rd Session Host servers in domain CONTOSO, type:

    ```
    query termserver /domain:CONTOSO
    ```

-   To display the network and node address for the rd Session Host server named Server3, type:

    ```
    query termserver Server3 /address
    ```

#### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)

[query](../query.md)

[remote Desktop Services &#40;Terminal Services&#41; Command Reference](../commands-by-server-role/remote-desktop-services-terminal-services-command-reference.md)


