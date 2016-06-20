---
title: Subcommand: start-Namespace
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2dd1c11e-6ab7-4129-9e3a-3f80e0ba59c0
---
# Subcommand: start-Namespace
Starts a Scheduled\-Cast namespace.

## Syntax

```
WDSUTIL /Start-Namespace /Namespace:<Namespace name> [/Server:<Server name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\/Namespace:<Namespace name>|Specifies the name of the namespace. Note that this is not the friendly name, and it must be unique.<br /><br />-   **Deployment Server**: The syntax for namespace name is \/Namspace:WDS:<Image group>\/<Image name>\/<Index>. For example: **WDS:ImageGroup1\/install.wim\/1**<br />-   **Transport Server**: This name must match the name given to the namespace when it was created on the server.|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). If no server name is specified, the local server will be used.|

## <a name="BKMK_examples"></a>Examples
To start a namespace, type one of the following:

```
WDSUTIL /Start-Namespace /Namespace:"Custom Auto 1"
WDSUTIL /Start-Namespace /Server:MyWDSServer /Namespace:"Custom Auto 1"
```

#### Additional references
[Command-Line Syntax Key](../../Command-Line-Syntax-Key.md)

[Using the get-AllNamespaces Command](../using-the-get-command/Using-the-get-AllNamespaces-Command.md)

[Using the new-Namespace Command](../using-the-new-command/Using-the-new-Namespace-Command.md)

[Using the remove-Namespace Command](../using-the-remove-command/Using-the-remove-Namespace-Command.md)


