---
title: Using the remove-Namespace Command
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4eb758b6-8519-4e26-9fe0-2e19bb0e8702
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Using the remove-Namespace Command
Removes a custom namespace.
## Syntax
```
WDSUTIL /Remove-Namespace /Namespace:<Namespace name> [/Server:<Server name>] [/Force]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|/Namespace:<Namespace name>|Specifies the name of the namespace. This is not the friendly name, and it must be unique.<br /><br />-   **Deployment Server role service**: The syntax for namespace name is /Namespace:WDS:<ImageGroup>/<ImageName>/<Index>. For example: **WDS:ImageGroup1/install.wim/1**<br />-   **Transport Server role service**: This value must match the name given to the namespace when it was created on the server.|
|[/Server:<Server name>]|Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used.|
|[/Force]|Removes the namespace immediately and terminates all clients. Note that unless you specify **/Force**, existing clients can complete the transfer, but new clients are not able to join.|
## <a name="BKMK_examples"></a>Examples
To stop a namespace (current clients can complete the transfer but new clients are not able to join), type:
```
WDSUTIL /Remove-Namespace /Namespace:"Custom Auto 1"
```
To force termination of all clients, type:
```
WDSUTIL /Remove-Namespace /Server:MyWDSServer /Namespace:"Custom Auto 1" /Force
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the get-AllNamespaces Command](Using-the-get-AllNamespaces-Command.md)
[Using the new-Namespace Command](Using-the-new-Namespace-Command.md)
[Subcommand: start-Namespace](Subcommand--start-Namespace.md)
