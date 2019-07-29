---
title: taskkill
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2b71e792-08b6-46d4-95a5-cb6336a79524
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# taskkill

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Ends one or more tasks or processes. Processes can be ended by process ID or image name. **taskkill** replaces the **kill** tool.
for examples of how to use this command, see [Examples](#examples).

## Syntax

```
taskkill [/s <computer> [/u [<Domain>\]<UserName> [/p [<Password>]]]] {[/fi <Filter>] [...] [/pid <ProcessID> | /im <ImageName>]} [/f] [/t]
```

## Parameters

|         Parameter         |                                                                                                                                        Description                                                                                                                                        |
|---------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|      /s \<computer>       |                                                                                    Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer.                                                                                     |
| /u \<Domain>\\\<UserName> | Runs the command with the account permissions of the user who is specified by *UserName* or *Domain*\\*UserName*. **/u** can be specified only if **/s** is specified. The default is the permissions of the user who is currently logged on to the computer that is issuing the command. |
|      /p \<Password>       |                                                                                                   Specifies the password of the user account that is specified in the **/u** parameter.                                                                                                   |
|       /fi \<Filter>       |          Applies a filter to select a set of tasks. You can use more than one filter or use the wildcard character (**\\**\*) to specify all tasks or image names. See the following [table for valid filter names](#filter-names-operators-and-values), operators, and values.           |
|     /pid \<ProcessID>     |                                                                                                                 Specifies the process ID of the process to be terminated.                                                                                                                 |
|     /im \<ImageName>      |                                                                                Specifies the image name of the process to be terminated. Use the wildcard character (**\\**\*) to specify all image names.                                                                                |
|            /f             |                                                                    Specifies that processes be forcefully terminated. This parameter is ignored for remote processes; all remote processes are forcefully terminated.                                                                     |
|            /t             |                                                                                                          Terminates the specified process and any child processes started by it.                                                                                                          |

#### Filter names, operators, and values

| Filter Name |    Valid Operators     |                                                                Valid Value(s)                                                                |
|-------------|------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
|   STatUS    |         eq, ne         |                                                 RUNNING &#124; NOT RESPONDING &#124; UNKNOWN                                                 |
|  IMAGENAME  |         eq, ne         |                                                                  Image name                                                                  |
|     PID     | eq, ne, gt, lt, ge, le |                                                                  PID value                                                                   |
|   SESSION   | eq, ne, gt, lt, ge, le |                                                                Session number                                                                |
|   CPUtime   | eq, ne, gt, lt, ge, le | CPU time in the format <em>HH</em>**:**<em>MM</em>**:**<em>SS</em>, where *MM* and *SS* are between 0 and 59 and *HH* is any unsigned number |
|  MEMUSAGE   | eq, ne, gt, lt, ge, le |                                                              Memory usage in KB                                                              |
|  USERNAME   |         eq, ne         |                                               Any valid user name (*User* or *Domain*\\*User*)                                               |
|  SERVICES   |         eq, ne         |                                                                 Service name                                                                 |
| WINDOWTITLE |         eq, ne         |                                                                 Window title                                                                 |
|   MODULES   |         eq, ne         |                                                                   DLL name                                                                   |

## Remarks
* The WINDOWTITLE and STatUS filters are not supported when a remote system is specified.
* The wildcard character (**\\**<em>) is accepted for the **/im</em>* option only when a filter is applied.
* Termination of remote processes is always carried out forcefully, regardless of whether the **/f** option is specified.
* Supplying a computer name to the hostname filter causes a shutdown and all processes are stopped.
* You can use **tasklist** to determine the process ID (PID) for the process to be terminated.

## Examples

To end the processes with process IDs 1230, 1241, and 1253, type:

```
taskkill /pid 1230 /pid 1241 /pid 1253
```

To forcefully end the process "Notepad.exe" if it was started by the system, type:

```
taskkill /f /fi "USERNAME eq NT AUTHORITY\SYSTEM" /im notepad.exe
```

To end all processes on the remote computer "Srvmain" with an image name beginning with "note," while using the credentials for the user account Hiropln, type:

```
taskkill /s srvmain /u maindom\hiropln /p p@ssW23 /fi "IMAGENAME eq note*" /im *
```

To end the process with the process ID 2134 and any child processes that it started, but only if those processes were started by the Administrator account, type:

```
taskkill /pid 2134 /t /fi "username eq administrator"
```

To end all processes that have a process ID greater than or equal to 1000, regardless of their image names, type:

```
taskkill /f /fi "PID ge 1000" /im *
```

#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
