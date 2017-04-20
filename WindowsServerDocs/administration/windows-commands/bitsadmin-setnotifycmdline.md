---
title: bitsadmin setnotifycmdline
description: "Windows Commands topic for **** - bitsadmin setnotifycmdlineSets the command-line command that will run when the job finishes transferring data or when a job enters a state."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 415ae6ef-8549-48b2-9693-2368a6e24075
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# bitsadmin setnotifycmdline

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sets the command-line command that will run when the job finishes transferring data or when a job enters a state.
## Syntax
```
bitsadmin /SetNotifyCmdLine <Job> <ProgramName> [ProgramParameters]
```
## Parameters
|Parameter|Description|
|-------|--------|
|Job|The job's display name or GUID|
|ProgramName|Name of the command to run when the job completes.|
|ProgramParameters|Parameters that you want to pass to *ProgramName*.|
## remarks
You can specify NULL for *ProgramName* and *ProgramParameters*. If *ProgramName* is NULL, *ProgramParameters* must be NULL.
> [!IMPORTANT]
> if *ProgramParameters* is not NULL, then the first parameter in *ProgramParameters* must match *ProgramName*.
## <a name="BKMK_examples"></a>Examples
The following example sets the command-line command used by the service to run notepad when the job named *myDownloadJob* completes.
```
C:\>bitsadmin /SetNotifyCmdLine myDownloadJob c:\winnt\system32\notepad.exe NULL
```
```
C:\>bitsadmin /SetNotifyCmdLine myDownloadJob c:\winnt\system32\notepad.exe "notepad c:\eula.txt"
```
## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
