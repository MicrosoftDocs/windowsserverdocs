---
title: bitsadmin setnotifycmdline
description: Windows Commands topic for **bitsadmin setnotifycmdline**, which sets the command-line command that will run when the job finishes transferring data, or when a job enters a state.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 415ae6ef-8549-48b2-9693-2368a6e24075
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin setnotifycmdline

Sets the command-line command that will run when the job finishes transferring data or when a job enters a specified state.

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

The following example sets the command-line command used by the service to run Notepad.exe after the job named *myDownloadJob* completes.

```
C:\>bitsadmin /setnotifycmdline myDownloadJob c:\winnt\system32\notepad.exe NULL
```

```
C:\>bitsadmin /setnotifycmdline myDownloadJob c:\winnt\system32\notepad.exe notepad c:\eula.txt
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)