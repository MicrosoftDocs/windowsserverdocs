---
title: bitsadmin setnotifycmdline
description: Reference article for the bitsadmin setnotifycmdline command, which sets the command-line command that will run when the job finishes transferring data, or when a job enters a state.
ms.topic: reference
ms.assetid: 415ae6ef-8549-48b2-9693-2368a6e24075
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin setnotifycmdline

Sets the command-line command that runs after the job finishes transferring data or after a job enters a specified state.

> [!NOTE]
> This command isn't supported by BITS 1.2 and earlier.

## Syntax

```
bitsadmin /setnotifycmdline <job> <program_name> [program_parameters]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |
| program_name | Name of the command to run when the job completes. You can set this value as NULL, but if you do, *program_parameters* must also be set to NULL. |
| program_parameters | Parameters that you want to pass to *program_name*. You can set this value as NULL. If *program_parameters* isn't set to NULL, then the first parameter in *program_parameters* must match the *program_name*. |

## Examples

To run Notepad.exe at the completion of the job named *myDownloadJob*:

```
bitsadmin /setnotifycmdline myDownloadJob c:\winnt\system32\notepad.exe NULL
```

To show the EULA text in Notepad.exe, at the completion of the job named myDownloadJob:

```
bitsadmin /setnotifycmdline myDownloadJob c:\winnt\system32\notepad.exe notepad c:\eula.txt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
