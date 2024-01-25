---
title: lpq
description: Reference article for the lpq command, which displays the status of a print queue on a computer running Line printer Daemon (LPD).
ms.topic: reference
ms.assetid: bb6abcc4-310a-4fa4-927b-4084b62ca02e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# lpq

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays the status of a print queue on a computer running Line printer Daemon (LPD).

## Syntax

```
lpq -S <servername> -P <printername> [-l]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -S `<servername>` | Specifies (by name or IP address) the computer or printer sharing device that hosts the LPD print queue with a status that you want to display. This parameter is required and must be capitalized. |
| -P `<Printername>` | Specifies (by name) the printer for the print queue with a status that you want to display. This parameter is required and must be capitalized. |
| -l | Specifies that you want to display details about the status of the print queue. |
| /? | Displays help at the command prompt. |

### Examples

To display the status of the *Laserprinter1* printer queue on an LPD host at *10.0.0.45*, type:

```
lpq -S 10.0.0.45 -P Laserprinter1
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Print Command Reference](print-command-reference.md)
