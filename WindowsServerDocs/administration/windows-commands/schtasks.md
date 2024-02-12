---
title: schtasks commands
description: Reference article for the schtasks commands, which schedules commands and programs to run periodically or at a specific time, adds and removes tasks from the schedule, starts and stops tasks on demand, and displays and changes scheduled tasks.
ms.topic: reference
ms.author: alalve
author: JasonGerend
manager: mtillman
ms.date: 02/01/2023
---

# schtasks commands

Schedules commands and programs to run periodically or at a specific time, adds and removes tasks from the schedule, starts and stops tasks on demand, and displays and changes scheduled tasks.

> [!NOTE]
> The **schtasks.exe** tool performs the same operations as **Scheduled Tasks** in **Control Panel**. You can use these tools together and interchangeably.

## Required permissions

- To schedule, view, and change all tasks on the local computer, you must be a member of the Administrators group.

- To schedule, view, and change all tasks on the remote computer, you must be a member of the Administrators group on the remote computer, or you must use the **/u** parameter to provide the credentials of an Administrator of the remote computer.

- You can use the **/u** parameter in a **/create** or **/change** operation if the local and remote computers are in the same domain, or if the local computer is in a domain that the remote computer domain trusts. Otherwise, the remote computer can't authenticate the user account specified, and it can't verify that the account is a member of the Administrators group.

- The task you plan to run must have the appropriate permission; these permissions vary by task. By default, tasks run with the permissions of the current user of the local computer, or with the permissions of the user specified by the **/u** parameter, if one is included. To run a task with permissions of a different user account or with system permissions, use the **/ru** parameter.

## Syntax

```
schtasks /change
schtasks /create
schtasks /delete
schtasks /end
schtasks /query
schtasks /run
```

### Parameters

| Parameter | Description |
|--|--|
| [schtasks change](schtasks-change.md) | Changes one or more of the following properties of a task:<ul><li>The program that the task runs (/tr)</li><li>The user account under which the task runs (/ru)</li><li>The password for the user account (/rp)</li><li>Adds the interactive-only property to the task (/it)</li></ul> |
| [schtasks create](schtasks-create.md) | Schedules a new task.|
| [schtasks delete](schtasks-delete.md) | Deletes a scheduled task. |
| [schtasks end](schtasks-end.md) | Stops a program started by a task. |
| [schtasks query](schtasks-query.md) | Displays tasks scheduled to run on the computer. |
| [schtasks run](schtasks-run.md) | Starts a scheduled task immediately. The **run** operation ignores the schedule, but uses the program file location, user account, and password saved in the task to run the task immediately. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
