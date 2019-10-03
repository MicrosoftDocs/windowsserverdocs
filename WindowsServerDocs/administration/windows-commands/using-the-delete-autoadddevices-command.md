---
title: Using the delete-AutoaddDevices Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8dcaca6a-212e-4c36-98e3-00938eef6b9c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Using the delete-AutoaddDevices Command

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

deletes computers that are pending, rejected, or approved from the Auto-add database. This database stores information about these computers on the server.
## Syntax
```
wdsutil /delete-AutoaddDevices [/Server:<Server name>] /Devicetype:{PendingDevices | RejectedDevices |ApprovedDevices}
```
## Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|/Devicetype:{PendingDevices &#124; RejectedDevices &#124;ApprovedDevices}|Specifies the type of computer to delete from the database. This can be any of the following three types:<br /><br />-   **PendingDevices** returns all computers in the database that have a status of pending.<br />-   **RejectedDevices** returns all computers in the database that have a status of rejected.<br />-   **ApprovedDevices** returns all computers that have a status of approved.|
## <a name="BKMK_examples"></a>Examples
To delete all rejected computers, type:
```
wdsutil /delete-AutoaddDevices /Devicetype:RejectedDevices
```
To delete all approved computers, type:
```
wdsutil /verbose /delete-AutoaddDevices /Server:MyWDSServer /Devicetype:ApprovedDevices
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Using the Approve-AutoaddDevices Command](using-the-approve-autoadddevices-command.md)
[Using the get-AutoaddDevices Command](using-the-get-autoadddevices-command.md)
[Using The Reject-AutoaddDevices Command](using-the-reject-autoadddevices-command.md)
