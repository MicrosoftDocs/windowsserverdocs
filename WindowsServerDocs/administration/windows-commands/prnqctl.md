---
title: prnqctl
description: Reference article for the prnqctl command, which prints a test page, and pauses or resumes a printer.
ms.topic: reference
ms.assetid: 8df9dfa7-984c-4276-bb7d-e7675e7c399e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 07/11/2018
---

# prnqctl

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Prints a test page, pauses or resumes a printer, and clears a printer queue. This command is a Visual Basic script located in the `%WINdir%\System32\printing_Admin_Scripts\<language>` directory. To use this command at a command prompt, type **cscript** followed by the full path to the prnqctl file, or change directories to the appropriate folder. For example: `cscript %WINdir%\System32\printing_Admin_Scripts\en-US\prnqctl`.

## Syntax

```
cscript Prnqctl {-z | -m | -e | -x | -?} [-s <Servername>] [-p <Printername>] [-u <Username>] [-w <password>]
```

### Parameters

| Parameter | Description |
|--|--|
| -z | Pauses printing on the printer specified by the **-p** parameter. |
| -m | Resumes printing on the printer specified by the **-p** parameter. |
| -e | Prints a test page on the printer specified by the **-p** parameter. |
| -x | Cancels all print jobs on the printer specified by the **-p** parameter. |
| -s `<Servername>` | Specifies the name of the remote computer that hosts the printer that you want to manage. If you don't specify a computer, the local computer is used. |
| -p `<Printername>` | Required. Specifies the name of the printer that you want to manage. |
| -u `<Username>` -w `<password>` | Specifies an account with permissions to connect to the computer that hosts the printer that you want to manage. All members of the target computer's local Administrators group have these permissions, but the permissions can also be granted to other users. If you don't specify an account, you must be logged on under an account with these permissions for the command to work. |
| /? | Displays help at the command prompt. |

#### Remarks

- If the information that you supply contains spaces, use quotation marks around the text (for example, "Computer Name").

### Examples

To print a test page on the Laserprinter1 printer shared by the \\Server1 computer, type:

```
cscript prnqctl -e -s Server1 -p Laserprinter1
```

To pause printing on the Laserprinter1 printer on the local computer, type:

```
cscript prnqctl -z -p Laserprinter1
```

To cancel all print jobs on the Laserprinter1 printer on the local computer, type:

```
cscript prnqctl -x -p Laserprinter1
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Print Command Reference](print-command-reference.md)
