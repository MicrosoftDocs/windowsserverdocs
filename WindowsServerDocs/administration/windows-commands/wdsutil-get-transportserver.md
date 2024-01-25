---
title: wdsutil get-transportserver
description: Reference article for wdsutil get-transportserver, which displays information about a specified Transport Server.
ms.topic: reference
ms.assetid: de634123-0179-41b2-9c6f-726508130ff5
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil get-transportserver

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays information about a specified Transport Server.

## Syntax

```
wdsutil [Options] /Get-TransportServer [/Server:<Server name>] /Show:{Config}
```

### Parameters

|Parameter|Description|
|-------|--------|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|/Show:{Config}|Returns configuration information about the specified Transport Server.|

## Examples

To view information about the server, type:

```
wdsutil /Get-TransportServer /Show:Config
```

To view configuration information, type:

```
wdsutil /Get-TransportServer /Server:MyWDSServer /Show:Config
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil disable-transportserver command](wdsutil-disable-transportserver.md)
- [wdsutil enable-transportserver command](wdsutil-enable-transportserver.md)
- [wdsutil set-transportserver command](wdsutil-set-transportserver.md)
- [wdsutil start-transportserver command](wdsutil-start-transportserver.md)
- [wdsutil stop-transportserver command](wdsutil-stop-transportserver.md)
