---
title: prnjobs
description: Reference article for the prnjobs command, which pauses, resumes, cancels, and lists print jobs.
ms.topic: reference
ms.assetid: 5ad34199-7a5a-40c1-8053-bccd5929df43
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 07/11/2018
---

# prnjobs

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Pauses, resumes, cancels, and lists print jobs. This command is a Visual Basic script located in the `%WINdir%\System32\printing_Admin_Scripts\<language>` directory. To use this command at a command prompt, type **cscript** followed by the full path to the prnjobs file, or change directories to the appropriate folder. For example: `cscript %WINdir%\System32\printing_Admin_Scripts\en-US\prnjobs.vbs`.

## Syntax

```
cscript prnjobs {-z | -m | -x | -l | -?} [-s <Servername>] [-p <Printername>] [-j <JobID>] [-u <Username>] [-w <password>]
```

### Parameters

| Parameter | Description |
|--|--|
| -z | Pauses the print job specified by the **-j** parameter. |
| -m | Resumes the print job specified by the **-j** parameter. |
| -x | Cancels the print job specified by the **-j** parameter. |
| -l | Lists all the print jobs in a print queue. |
| -s `<Servername>` | Specifies the name of the remote computer that hosts the printer that you want to manage. If you don't specify a computer, the local computer is used. |
| -p `<Printername>` | Required. Specifies the name of the printer that you want to manage. |
| -j `<JobID>` | Specifies (by ID number) the print job you want to cancel. |
| -u `<Username>` -w `<password>` | Specifies an account with permissions to connect to the computer that hosts the printer that you want to manage. All members of the target computer's local Administrators group have these permissions, but the permissions can also be granted to other users. If you don't specify an account, you must be logged on under an account with these permissions for the command to work. |
| /? | Displays help at the command prompt. |

#### Remarks

- If the information that you supply contains spaces, use quotation marks around the text (for example, "Computer Name").

### Examples

To pause a print job with a job ID of 27 sent to the remote computer named HRServer for printing on the printer named colorprinter, type:

```
cscript prnjobs.vbs -z -s HRServer -p colorprinter -j 27
```

To list all current print jobs in the queue for the local printer named colorprinter_2, type:

```
cscript prnjobs.vbs -l -p colorprinter_2
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Print Command Reference](print-command-reference.md)
