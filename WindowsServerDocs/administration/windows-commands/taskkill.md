---
title: taskkill
description: Reference article for the taskkill command, which ends one or more tasks or processes.
ms.topic: reference
ms.assetid: 2b71e792-08b6-46d4-95a5-cb6336a79524
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# taskkill

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Ends one or more tasks or processes. Processes can be ended by process ID or image name. You can use the [tasklist command](tasklist.md) command to determine the process ID (PID) for the process to be ended.

> [!NOTE]
> This command replaces the **kill** tool.

## Syntax

```
taskkill [/s <computer> [/u [<domain>\]<username> [/p [<password>]]]] {[/fi <filter>] [...] [/pid <processID> | /im <imagename>]} [/f] [/t]
```

### Parameters

| Parameter | Description |
|--|--|
|  /s `<computer>` | Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer. |
| /u `<domain>\<username>` | Runs the command with the account permissions of the user who is specified by `<username>` or by `<domain>\<username>`. The **/u** parameter can be specified only if **/s** is also specified. The default is the permissions of the user who is currently logged on to the computer that is issuing the command. |
| /p `<password>` | Specifies the password of the user account that is specified in the **/u** parameter. |
| /fi `<filter>` | Applies a filter to select a set of tasks. You can use more than one filter or use the wildcard character (`*`) to specify all tasks or image names. The valid filters are listed in the **Filter names, operators, and values** section of this article. |
| /pid `<processID>` | Specifies the process ID of the process to be terminated. |
| /im `<imagename>` | Specifies the image name of the process to be terminated. Use the wildcard character (`*`) to specify all image names. |
| /f | Specifies that processes be forcefully ended. This parameter is ignored for remote processes; all remote processes are forcefully ended. |
| /t | Ends the specified process and any child processes started by it. |

#### Filter names, operators, and values

| Filter Name | Valid Operators | Valid Value(s) |
|--|--|--|
| STATUS | eq, ne | `RUNNING | NOT RESPONDING | UNKNOWN` |
| IMAGENAME | eq, ne | Image name |
| PID | eq, ne, gt, lt, ge, le | PID value |
| SESSION | eq, ne, gt, lt, ge, le | Session number |
| CPUtime | eq, ne, gt, lt, ge, le | CPU time in the format *HH:MM:SS*, where *MM* and *SS* are between 0 and 59 and *HH* is any unsigned number |
| MEMUSAGE | eq, ne, gt, lt, ge, le | Memory usage in KB |
| USERNAME | eq, ne | Any valid user name (`<user>` or `<domain\user>`) |
| SERVICES | eq, ne | Service name |
| WINDOWTITLE | eq, ne | Window title |
| MODULES | eq, ne | DLL name |

## Remarks

- The **WINDOWTITLE** and **STATUS** filters aren't supported when a remote system is specified.

- The wildcard character (`*`) is accepted for the `*/im` option, only when a filter is applied.

- Ending a remote process is always carried out forcefully, regardless whether the **/f** option is specified.

- Providing a computer name to the hostname filter causes a shutdown, stopping all processes.

## Examples

To end the processes with process IDs *1230*, *1241*, and *1253*, type:

```
taskkill /pid 1230 /pid 1241 /pid 1253
```

To forcefully end the process *Notepad.exe* if it was started by the system, type:

```
taskkill /f /fi "USERNAME eq NT AUTHORITY\SYSTEM" /im notepad.exe
```

To end all processes on the remote computer *Srvmain* with an image name beginning with *note*, while using the credentials for the user account *Hiropln*, type:

```
taskkill /s srvmain /u maindom\hiropln /p p@ssW23 /fi "IMAGENAME eq note*" /im *
```

To end the process with the process ID *2134* and any child processes that it started, but only if those processes were started by the Administrator account, type:

```
taskkill /pid 2134 /t /fi "username eq administrator"
```

To end all processes that have a process ID *greater than or equal to 1000*, regardless of their image names, type:

```
taskkill /f /fi "PID ge 1000" /im *
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [tasklist command](tasklist.md)
