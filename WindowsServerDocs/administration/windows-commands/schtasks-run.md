---
title: schtasks run
description: Reference article for the schtasks run command, which
ms.topic: reference
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 09/16/2020
---

# schtasks run

Starts a scheduled task immediately. The run operation ignores the schedule, but uses the program file location, user account, and password saved in the task to run the task immediately. Running a task does not affect the task schedule and does not change the next run time scheduled for the task.

## Syntax

```
schtasks /run /tn <taskname> [/s <computer> [/u [<domain>\]<user> [/p <password>]]]
```

### Parameters

| Parameter | Description |
|--|--|
| /tn `<taskname>` | Identifies the task to start. This parameter is required. |
| /s `<computer>` | Specifies the name or IP address of a remote computer (with or without backslashes). The default is the local computer. |
| /u `[<domain>]` | Runs this command with the permissions of the specified user account. By default, the command runs with the permissions of the current user of the local computer. The specified user account must be a member of the Administrators group on the remote computer. The **/u** and **/p** parameters are valid only when you use **/s**. |
| /p `<password>` | Specifies the password of the user account specified in the **/u** parameter. If you use the **/u** parameter without the **/p** parameter or the password argument, schtasks will prompt you for a password. The **/u** and **/p** parameters are valid only when you use **/s**. |
| /? | Displays help at the command prompt. |

#### Remarks

- Use this operation to test your tasks. If a task doesn't run, check the Task Scheduler Service transaction log, `<Systemroot>\SchedLgU.txt` for errors.

- To run a task remotely, the task must be scheduled on the remote computer. When you run the task, it runs only on the remote computer. To verify that a task is running on a remote computer, use Task Manager or the Task Scheduler Service transaction log, `<Systemroot>\SchedLgU.txt`.

## Examples

To start the *Security Script* task, type:

```
schtasks /run /tn Security Script
```

To start the *Update* task on a remote computer, Svr01, type:

```
schtasks /run /tn Update /s Svr01
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [schtasks change command](schtasks-change.md)

- [schtasks create command](schtasks-create.md)

- [schtasks delete command](schtasks-delete.md)

- [schtasks end command](schtasks-end.md)

- [schtasks query command](schtasks-query.md)