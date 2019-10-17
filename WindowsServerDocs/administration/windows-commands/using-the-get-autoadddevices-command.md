---
title: Using the get-AutoaddDevices Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 24b4b688-55b0-4bd9-a2f5-7ef4b3dfe2f2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Using the get-AutoaddDevices Command

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays all computers that are in the Auto-add database on a Windows Deployment Services server.
## Syntax
```
wdsutil [Options] /Get-AutoaddDevices [/Server:<Server name>] /Devicetype:{PendingDevices | RejectedDevices | ApprovedDevices}
```
## Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|/Devicetype:{PendingDevices &#124; RejectedDevices &#124; ApprovedDevices}|Specifies the type of computer to return.<br /><br />-   **PendingDevices** returns all computers in the database that have a status of pending.<br />-   **RejectedDevices** returns all computers in the database that have a status of rejected.<br />-   **ApprovedDevices** returns all computers in the database that have a status of approved.|
## <a name="BKMK_examples"></a>Examples
To see all of the approved computers, type:
```
wdsutil /Get-AutoaddDevices /Devicetype:ApprovedDevices
```
To see all of the rejected computers, type:
```
wdsutil /verbose /Get-AutoaddDevices /Devicetype:RejectedDevices /Server:MyWDSServer
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Using the delete-AutoaddDevices Command](using-the-delete-autoadddevices-command.md)
[Using the Approve-AutoaddDevices Command](using-the-approve-autoadddevices-command.md)
[Using The Reject-AutoaddDevices Command](using-the-reject-autoadddevices-command.md)
