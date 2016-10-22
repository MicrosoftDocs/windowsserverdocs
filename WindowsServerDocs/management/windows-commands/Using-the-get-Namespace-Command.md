---
title: Using the get-Namespace Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ea641bab-e97b-4909-918e-447730027dc1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Using the get-Namespace Command

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Displays information about a custom namespace.
## Syntax
Windows Server 2008 R2
```
WDSUTIL /Get-Namespace /Namespace:<Namespace name> [/Server:<Server name>] [/Show:Clients]
```
Windows Server 2008 R2
```
WDSUTIL /Get-Namespace /Namespace:<Namespace name> [/Server:<Server name>] [/Details:Clients]
```
## Parameters
|Parameter|Description|
|-------|--------|
|/Namespace:<Namespace name>|Specifies the name of the namespace. Note that this is not the friendly name, and it must be unique.<br /><br />-   Deployment Server: The syntax for namespace name is /Namspace:WDS:<ImageGroup>/<ImageName>/<Index>. For example: **WDS:ImageGroup1/install.wim/1**<br />-   Transport Server: This value should match the name given to the namespace when it was created on the server.|
|[/Server:<Server name>]|Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used.|
|[/Show:Clients] or [/Details:Clients]|Displays information about client computers that are connected to the specified namespace.|
## <a name="BKMK_examples"></a>Examples
To view information about a namespace, type:
```
WDSUTIL /Get-Namespace /Namespace:"Custom Auto 1"
```
To view information about a namespace and the clients that are connected, type one of the following:
-   Windows Server 2008: `WDSUTIL /Get-Namespace /Server:MyWDSServer /Namespace:"Custom Auto 1" /Show:Clients`
-   Windows Server 2008 R2: `WDSUTIL /Get-Namespace /Server:MyWDSServer /Namespace:"Custom Auto 1" /Details:Clients`
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the get-AllNamespaces Command](Using-the-get-AllNamespaces-Command.md)
[Using the new-Namespace Command](Using-the-new-Namespace-Command.md)
[Using the remove-Namespace Command](Using-the-remove-Namespace-Command.md)
[Subcommand: start-Namespace](Subcommand-start-Namespace.md)
