---
title: Subcommand: set-Device
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 401567f8-eaeb-4a2d-b811-140bb007028d
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Subcommand: set-Device
Changes the attributes of a prestaged computer. A prestaged computer is a computer that has been linked to a computer account object in Active Directory Domain Servers (AD DS). Prestaged clients are also called known computers. You can configure properties on the computer account to control the installation for the client. For example, you can configure the network boot program and the unattend file that the client should receive, as well as the server from which the client should download the network boot program.
## Syntax
```
WDSUTIL [Options] /Set-Device /Device:<Device name> [/ID:<UUID | MAC Address>] [/ReferralServer:<Server name>] [/BootProgram:<Relative path>] 
[/WdsClientUnattend:<Relative path>] [/User:<Domain\User | User@Domain>] [/JoinRights:{JoinOnly | Full}] [/JoinDomain:{Yes | No}] [/BootImagePath:<Relative path>] [/Domain:<Domain>] [/ResetAccount]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|/Device:<computer name>|Specifies the name of the computer (SAM-Account-Name).|
|[/ID:<UUID &#124; MAC address>]|Specifies either the GUID/UUID or the MAC address of the computer. This value must be in one of the following three formats:<br /><br />-   Binary string: **/ID:ACEFA3E81F20694E953EB2DAA1E8B1B6**<br />-   GUID/UUID string: /ID:**E8A3EFAC-201F-4E69-953E-B2DAA1E8B1B6**<br />-   MAC address: **00B056882FDC** (no dashes) or **00-B0-56-88-2F-DC** (with dashes)|
|[/ReferralServer:<Server name>]|Specifies the name of the server to be contacted to download the network boot program and boot image using Trivial File Transfer Protocol (TFTP).|
|[/BootProgram:<Relative path>]|Specifies the relative path from the RemoteInstall folder to the network boot program that the specified computer will receive. For example: **boot\x86\pxeboot.com**|
|[/WdsClientUnattend:<Relative path>]|Specifies the relative path from the RemoteInstall folder to the unattend file that automates the installation screens for the Windows Deployment Services client.|
|[/User:<Domain\User &#124; User@Domain>]|Sets permissions on the computer account object to give the specified user the necessary rights to join the computer to the domain.|
|[/JoinRights:{JoinOnly &#124; Full}]|Specifies the type of rights to be assigned to the user.<br /><br />-   **JoinOnly** requires the administrator to reset the computer account before the user can join the computer to the domain.<br />-   **Full** gives full access to the user, including the right to join the computer to the domain.|
|[/JoinDomain:{Yes &#124; No}]|Specifies whether or not the computer should be joined to the domain as this computer account during a Windows Deployment Services installation. The default setting is **Yes**.|
|[/BootImagePath:<Relative path>]|Specifies the relative path from the RemoteInstall folder to the boot image that the computer will use.|
|[/Domain:<Domain>]|Specifies the domain to be searched for the prestaged computer. The default value is the local domain.|
|[/ResetAccount]|Resets the permissions on the specified computer so that anyone with the appropriate permissions can join the domain by using this account.|
## <a name="BKMK_examples"></a>Examples
To set the network boot program and referral server for a computer, type:
```
WDSUTIL /Set-Device /Device:Computer1 /ReferralServer:MyWDSServer
/BootProgram:boot\x86\pxeboot.n12
```
To set various settings for a computer, type:
```
WDSUTIL /Verbose /Set-Device /Device:Computer2 /ID:00-B0-56-88-2F-DC /WdsClientUnattend:WDSClientUnattend\unattend.xml 
/User:Domain\user /JoinRights:JoinOnly /JoinDomain:No /BootImagePath:boot\x86\images\boot.wim /Domain:NorthAmerica /ResetAccount
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the add-Device command](Using-the-add-Device-command.md)
[Using the get-AllDevices Command](Using-the-get-AllDevices-Command.md)
[Using the get-Device Command](Using-the-get-Device-Command.md)
