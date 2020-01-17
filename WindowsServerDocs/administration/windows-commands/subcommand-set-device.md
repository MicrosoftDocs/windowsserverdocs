---
title: Subcommand set-Device
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 401567f8-eaeb-4a2d-b811-140bb007028d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Subcommand: set-Device

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

changes the attributes of a prestaged computer. A prestaged computer is a computer that has been linked to a computer account object in active directory Domain Servers (AD DS). Prestaged clients are also called known computers. You can configure properties on the computer account to control the installation for the client. For example, you can configure the network boot program and the unattend file that the client should receive, as well as the server from which the client should download the network boot program.
## Syntax
```
wdsutil [Options] /Set-Device /Device:<Device name> [/ID:<UUID | MAC address>] [/ReferralServer:<Server name>] [/BootProgram:<Relative path>] 
[/WdsClientUnattend:<Relative path>] [/User:<Domain\User | User@Domain>] [/JoinRights:{JoinOnly | Full}] [/JoinDomain:{Yes | No}] [/BootImagepath:<Relative path>] [/Domain:<Domain>] [/resetAccount]
```
## Parameters
|Parameter|Description|
|-------|--------|
|/Device:<computer name>|Specifies the name of the computer (SAM-Account-Name).|
|[/ID:<UUID &#124; MAC address>]|Specifies either the GUID/UUID or the MAC address of the computer. This value must be in one of the following three formats:<br /><br />-   Binary string: **/ID:ACEFA3E81F20694E953EB2DAA1E8B1B6**<br />-   GUID/UUID string: /ID:**E8A3EFAC-201F-4E69-953E-B2DAA1E8B1B6**<br />-   MAC address: **00B056882FDC** (no dashes) or **00-B0-56-88-2F-DC** (with dashes)|
|[/ReferralServer:<Server name>]|Specifies the name of the server to be contacted to download the network boot program and boot image using Trivial File Transfer Protocol (tftp).|
|[/BootProgram:<Relative path>]|Specifies the relative path from the remoteInstall folder to the network boot program that the specified computer will receive. For example: **boot\x86\pxeboot.com**|
|[/WdsClientUnattend:<Relative path>]|Specifies the relative path from the remoteInstall folder to the unattend file that automates the installation screens for the Windows Deployment Services client.|
|[/User:<Domain\User &#124; User@Domain>]|Sets permissions on the computer account object to give the specified user the necessary rights to join the computer to the domain.|
|[/JoinRights:{JoinOnly &#124; Full}]|Specifies the type of rights to be assigned to the user.<br /><br />-   **JoinOnly** requires the administrator to reset the computer account before the user can join the computer to the domain.<br />-   **Full** gives full access to the user, including the right to join the computer to the domain.|
|[/JoinDomain:{Yes &#124; No}]|Specifies whether or not the computer should be joined to the domain as this computer account during a Windows Deployment Services installation. The default setting is **Yes**.|
|[/BootImagepath:<Relative path>]|Specifies the relative path from the remoteInstall folder to the boot image that the computer will use.|
|[/Domain:<Domain>]|Specifies the domain to be searched for the prestaged computer. The default value is the local domain.|
|[/resetAccount]|resets the permissions on the specified computer so that anyone with the appropriate permissions can join the domain by using this account.|
## <a name="BKMK_examples"></a>Examples
To set the network boot program and referral server for a computer, type:
```
wdsutil /Set-Device /Device:computer1 /ReferralServer:MyWDSServer
/BootProgram:boot\x86\pxeboot.n12
```
To set various settings for a computer, type:
```
wdsutil /verbose /Set-Device /Device:computer2 /ID:00-B0-56-88-2F-DC /WdsClientUnattend:WDSClientUnattend\unattend.xml 
/User:Domain\user /JoinRights:JoinOnly /JoinDomain:No /BootImagepath:boot\x86\images\boot.wim /Domain:NorthAmerica /resetAccount
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Using the add-Device command](using-the-add-device-command.md)
[Using the get-AllDevices Command](using-the-get-alldevices-command.md)
[Using the get-Device Command](using-the-get-device-command.md)
