---
title: Using the add-Device command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1e599cc4-464a-421b-b6bb-c101af154131
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Using the add-Device command

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Prestages a computer in active directory Domain Services. Prestaged computers are also called known computers. This allows you to configure properties to control the installation for the client. For example, you can configure the network boot program and the unattend file that the client should receive, as well as the server from which the client should download the network boot program.
for examples of how you can use this command, see [Examples](#BKMK_examples).
## Syntax
```
wdsutil /add-Device /Device:<Device name> /ID:<UUID | MAC address> [/ReferralServer:<Server name>] [/BootProgram:<Relative path>] [/WdsClientUnattend:<Relative path>] 
[/User:<Domain\User | User@Domain>] [/JoinRights:{JoinOnly | Full}] [/JoinDomain:{Yes | No}] [/BootImagepath:<Relative path>] [/OU:<DN of OU>] [/Domain:<Domain>]
```
## Parameters
|Parameter|Description|
|-------|--------|
|/Device:<computer name>|Specifies the name of the computer to be added.|
|/ID:<UUID &#124; MAC address>|Specifies either the GUID/UUID or the MAC address of the computer. A GUID/UUID must be in one of two formats binary string or GUID string. For example:<br /><br />Binary string: **/ID:ACEFA3E81F20694E953EB2DAA1E8B1B6**<br /><br />GUID string: **/ID:E8A3EFAC-201F-4E69-953E-B2DAA1E8B1B6**<br /><br />A MAC address must be in the following format: **00B056882FDC** (no dashes) or **00-B0-56-88-2F-DC** (with dashes)|
|[/ReferralServer:<Server name>]|Specifies the name of the server to be contacted to download the network boot program and the boot image by using Trivial File Transfer Protocol (tftp).|
|[/BootProgram:<Relative path>]|Specifies the relative path from the remoteInstall folder to the network boot program that this computer should receive. For example: "boot\x86\pxeboot.com"|
|[/WdsClientUnattend:<Relative path>]|Specifies the relative path from the remoteInstall folder to the unattended installation file that automates the installation screens of the Windows Deployment Services client.|
|[/User:<Domain\User &#124; User@Domain>]|Sets permissions on the computer account object to give the specified user the necessary rights to join the computer to the domain.|
|[/JoinRights:{JoinOnly &#124; Full}]|Specifies the type of rights to be assigned to the user.<br /><br />-   **JoinOnly** requires the administrator to reset the computer account before the user can join the computer to the domain.<br />-   **Full** gives full access to the user, which includes the right to join the computer to the domain.|
|[/JoinDomain:{Yes &#124; No}]|Specifies whether or not the computer should be joined to the domain as this computer account during operating system installation. The default value is **Yes**.|
|[/BootImagepath:<Relative path>]|Specifies the relative path from the remoteInstall folder to the boot image that this computer should use.|
|[/OU:<DN of OU>]|The distinguished name of the organizational unit where the computer account object should be created. For example: **OU=MyOU,CN=Test, DC=Domain,DC=com**. The default location is the default computer's container.|
|[/Domain:<Domain>]|The domain where the computer account object should be created. The default location is the local domain.|
## <a name="BKMK_examples"></a>Examples
To add a computer by using a MAC address, type:
```
wdsutil /add-Device /Device:computer1 /ID:00-B0-56-88-2F-DC
```
To add a computer by using a GUID string, type:
```
wdsutil /add-Device /Device:computer1 /ID:{E8A3EFAC-201F-4E69-953F-B2DAA1E8B1B6} /ReferralServer:WDSServer1 /BootProgram:boot\x86\pxeboot.com 
/WDSClientUnattend:WDSClientUnattend\unattend.xml /User:Domain\MyUser/JoinRights:Full /BootImagepath:boot\x86\images\boot.wim /OU:"OU=MyOU,CN=Test,DC=Domain,DC=com"
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Using the get-AllDevices Command](using-the-get-alldevices-command.md)
[Using the get-Device Command](using-the-get-device-command.md)
[Subcommand: set-Device](subcommand-set-device.md)
[New-WdsClient](https://technet.microsoft.com/library/dn283430.aspx)
