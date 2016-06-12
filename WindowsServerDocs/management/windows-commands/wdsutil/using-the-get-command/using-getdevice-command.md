---
title: Using the get-Device Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1da79286-7e1d-45f2-aea2-d446e16a6911
---
# Using the get-Device Command
Retrieves Windows deployment Services information about a prestaged computer \(that is, a physical computer that has been lined to a computer account in active directory Domain Services.

## Syntax

```
wdsutil /Get-Device {/Device:<Device name> | /ID:<MAC or UUID>} [/Domain:<Domain>] [/forest:{Yes | No}]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\/Device:<Device name>|Specifies the name of the computer \(SAMAccountName\).|
|\/ID:<MAC or UUID>|Specifies either the MAC address or the UUID \(GUID\) of the computer, as shown in the following examples. Note that a valid GUID must be in one of two formats —binary string or GUID string<br /><br />-   **Binary string**: \/ID:ACEFA3E81F20694E953EB2DAA1E8B1B6<br />-   **MAC address**: 00B056882FDC \(no dashes\) or 00\-B0\-56\-88\-2F\-DC \(with dashes\)<br />-   **GUID string**: \/ID:E8A3EFAC\-201F\-4E69\-953\-B2DAA1E8B1B6|
|\[\/Domain:<Domain>\]|Specifies the domain to be searched for the prestaged computer. The default value for this parameter is the local domain.|
|\[\/forest:{Yes &#124; No}\]|Specifies whether Windows deployment Services should search the entire forest or the local domain. The default value is **No**, meaning that only the local domain will be searched.|

## <a name="BKMK_examples"></a>Examples
To get information by using the computer name, type:

```
wdsutil /Get-Device /Device:computer1
```

To get information by using the MAC address, type:

```
wdsutil /verbose /Get-Device /ID:"00-B0-56-88-2F-DC" /Domain:MyDomain
```

To get information by using the GUID string, type:

```
wdsutil /verbose /Get-Device /ID:E8A3EFAC-201F-4E69-953-B2DAA1E8B1B6 /forest:Yes
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Subcommand: set-Device](../the-set-command/subcommand-setdevice.md)

[Using the add-Device command](../using-add-command/using-adddevice-command.md)

[Using the get-AllDevices Command](using-getalldevices-command.md)


