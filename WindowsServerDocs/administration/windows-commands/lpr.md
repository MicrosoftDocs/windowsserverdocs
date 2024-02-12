---
title: lpr
description: Reference article for the lpr command, which sends a file to a computer or printer sharing device running the Line printer Daemon (LPD) service in preparation for printing.
ms.topic: reference
ms.assetid: afc8790b-8b52-45c4-acdf-be0ffa9da534
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# lpr

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sends a file to a computer or printer sharing device running the Line printer Daemon (LPD) service in preparation for printing.

## Syntax

```
lpr [-S <servername>] -P <printername> [-C <bannercontent>] [-J <jobname>] [-o | -o l] [-x] [-d] <filename>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -S `<servername>` | Specifies (by name or IP address) the computer or printer sharing device that hosts the LPD print queue with a status that you want to display.  This parameter is required and must be capitalized. |
| -P `<printername> `| Specifies (by name) the printer for the print queue with a status that you want to display. To find the name of the printer, open the **Printers** folder. This parameter is required and must be capitalized. |
| -C `<bannercontent>` | Specifies the content to print on the banner page of the print job. If you don't include this parameter, the name of the computer from which the print job was sent appears on the banner page. This parameter must be capitalized. |
| -J `<jobname>` | Specifies the print job name that will be printed on the banner page. If you don't include this parameter, the name of the file being printed appears on the banner page. This parameter must be capitalized. |
| `[-o | -o l]` | Specifies the type of file that you want to print. The parameter **-o** specifies that you want to print a text file. The parameter **-o l** specifies that you want to print a binary file (for example, a PostScript file). |
| -d | Specifies that the data file must be sent before the control file. Use this parameter if your printer requires the data file to be sent first. For more information, see your printer documentation. |
| -x | Specifies that the **lpr** command must be compatible with the Sun Microsystems operating system (referred to as SunOS) for releases up to and including 4.1.4_u1. |
| `<filename>` | Specifies (by name) the file to be printed. This parameter is required. |
| /? | Displays help at the command prompt. |

### Examples

To print the *Document.txt* text file to the *Laserprinter1* printer queue on an LPD host at *10.0.0.45*, type:

```
lpr -S 10.0.0.45 -P Laserprinter1 -o Document.txt
```

To print the *PostScript_file.ps* Adobe PostScript file to the *Laserprinter1* printer queue on an LPD host at *10.0.0.45*, type:

```
lpr -S 10.0.0.45 -P Laserprinter1 -o l PostScript_file.ps
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Print Command Reference](print-command-reference.md)
