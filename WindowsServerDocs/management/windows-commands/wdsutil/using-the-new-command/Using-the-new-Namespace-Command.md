---
title: Using the new-Namespace Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6df60703-30bd-4d59-a8d9-9fe3efe96add
---
# Using the new-Namespace Command
Creates and configures a new namespace. You should use this option when you have only the Transport Server role service installed. If you have both the Deployment Server role service and the Transport Server role service installed \(which is the default\), use [Using the new-MulticastTransmission Command](Using-the-new-MulticastTransmission-Command.md). Note that you must register the content provider before you use this option.

## Syntax

```
WDSUTIL [Options] /New-Namespace [/Server:<Server name>]
     /FriendlyName:<Friendly name>
     [/Description:<Description>]
     /Namespace:<Namespace name>
     /ContentProvider:<Name>
     [/ConfigString:<Configuration string>]
     /NamespaceType: {AutoCast | ScheduledCast}
         [/Time:<YYYY/MM/DD:hh:mm>]
         [/Clients:<Number of clients>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name \(FQDN\). If no server name is specified, the local server is used.|
|\/FriendlyName:<Friendly name>|Specifies the friendly name of the namespace.|
|\[\/Description:<Description>\]|Sets the description of the namespace.|
|\/Namespace:<Namespace name>|Specifies the name of the namespace. Note that this is not the friendly name, and it must be unique.<br /><br />-   **Deployment Server role service**: The syntax for this option is \/Namespace:WDS:<Image group>\/<Image name>\/<Index>. For example: **WDS:ImageGroup1\/install.wim\/1**<br />-   **Transport Server role service**: This value should match the name given when the namespace was created on the server.|
|\/ContentProvider:<Name>\]|Specifies the name of the content provider that will provide content for the namespace.|
|\[\/ConfigString:<Configuration string>\]|Specifies the configuration string for the content provider.|
|\/NamespaceType: {AutoCast &#124; ScheduledCast}|Specifies the settings for the transmission. You specify the settings using the following options:<br /><br />-   \[\/Time: <time>\] \- Sets the time that the transmission should start by using the following format: YYYY\/MM\/DD:hh:mm. This option applies only to Scheduled\-Cast transmissions.<br />-   \[\/Clients: <Number of clients>\] \- Sets the minimum number of clients to wait for before the transmission starts. This option applies only to Scheduled\-Cast transmissions.|

## <a name="BKMK_examples"></a>Examples
To create an Auto\-Cast namespace, type:

```
WDSUTIL /New-Namespace /FriendlyName:"Custom AutoCast Namespace" /Namespace:"Custom Auto 1" /ContentProvider:MyContentProvider /NamespaceType:AutoCast
```

To create a Scheduled\-Cast namespace, type:

```
WDSUTIL /New-Namespace /Server:MyWDSServer /FriendlyName:"Custom Scheduled Namespace" /Namespace:"Custom Auto 1" /ContentProvider:MyContentProvider 
/NamespaceType:ScheduledCast /Time:"2006/11/20:17:00" /Clients:20
```

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Using the get-AllNamespaces Command](Using-the-get-AllNamespaces-Command.md)

[Using the remove-Namespace Command](Using-the-remove-Namespace-Command.md)

[Subcommand: start-Namespace](Subcommand--start-Namespace.md)


