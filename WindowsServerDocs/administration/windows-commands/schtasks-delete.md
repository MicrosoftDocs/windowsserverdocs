---
title: schtasks delete
description: Reference article for the schtasks delete command, which deletes a scheduled task from the schedule.
ms.topic: reference
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 09/16/2020
---

# schtasks delete

Deletes a scheduled task from the schedule. This command doesn't delete the program that the task runs or interrupt a running program.

## Syntax

```
schtasks /delete /tn {<taskname> | *} [/f] [/s <computer> [/u [<domain>\]<user> [/p <password>]]]
```

### Parameters

| Parameter | Description |
|--|--|
| /tn `{<taskname> | *}` | Identifies the task to be deleted. If you use the `*`, this command deletes all tasks scheduled for the computer, not just the tasks scheduled by the current user. |
| /f | Suppresses the confirmation message. The task is deleted without warning. |
| /s `<computer>` | Specifies the name or IP address of a remote computer (with or without backslashes). The default is the local computer. |
| /u `[<domain>]` | Runs this command with the permissions of the specified user account. By default, the command runs with the permissions of the current user of the local computer. The specified user account must be a member of the Administrators group on the remote computer. The **/u** and **/p** parameters are valid only when you use **/s**. |
| /p `<password>` | Specifies the password of the user account specified in the **/u** parameter. If you use the **/u** parameter without the **/p** parameter or the password argument, schtasks will prompt you for a password. The **/u** and **/p** parameters are valid only when you use **/s**. |
| /? | Displays help at the command prompt. |

## Examples

To delete the *Start Mail* task from the schedule of a remote computer.

```
schtasks /delete /tn Start Mail /s Svr16
```

This command uses the **/s** parameter to identify the remote computer.

To delete all tasks from the schedule of the local computer, including tasks scheduled by other users.

```
schtasks /delete /tn * /f
```

This command uses the **/tn &#42;** parameter to represent all tasks on the computer and the **/f** parameter to suppress the confirmation message.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [schtasks change command](schtasks-change.md)

- [schtasks create command](schtasks-create.md)

- [schtasks end command](schtasks-end.md)

- [schtasks query command](schtasks-query.md)

- [schtasks run command](schtasks-run.md)
