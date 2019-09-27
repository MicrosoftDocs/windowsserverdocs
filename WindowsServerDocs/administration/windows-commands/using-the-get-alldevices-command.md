---
title: Using the get-AllDevices Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5824b3d2-2df1-4ed6-a289-e6c47c13fea2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Using the get-AllDevices Command

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays the Windows Deployment Services properties of all prestaged computers. A prestaged computer is a physical computer that has been linked to a computer account in active directory Domain Services.
## Syntax
```
wdsutil [Options] /Get-AllDevices [/forest:{Yes | No}] [/ReferralServer:<Server name>]
```
## Parameters
|Parameter|Description|
|-------|--------|
|[/forest:{Yes &#124; No}]|Specifies whether Windows Deployment Services should return computers in the entire forest or the local domain. The default setting is **No**, meaning that only the computers in the local domain are returned.|
|[/ReferralServer:<Server name>]|Returns only those computers that are prestaged for the specified server.|
## <a name="BKMK_examples"></a>Examples
To view all computers, type one of the following:
```
wdsutil /Get-AllDevices
wdsutil /verbose /Get-AllDevices /forest:Yes /ReferralServer:MyWDSServer
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Subcommand: set-Device](subcommand-set-device.md)
[Using the add-Device command](using-the-add-device-command.md)
[Using the get-Device Command](using-the-get-device-command.md)
