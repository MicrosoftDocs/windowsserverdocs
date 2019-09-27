---
title: tasklist
description: Learn how to display a list of the processes running on the local or remote computer.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8dbe30ee-1484-46be-917b-5ca3ff4fdc9c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# tasklist

Displays a list of currently running processes on the local computer or on a remote computer. **Tasklist** replaces the **tlist** tool.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
tasklist [/s <Computer> [/u [<Domain>\]<UserName> [/p <Password>]]] [{/m <Module> | /svc | /v}] [/fo {table | list | csv}] [/nh] [/fi <Filter> [/fi <Filter> [ ... ]]]
```

## Parameters

|          Parameter           |                                                                                                                                            Description                                                                                                                                             |
|------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|        /s \<Computer>        |                                                                                         Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer.                                                                                         |
| /u [\<Domain>\\\]\<UserName> | Runs the command with the account permissions of the user who is specified by *UserName* or *Domain*\*UserName<em>. \*\*/u</em>\* can be specified only if **/s** is specified. The default is the permissions of the user who is currently logged on to the computer that is issuing the command. |
|        /p \<Password>        |                                                                                                       Specifies the password of the user account that is specified in the **/u** parameter.                                                                                                        |
|         /m \<Module>         |                                                               Lists all tasks with DLL modules loaded that match the given pattern name. If the module name is not specified, this option displays all modules loaded by each task.                                                                |
|             /svc             |                                                                                    Lists all the service information for each process without truncation. Valid when the **/fo** parameter is set to **table**.                                                                                    |
|              /v              |                                                                                 Displays verbose task information in the output. For complete verbose output without truncation, use **/v** and **/svc** together.                                                                                 |
|  /fo {table \| list \| csv}  |                                                                             Specifies the format to use for the output. Valid values are **table**, **list**, and **csv**. The default format for output is **table**.                                                                             |
|             /nh              |                                                                                             Suppresses column headers in the output. Valid when the **/fo** parameter is set to **table** or **csv**.                                                                                              |
|        /fi \<Filter>         |                                                                          Specifies the types of processes to include in or exclude from the query. See the following table for valid filter names, operators, and values.                                                                          |
|              /?              |                                                                                                                                Displays help at the command prompt.                                                                                                                                |

### Filter names, operators, and values

| Filter Name |    Valid Operators     |                                                                 Valid Values                                                                 |
|-------------|------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
|   STATUS    |         eq, ne         |                                                                   RUNNING                                                                    |
|  IMAGENAME  |         eq, ne         |                                                                  Image name                                                                  |
|     PID     | eq, ne, gt, lt, ge, le |                                                                  PID value                                                                   |
|   SESSION   | eq, ne, gt, lt, ge, le |                                                                Session number                                                                |
| SESSIONNAME |         eq, ne         |                                                                 Session name                                                                 |
|   CPUTIME   | eq, ne, gt, lt, ge, le | CPU time in the format <em>HH</em>**:**<em>MM</em>**:**<em>SS</em>, where *MM* and *SS* are between 0 and 59 and *HH* is any unsigned number |
|  MEMUSAGE   | eq, ne, gt, lt, ge, le |                                                              Memory usage in KB                                                              |
|  USERNAME   |         eq, ne         |                                                             Any valid user name                                                              |
|  SERVICES   |         eq, ne         |                                                                 Service name                                                                 |
| WINDOWTITLE |         eq, ne         |                                                                 Window title                                                                 |
|   MODULES   |         eq, ne         |                                                                   DLL name                                                                   |

## Remarks

The WINDOWTITLE and STATUS filters are not supported when a remote system is specified.

## <a name="BKMK_examples"></a>Examples

To list all tasks with a process ID greater than 1000, and display them in CSV format, type:
```
tasklist /v /fi "PID gt 1000" /fo csv
```
To list the system processes that are currently running, type:
```
tasklist /fi "USERNAME ne NT AUTHORITY\SYSTEM" /fi "STATUS eq running"
```
To list detailed information for all processes that are currently running, type:
```
tasklist /v /fi "STATUS eq running"
```
To list all the service information for processes on the remote computer "Srvmain" that have a DLL name beginning with "ntdll," type:
```
tasklist /s srvmain /svc /fi "MODULES eq ntdll*"
```
To list the processes on the remote computer "Srvmain," using the credentials of your currently logged-on user account, type:
```
tasklist /s srvmain 
```
To list the processes on the remote computer "Srvmain," using the credentials of the user account Hiropln, type:
```
tasklist /s srvmain /u maindom\hiropln /p p@ssW23
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)