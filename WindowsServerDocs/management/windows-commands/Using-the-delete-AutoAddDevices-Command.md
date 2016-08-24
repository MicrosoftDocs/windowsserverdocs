---
title: Using the delete-AutoAddDevices Command
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8dcaca6a-212e-4c36-98e3-00938eef6b9c
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Using the delete-AutoAddDevices Command
Deletes computers that are pending, rejected, or approved from the Auto-Add database. This database stores information about these computers on the server.
## Syntax
```
WDSUTIL /Delete-AutoAddDevices [/Server:<Server name>] /DeviceType:{PendingDevices | RejectedDevices |ApprovedDevices}
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|/DeviceType:{PendingDevices &#124; RejectedDevices &#124;ApprovedDevices}|Specifies the type of computer to delete from the database. This can be any of the following three types:<br /><br />-   **PendingDevices** returns all computers in the database that have a status of pending.<br />-   **RejectedDevices** returns all computers in the database that have a status of rejected.<br />-   **ApprovedDevices** returns all computers that have a status of approved.|
## <a name="BKMK_examples"></a>Examples
To delete all rejected computers, type:
```
WDSUTIL /Delete-AutoAddDevices /DeviceType:RejectedDevices
```
To delete all approved computers, type:
```
WDSUTIL /Verbose /Delete-AutoAddDevices /Server:MyWDSServer /DeviceType:ApprovedDevices
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the Approve-AutoAddDevices Command](Using-the-Approve-AutoAddDevices-Command.md)
[Using the get-AutoAddDevices Command](Using-the-get-AutoAddDevices-Command.md)
[Using The Reject-AutoAddDevices Command](Using-The-Reject-AutoAddDevices-Command.md)
