---
title: Using the get-AllDevices Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5824b3d2-2df1-4ed6-a289-e6c47c13fea2
---
# Using the get-AllDevices Command
Displays the Windows Deployment Services properties of all prestaged computers. A prestaged computer is a physical computer that has been linked to a computer account in Active Directory Domain Services.

## Syntax

```
WDSUTIL [Options] /Get-AllDevices [/Forest:{Yes | No}] [/ReferralServer:<Server name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Forest:{Yes &#124; No}\]|Specifies whether Windows Deployment Services should return computers in the entire forest or the local domain. The default setting is **No**, meaning that only the computers in the local domain are returned.|
|\[\/ReferralServer:<Server name>\]|Returns only those computers that are prestaged for the specified server.|

## <a name="BKMK_examples"></a>Examples
To view all computers, type one of the following:

```
WDSUTIL /Get-AllDevices
WDSUTIL /Verbose /Get-AllDevices /Forest:Yes /ReferralServer:MyWDSServer
```

#### Additional references
[Command-Line Syntax Key](../../Command-Line-Syntax-Key.md)

[Subcommand: set-Device](../the-set-command/Subcommand--set-Device.md)

[Using the add-Device command](../using-the-add-command/Using-the-add-Device-command.md)

[Using the get-Device Command](Using-the-get-Device-Command.md)


