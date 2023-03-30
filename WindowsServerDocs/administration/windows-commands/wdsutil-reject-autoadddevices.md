---
title: wdsutil reject-autoadddevices
description: Reference article for wdsutil reject-autoadddevices, which rejects computers that are pending administrative approval.
ms.topic: reference
ms.assetid: ea25a4b2-5fad-4360-9c47-c2c9df7ea31f
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil reject-autoadddevices

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Rejects computers that are pending administrative approval. When the Auto-add policy is enabled, administrative approval is required before unknown computers (those that are not prestaged) can install an image. You can enable this policy using the **PXE Response** tab of the server s properties page.

## Syntax

```
wdsutil [Options] /Reject-AutoaddDevices [/Server:<Server name>] /RequestId:<Request ID or ALL>
```

### Parameters

|Parameter|Description|
|-------|--------|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|/RequestId:\<Request ID \| ALL\>|Specifies the request ID assigned to the pending computer. To reject all pending computers, specify **ALL**.|

## Examples

To reject a single computer, type:

```
wdsutil /Reject-AutoaddDevices /RequestId:12
```

To reject all computers, type:

```
wdsutil /verbose /Reject-AutoaddDevices /Server:MyWDSServer /RequestId:ALL
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil approve-autoadddevices command](wdsutil-approve-autoadddevices.md)
- [wdsutil delete-autoadddevices command](wdsutil-delete-autoadddevices.md)
- [wdsutil get-autoadddevices command](wdsutil-get-autoadddevices.md)
