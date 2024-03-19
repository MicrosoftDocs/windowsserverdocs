---
title: wdsutil get-alldevices
description: Reference article for the wdsutil get-alldevices command, which displays the Windows Deployment Services properties of all pre-staged computers.
ms.topic: reference
ms.assetid: 5824b3d2-2df1-4ed6-a289-e6c47c13fea2
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil get-alldevices

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays the Windows Deployment Services properties of all pre-staged computers. A pre-staged computer is a physical computer that has been linked to a computer account in active directory Domain Services.

## Syntax

```
wdsutil [options] /get-alldevices [/forest:{Yes | No}] [/referralserver:<servername>]
```

### Parameters

| Parameter | Description |
|--|--|
| `[/forest:{Yes | No}]` | Specifies whether Windows Deployment Services should return computers in the entire forest or the local domain. The default setting is **No**, meaning that only the computers in the local domain are returned. |
| `[/referralserver:<servername>]` | Returns only those computers that are pre-staged for the specified server. |

## Examples

To view all computers, type either:

```
wdsutil /get-alldevices
```

```
wdsutil /verbose /get-alldevices /forest:Yes /referralserver:MyWDSServer
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil set-device command](wdsutil-set-device.md)

- [wdsutil add-device command](wdsutil-add-device.md)

- [wdsutil get-device command](wdsutil-get-device.md)
