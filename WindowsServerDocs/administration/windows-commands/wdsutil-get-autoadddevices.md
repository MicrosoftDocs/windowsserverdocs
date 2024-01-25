---
title:  wdsutil get-autoadddevices
description: Reference article for wdsutil get-autoadddevices, which displays all computers that are in the Auto-add database on a Windows Deployment Services server.
ms.topic: reference
ms.assetid: 24b4b688-55b0-4bd9-a2f5-7ef4b3dfe2f2
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil get-autoadddevices

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays all computers that are in the Auto-add database on a Windows Deployment Services server.

## Syntax

```
wdsutil [Options] /Get-AutoaddDevices [/Server:<Server name>] /Devicetype:{PendingDevices | RejectedDevices | ApprovedDevices}
```

### Parameters

|Parameter|Description|
|-------|--------|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|/Devicetype:{PendingDevices \| RejectedDevices \| ApprovedDevices}|Specifies the type of computer to return.<p>-   **PendingDevices** returns all computers in the database that have a status of pending.<br />-   **RejectedDevices** returns all computers in the database that have a status of rejected.<br />-   **ApprovedDevices** returns all computers in the database that have a status of approved.|

## Examples

To see all of the approved computers, type:

```
wdsutil /Get-AutoaddDevices /Devicetype:ApprovedDevices
```

To see all of the rejected computers, type:

```
wdsutil /verbose /Get-AutoaddDevices /Devicetype:RejectedDevices /Server:MyWDSServer
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil delete-autoadddevices command](wdsutil-delete-autoadddevices.md)
- [wdsutil approve-autoadddevices command](wdsutil-approve-autoadddevices.md)
- [wdsutil reject-autoadddevices command](wdsutil-reject-autoadddevices.md)
