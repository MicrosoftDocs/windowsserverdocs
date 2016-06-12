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
Displays the Windows deployment Services properties of all prestaged computers. A prestaged computer is a physical computer that has been linked to a computer account in active directory Domain Services.

## Syntax

```
wdsutil [Options] /Get-AllDevices [/forest:{Yes | No}] [/ReferralServer:<Server name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/forest:{Yes &#124; No}\]|Specifies whether Windows deployment Services should return computers in the entire forest or the local domain. The default setting is **No**, meaning that only the computers in the local domain are returned.|
|\[\/ReferralServer:<Server name>\]|Returns only those computers that are prestaged for the specified server.|

## <a name="BKMK_examples"></a>Examples
To view all computers, type one of the following:

```
wdsutil /Get-AllDevices
wdsutil /verbose /Get-AllDevices /forest:Yes /ReferralServer:MyWDSServer
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Subcommand: set-Device](../the-set-command/subcommand-setdevice.md)

[Using the add-Device command](../using-add-command/using-adddevice-command.md)

[Using the get-Device Command](using-getdevice-command.md)


