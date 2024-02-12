---
title: wdsutil new-namespace
description: Reference article for wdsutil new-namespace, which creates and configures a new namespace.
ms.topic: reference
ms.assetid: 6df60703-30bd-4d59-a8d9-9fe3efe96add
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil new-namespace

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates and configures a new namespace. You should use this option when you have only the Transport Server role service installed. If you have both the Deployment Server role service and the Transport Server role service installed (which is the default), use [wdsutilnew-MulticastTransmission command](wdsutil-new-multicasttransmission.md). Note that you must register the content provider before you use this option.

## Syntax

```
wdsutil [Options] /New-Namespace [/Server:<Server name>]
     /FriendlyName:<Friendly name>
     [/Description:<Description>]
     /Namespace:<Namespace name>
     /ContentProvider:<Name>
     [/ConfigString:<Configuration string>]
     /Namespacetype: {AutoCast | ScheduledCast}
         [/time:<YYYY/MM/DD:hh:mm>]
         [/Clients:<Number of clients>]
```

### Parameters

|Parameter|Description|
|-------|--------|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used.|
|/FriendlyName:\<Friendly name\>|Specifies the friendly name of the namespace.|
|[/Description:\<Description\>]|Sets the description of the namespace.|
|/Namespace:\<Namespace name\>|Specifies the name of the namespace. Note that this is not the friendly name, and it must be unique.<p>-   **Deployment Server role service**: The syntax for this option is /Namespace:WDS:\<Image group\>/\<Image name\>/\<Index\>. For example: **WDS:ImageGroup1/install.wim/1**<br />-   **Transport Server role service**: This value should match the name given when the namespace was created on the server.|
|/ContentProvider:\<Name\>]|Specifies the name of the content provider that will provide content for the namespace.|
|[/ConfigString:\<Configuration string\>]|Specifies the configuration string for the content provider.|
|/Namespacetype: {AutoCast \| ScheduledCast}|Specifies the settings for the transmission. You specify the settings using the following options:<p>-   [/time: \<time\>] - Sets the time that the transmission should start by using the following format: YYYY/MM/DD:hh:mm. This option applies only to Scheduled-Cast transmissions.<br />-   [/Clients: \<Number of clients\>] - Sets the minimum number of clients to wait for before the transmission starts. This option applies only to Scheduled-Cast transmissions.|

## Examples

To create an Auto-Cast namespace, type:

```
wdsutil /New-Namespace /FriendlyName:Custom AutoCast Namespace /Namespace:Custom Auto 1 /ContentProvider:MyContentProvider /Namespacetype:AutoCast
```

To create a Scheduled-Cast namespace, type:

```
wdsutil /New-Namespace /Server:MyWDSServer /FriendlyName:Custom Scheduled Namespace /Namespace:Custom Auto 1 /ContentProvider:MyContentProvider
/Namespacetype:ScheduledCast /time:2006/11/20:17:00 /Clients:20
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil get-allnamespaces command](wdsutil-get-allnamespaces.md)
- [wdsutil remove-namespace command](wdsutil-remove-namespace.md)
- [wdsutil start-namespace command](wdsutil-start-namespace.md)
