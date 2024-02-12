---
title: wdsutil delete-autoadddevices
description: Reference article for the wdsutil delete-autoadddevices command, which deletes computers that are pending, rejected, or approved from the Auto-add database.
ms.topic: reference
ms.assetid: 8dcaca6a-212e-4c36-98e3-00938eef6b9c
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil delete-autoadddevices

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Deletes computers that are pending, rejected, or approved from the auto-add database. This database stores information about these computers on the server.

## Syntax

```
wdsutil /delete-AutoaddDevices [/Server:<Servername>] /Devicetype:{PendingDevices | RejectedDevices |ApprovedDevices}
```

### Parameters

| Parameter | Description |
|--|--|
| [/Server:`<Servername>`] | Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used. |
| /Devicetype:`{PendingDevices|RejectedDevices|ApprovedDevices}` | Specifies the type of computer to delete from the database. This type can be **PendingDevices**, which returns all computers in the database that have a status of pending, **RejectedDevices**, which returns all computers in the database that have a status of rejected, or **ApprovedDevices**, which returns all computers that have a status of approved. |

## Examples

To delete all rejected computers, type:

```
wdsutil /delete-AutoaddDevices /Devicetype:RejectedDevices
```

To delete all approved computers, type:

```
wdsutil /verbose /delete-AutoaddDevices /Server:MyWDSServer /Devicetype:ApprovedDevices
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil approve-autoadddevices command](wdsutil-approve-autoadddevices.md)

- [wdsutil get-autoadddevices command](wdsutil-get-autoadddevices.md)

- [wdsutil reject-autoadddevices command](wdsutil-reject-autoadddevices.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)
