---
title: wdsutil add-device
description: Reference article for the wdsutil add-device command, which pre-stages a computer in Active Directory Domain Services.
ms.topic: reference
ms.assetid: 1e599cc4-464a-421b-b6bb-c101af154131
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil add-device

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Pre-stages a computer in Active Directory Domain Services (AD DS). Pre-staged computers are also called *known computers*. This allows you to configure properties to control the installation for the client. For example, you can configure the network boot program and the unattend file that the client should receive, as well as the server from which the client should download the network boot program.

## Syntax

```
wdsutil /add-Device /Device:<Devicename> /ID:<UUID | MAC address> [/ReferralServer:<Servername>] [/BootProgram:<Relativepath>] [/WdsClientUnattend:<Relativepath>] [/User:<Domain\User | User@Domain>] [/JoinRights:{JoinOnly | Full}] [/JoinDomain:{Yes | No}] [/BootImagepath:<Relativepath>] [/OU:<DN of OU>] [/Domain:<Domain>]
```

### Parameters

| Parameter | Description |
|--|--|
| /Device:`<Devicename>` | Specifies the name of the device to be added. |
| /ID:`<UUID|MAC address>` | Specifies either the GUID/UUID or the MAC address of the computer. A GUID/UUID must be in one of two formats: Binary string (`/ID:ACEFA3E81F20694E953EB2DAA1E8B1B6`) or GUID string (`/ID:E8A3EFAC-201F-4E69-953E-B2DAA1E8B1B6`). A MAC address must be in the following format: **00B056882FDC** (no dashes) or **00-B0-56-88-2F-DC** (with dashes) |
| [/ReferralServer:`<Servername>`] | Specifies the name of the server to be contacted to download the network boot program and the boot image by using Trivial File Transfer Protocol (tftp). |
| [/BootProgram:`<Relativepath>`] | Specifies the relative path from the **remoteInstall** folder to the network boot program that this computer should receive. For example: `boot\x86\pxeboot.com` |
| [/WdsClientUnattend:`<Relativepath>`] | Specifies the relative path from the **remoteInstall** folder to the unattended installation file that automates the installation screens of the Windows Deployment Services client. |
| [/User:`<Domain\User|User@Domain>`] | Sets permissions on the computer account object to give the specified user the necessary rights to join the computer to the domain. |
| [/JoinRights:`{JoinOnly|Full}`] | Specifies the type of rights to be assigned to the user.<ul><li>**JoinOnly** - Requires the administrator to reset the computer account before the user can join the computer to the domain.</li><li>**Full** - Gives full access to the user, which includes the right to join the computer to the domain. |
| [/JoinDomain:`{Yes|No}`] | Specifies whether the computer should be joined to the domain as this computer account during operating system installation. The default value is **Yes**. |
| [/BootImagepath:`<Relativepath>`] | Specifies the relative path from the **remoteInstall** folder to the boot image that this computer should use. |
| [/OU:`<DN of OU>`] | The distinguished name of the organizational unit where the computer account object should be created. For example: **OU=MyOU,CN=Test, DC=Domain,DC=com**. The default location is the default computer's container. |
| [/Domain:`<Domain>`] | The domain where the computer account object should be created. The default location is the local domain. |

## Examples

To add a computer by using a MAC address, type:

```
wdsutil /add-Device /Device:computer1 /ID:00-B0-56-88-2F-DC
```

To add a computer by using a GUID string, type:

```
wdsutil /add-Device /Device:computer1 /ID:{E8A3EFAC-201F-4E69-953F-B2DAA1E8B1B6} /ReferralServer:WDSServer1 /BootProgram:boot\x86\pxeboot.com/WDSClientUnattend:WDSClientUnattend\unattend.xml /User:Domain\MyUser/JoinRights:Full /BootImagepath:boot\x86\images\boot.wim /OU:OU=MyOU,CN=Test,DC=Domain,DC=com
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil get-alldevices command](wdsutil-get-alldevices.md)

- [wdsutil get-device command](wdsutil-get-device.md)

- [wdsutil set-device command](wdsutil-set-device.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)

- [New-WdsClient](/powershell/module/wds/New-WdsClient)
