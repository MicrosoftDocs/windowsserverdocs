---
title: delete-AutoaddDevices
description: Reference article for delete-AutoaddDevices, which deletes computers that are pending, rejected, or approved from the Auto-add database.
ms.topic: reference
ms.assetid: 8dcaca6a-212e-4c36-98e3-00938eef6b9c
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---
# delete-AutoaddDevices

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Deletes computers that are pending, rejected, or approved from the Auto-add database. This database stores information about these computers on the server.

## Syntax
```
wdsutil /delete-AutoaddDevices [/Server:<Server name>] /Devicetype:{PendingDevices | RejectedDevices |ApprovedDevices}
```
### Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|/Devicetype:{PendingDevices &#124; RejectedDevices &#124;ApprovedDevices}|Specifies the type of computer to delete from the database. This can be any of the following three types:<p>-   **PendingDevices** returns all computers in the database that have a status of pending.<br />-   **RejectedDevices** returns all computers in the database that have a status of rejected.<br />-   **ApprovedDevices** returns all computers that have a status of approved.|
## Examples
To delete all rejected computers, type:
```
wdsutil /delete-AutoaddDevices /Devicetype:RejectedDevices
```
To delete all approved computers, type:
```
wdsutil /verbose /delete-AutoaddDevices /Server:MyWDSServer /Devicetype:ApprovedDevices
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
[Using the Approve-AutoaddDevices Command](using-the-approve-autoadddevices-command.md)
[Using the get-AutoaddDevices Command](using-the-get-autoadddevices-command.md)
[Using The Reject-AutoaddDevices Command](using-the-reject-autoadddevices-command.md)
