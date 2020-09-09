---
title: Reject-AutoaddDevices
description: Reference article for Reject-AutoaddDevices, which rejects computers that are pending administrative approval.
ms.topic: reference
ms.assetid: ea25a4b2-5fad-4360-9c47-c2c9df7ea31f
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---
# Reject-AutoaddDevices

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Rejects computers that are pending administrative approval. When the Auto-add policy is enabled, administrative approval is required before unknown computers (those that are not prestaged) can install an image. You can enable this policy using the **PXE Response** tab of the server s properties page.
## Syntax
```
wdsutil [Options] /Reject-AutoaddDevices [/Server:<Server name>] /RequestId:<Request ID or ALL>
```
### Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|/RequestId:<Request ID &#124; ALL>|Specifies the request ID assigned to the pending computer. To reject all pending computers, specify **ALL**.|
## Examples
To reject a single computer, type:
```
wdsutil /Reject-AutoaddDevices /RequestId:12
```
To reject all computers, type:
```
wdsutil /verbose /Reject-AutoaddDevices /Server:MyWDSServer /RequestId:ALL
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
[Using the Approve-AutoaddDevices Command](using-the-approve-autoadddevices-command.md)
[Using the delete-AutoaddDevices Command](using-the-delete-autoadddevices-command.md)
[Using the get-AutoaddDevices Command](using-the-get-autoadddevices-command.md)
