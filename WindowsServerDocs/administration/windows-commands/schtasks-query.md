---
title: schtasks query
description: Reference article for the schtasks query command, which lists all the tasks scheduled to run on the computer.
ms.topic: reference
ms.author: wscontent
author: xelu86
ms.date: 10/10/2023
---

# schtasks query

Lists all the tasks scheduled to run on the computer.

Syntax

```
schtasks [/query] [/fo {TABLE | LIST | CSV}] [/nh] [/v] [/s <computer> [/u [<domain>\]<user> [/p <password>]]] [/tn <taskname>] [/xml] [/hresult]
```

### Parameters

| Parameter | Description |
|--|--|
| /query | Optionally, specifies the name of the operation. Using this query without any parameters performs a query of all tasks on the system. |
| /fo `<format>` | Specifies the output format. The valid values are *TABLE*, *LIST*, or *CSV*. |
| /nh | Removes column headings from the table display. This parameter is valid with the *TABLE* or *CSV* output formats. |
| /v | Adds the advanced properties of the task to the display. This parameter is valid with the *LIST* or *CSV* output formats. |
| /s `<computer>` | Specifies the name or IP address of a remote computer (with or without backslashes). The default is the local computer. |
| /u `[<domain>]` | Runs this command with the permissions of the specified user account. By default, the command runs with the permissions of the current user of the local computer. The specified user account must be a member of the Administrators group on the remote computer. The **/u** and **/p** parameters are valid only when you use **/s**. |
| /p `<password>` | Specifies the password of the user account specified in the **/u** parameter. If you use the **/u** parameter without the **/p** parameter or the password argument, schtasks will prompt you for a password. The **/u** and **/p** parameters are valid only when you use **/s**. |
| /tn `<taskname>`| Queries a specific task by path and name. This cannot be blank. |
| /xml | Outputs all task definitions on the system to XML format. If **/tn** is specified, outputs the specific task name to XML format. The full path and name must be used. |
| /hresult | Specifies the process exit code to be in HRESULT format. |
| /? | Displays help at the command prompt. |

## Examples

To list all tasks scheduled for the local computer, type:

```
schtasks
schtasks /query
```

These commands produce the same result and can be used interchangeably.

To request a detailed display of the tasks on the local computer,type:

```
schtasks /query /fo LIST /v
```

This command uses the **/v** parameter to request a detailed (verbose) display and the **/fo LIST** parameter to format the display as a list for easy reading. You can use this command to verify that a task you created has the intended recurrence pattern.

To request a list of tasks scheduled for a remote computer and to add the tasks to a comma-separated log file on the local computer, type:

```
schtasks /query /s Reskit16 /fo csv /nh >> \\svr01\data\tasklogs\p0102.csv
```

You can use this command format to collect and track tasks that are scheduled for multiple computers. This command uses the **/s** parameter to identify the remote computer, *Reskit16*, the **/fo** parameter to specify the format and the **/nh** parameter to suppress the column headings. The **>>** append symbol redirects the output to the task log, *p0102.csv*, on the local computer, *Svr01*. Because the command runs on the remote computer, the local computer path must be fully qualified.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [schtasks change command](schtasks-change.md)

- [schtasks create command](schtasks-create.md)

- [schtasks delete command](schtasks-delete.md)

- [schtasks end command](schtasks-end.md)

- [schtasks run command](schtasks-run.md)