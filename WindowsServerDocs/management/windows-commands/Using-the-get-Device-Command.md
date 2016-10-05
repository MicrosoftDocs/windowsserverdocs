---
title: Using the get-Device Command
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1da79286-7e1d-45f2-aea2-d446e16a6911
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Using the get-Device Command
Retrieves Windows Deployment Services information about a prestaged computer (that is, a physical computer that has been lined to a computer account in Active Directory Domain Services.
## Syntax
```
WDSUTIL /Get-Device {/Device:<Device name> | /ID:<MAC or UUID>} [/Domain:<Domain>] [/Forest:{Yes | No}]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|/Device:<Device name>|Specifies the name of the computer (SAMAccountName).|
|/ID:<MAC or UUID>|Specifies either the MAC address or the UUID (GUID) of the computer, as shown in the following examples. Note that a valid GUID must be in one of two formats —binary string or GUID string<br /><br />-   **Binary string**: /ID:ACEFA3E81F20694E953EB2DAA1E8B1B6<br />-   **MAC address**: 00B056882FDC (no dashes) or 00-B0-56-88-2F-DC (with dashes)<br />-   **GUID string**: /ID:E8A3EFAC-201F-4E69-953-B2DAA1E8B1B6|
|[/Domain:<Domain>]|Specifies the domain to be searched for the prestaged computer. The default value for this parameter is the local domain.|
|[/Forest:{Yes &#124; No}]|Specifies whether Windows Deployment Services should search the entire forest or the local domain. The default value is **No**, meaning that only the local domain will be searched.|
## <a name="BKMK_examples"></a>Examples
To get information by using the computer name, type:
```
WDSUTIL /Get-Device /Device:Computer1
```
To get information by using the MAC address, type:
```
WDSUTIL /Verbose /Get-Device /ID:"00-B0-56-88-2F-DC" /Domain:MyDomain
```
To get information by using the GUID string, type:
```
WDSUTIL /Verbose /Get-Device /ID:E8A3EFAC-201F-4E69-953-B2DAA1E8B1B6 /Forest:Yes
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Subcommand: set-Device](Subcommand--set-Device.md)
[Using the add-Device command](Using-the-add-Device-command.md)
[Using the get-AllDevices Command](Using-the-get-AllDevices-Command.md)
