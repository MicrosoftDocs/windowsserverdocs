---
title: bitsadmin setnotifycmdline
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 415ae6ef-8549-48b2-9693-2368a6e24075
---
# bitsadmin setnotifycmdline
Sets the command\-line command that will run when the job finishes transferring data or when a job enters a state..

## Syntax

```
bitsadmin /SetNotifycmdLine <Job> <ProgramName> [ProgramParameters]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
|ProgramName|Name of the command to run when the job completes.|
|ProgramParameters|Parameters that you want to pass to *ProgramName*.|

## remarks
You can specify NULL for *ProgramName* and *ProgramParameters*. if *ProgramName* is NULL, *ProgramParameters* must be NULL.

> [!importANT]
> if *ProgramParameters* is not NULL, then the first parameter in *ProgramParameters* must match *ProgramName*.

## <a name="BKMK_examples"></a>Examples
The following example sets the command\-line command used by the service to run notepad when the job named *myDownloadJob* completes.

```
C:\>bitsadmin /SetNotifycmdLine myDownloadJob c:\winnt\system32\notepad.exe NULL
```

```
C:\>bitsadmin /SetNotifycmdLine myDownloadJob c:\winnt\system32\notepad.exe "notepad c:\eula.txt"
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


