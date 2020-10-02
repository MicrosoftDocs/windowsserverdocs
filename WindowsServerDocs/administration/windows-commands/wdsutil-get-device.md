---
title: get-Device
description: Reference article for get-Device, which retrieves Windows Deployment Services information about a prestaged computer (that is, a physical computer that has been lined to a computer account in active directory Domain Services.
ms.topic: reference
ms.assetid: 1da79286-7e1d-45f2-aea2-d446e16a6911
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---

# get-Device

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves Windows Deployment Services information about a prestaged computer (that is, a physical computer that has been lined to a computer account in active directory Domain Services.

## Syntax
```
wdsutil /Get-Device {/Device:<Device name> | /ID:<MAC or UUID>} [/Domain:<Domain>] [/forest:{Yes | No}]
```
### Parameters
|Parameter|Description|
|-------|--------|
|/Device:<Device name>|Specifies the name of the computer (SAMAccountName).|
|/ID:<MAC or UUID>|Specifies either the MAC address or the UUID (GUID) of the computer, as shown in the following examples. Note that a valid GUID must be in one of two formats  binary string or GUID string<p>-   **Binary string**: /ID:ACEFA3E81F20694E953EB2DAA1E8B1B6<br />-   **MAC address**: 00B056882FDC (no dashes) or 00-B0-56-88-2F-DC (with dashes)<br />-   **GUID string**: /ID:E8A3EFAC-201F-4E69-953-B2DAA1E8B1B6|
|[/Domain:<Domain>]|Specifies the domain to be searched for the prestaged computer. The default value for this parameter is the local domain.|
|[/forest:{Yes &#124; No}]|Specifies whether Windows Deployment Services should search the entire forest or the local domain. The default value is **No**, meaning that only the local domain will be searched.|
## Examples
To get information by using the computer name, type:
```
wdsutil /Get-Device /Device:computer1
```
To get information by using the MAC address, type:
```
wdsutil /verbose /Get-Device /ID:00-B0-56-88-2F-DC /Domain:MyDomain
```
To get information by using the GUID string, type:
```
wdsutil /verbose /Get-Device /ID:E8A3EFAC-201F-4E69-953-B2DAA1E8B1B6 /forest:Yes
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
[wdsutil  set-Device](wdsutil-set-device.md)
[wdsutiladd-Device command](wdsutil-add-device.md)
[wdsutilget-AllDevices command](wdsutil-get-alldevices.md)
