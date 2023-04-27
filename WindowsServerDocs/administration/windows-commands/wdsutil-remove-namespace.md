---
title: wdsutil remove-namespace
description: Reference article for wdsutil remove-namespace, which removes a custom namespace.
ms.topic: reference
ms.assetid: 4eb758b6-8519-4e26-9fe0-2e19bb0e8702
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil remove-namespace

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Removes a custom namespace.

## Syntax
```
wdsutil /remove-Namespace /Namespace:<Namespace name> [/Server:<Server name>] [/force]
```
### Parameters

|Parameter|Description|
|-------|--------|
|/Namespace:\<Namespace name\>|Specifies the name of the namespace. This is not the friendly name, and it must be unique.<p>-   **Deployment Server role service**: The syntax for namespace name is /Namespace:WDS:\<ImageGroup\>/\<ImageName\>/\<Index\>. For example: **WDS:ImageGroup1/install.wim/1**<br />-   **Transport Server role service**: This value must match the name given to the namespace when it was created on the server.|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used.|
|[/force]|removes the namespace immediately and terminates all clients. Note that unless you specify **/force**, existing clients can complete the transfer, but new clients are not able to join.|

## Examples
To stop a namespace (current clients can complete the transfer but new clients are not able to join), type:
```
wdsutil /remove-Namespace /Namespace:Custom Auto 1
```
To force termination of all clients, type:
```
wdsutil /remove-Namespace /Server:MyWDSServer /Namespace:Custom Auto 1 /force
```
## Related links
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil get-allnamespaces command](wdsutil-get-allnamespaces.md)
- [wdsutil new-namespace command](wdsutil-new-namespace.md)
- [wdsutil start-namespace command](wdsutil-start-namespace.md)
