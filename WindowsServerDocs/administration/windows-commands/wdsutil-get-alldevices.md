---
title: wdsutil get-alldevices
description: Reference article for wdsutil get-alldevices, which displays the Windows Deployment Services properties of all prestaged computers.
ms.topic: reference
ms.assetid: 5824b3d2-2df1-4ed6-a289-e6c47c13fea2
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil get-alldevices

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays the Windows Deployment Services properties of all prestaged computers. A prestaged computer is a physical computer that has been linked to a computer account in active directory Domain Services.

## Syntax
```
wdsutil [Options] /Get-AllDevices [/forest:{Yes | No}] [/ReferralServer:<Server name>]
```
### Parameters
|Parameter|Description|
|-------|--------|
|[/forest:{Yes &#124; No}]|Specifies whether Windows Deployment Services should return computers in the entire forest or the local domain. The default setting is **No**, meaning that only the computers in the local domain are returned.|
|[/ReferralServer:<Server name>]|Returns only those computers that are prestaged for the specified server.|
## Examples
To view all computers, type one of the following:
```
wdsutil /Get-AllDevices
wdsutil /verbose /Get-AllDevices /forest:Yes /ReferralServer:MyWDSServer
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil set-device command](wdsutil-set-device.md)
- [wdsutil add-device command](wdsutil-add-device.md)
- [wdsutil get-device command](wdsutil-get-device.md)
