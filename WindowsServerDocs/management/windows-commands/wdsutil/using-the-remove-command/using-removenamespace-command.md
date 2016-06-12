---
title: Using the remove-Namespace Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4eb758b6-8519-4e26-9fe0-2e19bb0e8702
---
# Using the remove-Namespace Command
removes a custom namespace.

## Syntax

```
wdsutil /remove-Namespace /Namespace:<Namespace name> [/Server:<Server name>] [/force]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\/Namespace:<Namespace name>|Specifies the name of the namespace. This is not the friendly name, and it must be unique.<br /><br />-   **deployment Server role service**: The syntax for namespace name is \/Namespace:WDS:<ImageGroup>\/<ImageName>\/<Index>. for example: **WDS:ImageGroup1\/install.wim\/1**<br />-   **Transport Server role service**: This value must match the name given to the namespace when it was created on the server.|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name \(FQDN\). if no server name is specified, the local server is used.|
|\[\/force\]|removes the namespace immediately and terminates all clients. Note that unless you specify **\/force**, existing clients can complete the transfer, but new clients are not able to join.|

## <a name="BKMK_examples"></a>Examples
To stop a namespace \(current clients can complete the transfer but new clients are not able to join\), type:

```
wdsutil /remove-Namespace /Namespace:"Custom Auto 1"
```

To force termination of all clients, type:

```
wdsutil /remove-Namespace /Server:MyWDSServer /Namespace:"Custom Auto 1" /force
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the get-AllNamespaces Command](../using-get-command/using-getallnamespaces-command.md)

[Using the new-Namespace Command](../using-new-command/using-newnamespace-command.md)

[Subcommand: start-Namespace](../the-start-server-command/subcommand-startnamespace.md)


