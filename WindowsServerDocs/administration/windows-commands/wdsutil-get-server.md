---
title: wdsutil get-server
description: Reference article for wdsutil get-server, which retrieves information from the specified Windows Deployment Services server.
ms.topic: reference
ms.assetid: bef60db4-d58d-4304-ab4b-be53dd3271c3
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil get-server

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves information from the specified Windows Deployment Services server.

## Syntax

```
wdsutil [Options] /Get-Server [/Server:<Server name>] /Show:{Config | Images | All} [/detailed]
```

### Parameters

|Parameter|Description|
|-------|--------|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used.|
|/Show:{Config \| Images \| All}|Specifies the type of information to return.<p>-   **Config** returns configuration information.<br />-   **Images** returns information about image groups, boot images, and install images.<br />-   **All** returns configuration information and image information.|
|[/detailed]|You can use this option with **/Show:Images** or **/Show:All** to indicate that all image metadata from each image should be returned. If the **/detailed** option is not used, the default behavior is to return the image name, description, and file name.|

## Examples

To view information about the server, type:

```
wdsutil /Get-Server /Show:Config
```

To view detailed information about the server, type:

```
wdsutil /verbose /Get-Server /Server:MyWDSServer /Show:All /detailed
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil disable-server command](wdsutil-disable-server.md)
- [wdsutil enable-server command](wdsutil-enable-server.md)
- [wdsutil initialize-server command](wdsutil-initialize-server.md)
- [wdsutil set-server command](wdsutil-set-server.md)
- [wdsutil start-server command](wdsutil-start-server.md)
- [wdsutil stop-server command](wdsutil-stop-server.md)
- [wdsutil uninitialize-server command](wdsutil-uninitialize-server.md)
