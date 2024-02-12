---
title: wdsutil approve-autoadddevices
description: Reference article for the wdsutil approve-autoadddevices command, which approves computers that are pending administrative approval.
ms.topic: reference
ms.assetid: 8d76e8d3-ab35-429c-be7b-904f95d0782d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil approve-autoadddevices

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Approves computers that are pending administrative approval. When the Auto-add policy is enabled, administrative approval is required before unknown computers (those that are not pre-staged) can install an image. You can enable this policy using the **PXE Response** tab of the server s properties page.

## Syntax

```
wdsutil [Options] /Approve-AutoaddDevices [/Server:<Server name>] /RequestId:{<Request ID>| ALL} [/MachineName:<Device name>] [/OU:<DN of OU>] [/User:<Domain\User | User@Domain>] [/JoinRights:{JoinOnly | Full}] [/JoinDomain:{Yes | No}] [/ReferralServer:<Server name>] [/BootProgram:<Relative path>] [/WdsClientUnattend:<Relative path>] [/BootImagepath:<Relative path>]
```

### Parameters

| Parameter | Description |
|--|--|
| /Server:`<Servername>` | Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used. |
| /RequestId:`{Request ID|ALL}` | Specifies the request ID assigned to the pending computer. Specify **ALL** to approve all pending computers. |
| /Machinename:`<Devicename>` | Specifies the name of the device to be added. You can't use this option when approving all computers. |
| [/OU:`<DN of OU>`] | The distinguished name of the organizational unit where the computer account object should be created. For example: **OU=MyOU,CN=Test, DC=Domain,DC=com**. The default location is the default computer's container. |
| [/User:`<Domain\User|User@Domain>`] | Sets permissions on the computer account object to give the specified user the necessary rights to join the computer to the domain. |
| [/JoinRights:`{JoinOnly|Full}`] | Specifies the type of rights to be assigned to the user.<ul><li>**JoinOnly** - Requires the administrator to reset the computer account before the user can join the computer to the domain.</li><li>**Full** - Gives full access to the user, which includes the right to join the computer to the domain. |
| [/JoinDomain:`{Yes|No}`] | Specifies whether the computer should be joined to the domain as this computer account during operating system installation. The default value is **Yes**. |
| [/ReferralServer:`<Servername>`] | Specifies the name of the server to contact to download the network boot program and boot image by using Trivial File Transfer Protocol (tftp). |
| [/BootProgram:`<Relativepath>`] | Specifies the relative path from the **remoteInstall** folder to the network boot program that this computer should receive. For example: **boot\x86\pxeboot.com**. |
| [/WdsClientUnattend:`<Relativepath>`] | Specifies the relative path from the **remoteInstall** folder to the unattend file that automates the Windows Deployment Services client. |
| [/BootImagepath:`<Relativepath>`] | Specifies the relative path from the remoteInstall folder to the boot image that this computer should receive. |

## Examples

To approve the computer with a RequestId of 12, type:

```
wdsutil /Approve-AutoaddDevices /RequestId:12
```

To approve the computer with a RequestID of 20 and to deploy the image with the specified settings, type:

```
wdsutil /Approve-AutoaddDevices /RequestId:20 /MachineName:computer1 /OU:OU=Test,CN=company,DC=Domain,DC=Com /User:Domain\User1
/JoinRights:Full /ReferralServer:MyWDSServer /BootProgram:boot\x86\pxeboot.n12 /WdsClientUnattend:WDSClientUnattend\Unattend.xml /BootImagepath:boot\x86\images\boot.wim
```

To approve all pending computers, type:

```
wdsutil /verbose /Approve-AutoaddDevices /RequestId:ALL
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil delete-autoadddevices command](wdsutil-delete-autoadddevices.md)

- [wdsutil get-autoadddevices command](wdsutil-get-autoadddevices.md)

- [wdsutil reject-autoadddevices command](wdsutil-reject-autoadddevices.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)
