---
title: prnmngr
description: Reference article for the prnmngr command, which adds, deletes, and lists printers or printer connections, in addition to setting and displaying the default printer.
ms.topic: reference
ms.assetid: 39eee1a8-4b41-4c9f-941e-486495135eb8
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 07/11/2018
---

# prnmngr

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Adds, deletes, and lists printers or printer connections, in addition to setting and displaying the default printer. This command is a Visual Basic script located in the `%WINdir%\System32\printing_Admin_Scripts\<language>` directory. To use this command at a command prompt, type **cscript** followed by the full path to the prnmngr file, or change directories to the appropriate folder. For example: `cscript %WINdir%\System32\printing_Admin_Scripts\en-US\prnmngr`.

## Syntax

```
cscript prnmngr {-a | -d | -x | -g | -t | -l | -?}[c] [-s <Servername>] [-p <Printername>] [-m <printermodel>] [-r <portname>] [-u <Username>]
[-w <password>]
```

### Parameters

| Parameter | Description |
|--|--|
| -a | Adds a local printer connection. |
| -d | Deletes a printer connection. |
| -x | Deletes all printers from the server specified by the **-s** parameter. If you don't specify a server, Windows deletes all printers on the local computer. |
| -g | Displays the default printer. |
| -t | Sets the default printer to the printer specified by the **-p** parameter. |
| -l | Lists all printers installed on the server specified by the **-s** parameter. If you don't specify a server, Windows lists the printers installed on the local computer. |
| c | Specifies that the parameter applies to printer connections. Can be used with the **-a** and **-x** parameters. |
| -s `<Servername>` | Specifies the name of the remote computer that hosts the printer that you want to manage. If you don't specify a computer, the local computer is used. |
| -p `<Printername>` | Specifies the name of the printer that you want to manage. |
| -m `<Modelname>` | Specifies (by name) the driver you want to install. Drivers are often named for the model of printer they support. See the printer documentation for more information. |
| -r `<portname>` | Specifies the port where the printer is connected. If this is a parallel or a serial port, use the ID of the port (for example, LPT1: or COM1:). If this is a TCP/IP port, use the port name that was specified when the port was added. |
| -u `<Username>` -w `<password>` | Specifies an account with permissions to connect to the computer that hosts the printer that you want to manage. All members of the target computer's local Administrators group have these permissions, but the permissions can also be granted to other users. If you don't specify an account, you must be logged on under an account with these permissions for the command to work. |
| /? | Displays help at the command prompt. |

#### Remarks

- If the information that you supply contains spaces, use quotation marks around the text (for example, "Computer Name").

### Examples

To add a printer named colorprinter_2 that is connected to LPT1 on the local computer and requires a printer driver called color printer Driver1, type:

```
cscript prnmngr -a -p colorprinter_2 -m "color printer Driver1" -r lpt1:
```

To delete the printer named colorprinter_2 from the remote computer named HRServer, type:

```
cscript prnmngr -d -s HRServer -p colorprinter_2
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Print Command Reference](print-command-reference.md)
