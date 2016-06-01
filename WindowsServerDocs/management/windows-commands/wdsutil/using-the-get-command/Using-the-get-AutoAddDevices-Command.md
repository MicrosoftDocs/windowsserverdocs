---
title: Using the get-AutoAddDevices Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 24b4b688-55b0-4bd9-a2f5-7ef4b3dfe2f2
---
# Using the get-AutoAddDevices Command
Displays all computers that are in the Auto\-Add database on a Windows Deployment Services server.

## Syntax

```
WDSUTIL [Options] /Get-AutoAddDevices [/Server:<Server name>] /DeviceType:{PendingDevices | RejectedDevices | ApprovedDevices}
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). If no server name is specified, the local server will be used.|
|\/DeviceType:{PendingDevices &#124; RejectedDevices &#124; ApprovedDevices}|Specifies the type of computer to return.<br /><br />-   **PendingDevices** returns all computers in the database that have a status of pending.<br />-   **RejectedDevices** returns all computers in the database that have a status of rejected.<br />-   **ApprovedDevices** returns all computers in the database that have a status of approved.|

## <a name="BKMK_examples"></a>Examples
To see all of the approved computers, type:

```
WDSUTIL /Get-AutoAddDevices /DeviceType:ApprovedDevices
```

To see all of the rejected computers, type:

```
WDSUTIL /Verbose /Get-AutoAddDevices /DeviceType:RejectedDevices /Server:MyWDSServer
```

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Using the delete-AutoAddDevices Command](Using-the-delete-AutoAddDevices-Command.md)

[Using the Approve-AutoAddDevices Command](Using-the-Approve-AutoAddDevices-Command.md)

[Using The Reject-AutoAddDevices Command](Using-The-Reject-AutoAddDevices-Command.md)


