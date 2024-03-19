---
title: print
description: Reference article for the print command, which sends a text file to a printer.
ms.topic: reference
ms.assetid: aa2325d5-a993-4ed3-b996-255165452db8
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# print

Sends a text file to a printer. A file can print in the background if you send it to a printer connected to a serial or parallel port on the local computer.

> [!NOTE]
> You can perform many configuration tasks from the command prompt by using the [Mode command](mode.md), including configuring a printer connected to a parallel or a serial port, displaying printer status, or preparing a printer for code page switching.

## Syntax

```
print [/d:<printername>] [<drive>:][<path>]<filename>[ ...]
```

### Parameters

| Parameter | Description |
|--|--|
| /d:`<printername>` | Specifies the printer that you want to print the job. To print to a locally connected printer, specify the port on your computer where the printer is connected. Valid values for parallel ports are **LPT1**, **LPT2**, and **LPT3**. Valid values for serial ports are **COM1**, **COM2**, **COM3**, and **COM4**. You can also specify a network printer by using its queue name (`\\server_name\printer_name`). If you don't specify a printer, the print job is sent to **LPT1** by default. |
| `<drive>`: | Specifies the logical or physical drive where the file you want to print is located. This parameter isn't required if the file you want to print is located on the current drive. |
| `<path>` | Specifies the location of the file you want to print. This parameter isn't required if the file you want to print is located in the current directory. |
| `<filename>[ ...]` | Required. Specifies the file you want to print. You can include multiple files in one command. |
| /? | Displays help at the command prompt. |

### Examples

To send the **report.txt** file, located in the current directory, to a printer connected to **lpt2** on the local computer, type:

```
print /d:lpt2 report.txt
```

To send the **report.txt** file, located in the **c:\accounting** directory, to the **printer1** print queue on the **/d:\\copyroom** server, type:

```
print /d:\\copyroom\printer1 c:\accounting\report.txt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Print Command Reference](print-command-reference.md)

- [Mode command](mode.md)