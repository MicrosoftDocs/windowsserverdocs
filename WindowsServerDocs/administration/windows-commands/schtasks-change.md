---
title: schtasks change
description: Reference article for the schtasks change command, which schedules commands and programs to run periodically or at a specific time, adds and removes tasks from the schedule, starts and stops tasks on demand, and displays and changes scheduled tasks.
ms.topic: reference
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 06/30/2022
---

# schtasks change

Changes one or more of the following properties of a task:

- The program that the task runs (**/tr**)

- The user account under which the task runs (**/ru**)

- The password for the user account (**/rp**)

- Adds the interactive-only property to the task (**/it**)

## Required permissions

- To schedule, view, and change all tasks on the local computer, you must be a member of the Administrators group.

- To schedule, view, and change all tasks on the remote computer, you must be a member of the Administrators group on the remote computer, or you must use the **/u** parameter to provide the credentials of an Administrator of the remote computer.

- You can use the **/u** parameter in a **/create** or **/change** operation if the local and remote computers are in the same domain, or if the local computer is in a domain that the remote computer domain trusts. Otherwise, the remote computer can't authenticate the user account specified, and it can't verify that the account is a member of the Administrators group.

- The task you plan to run must have the appropriate permission; these permissions vary by task. By default, tasks run with the permissions of the current user of the local computer, or with the permissions of the user specified by the **/u** parameter, if one is included. To run a task with permissions of a different user account or with system permissions, use the **/ru** parameter.

## Syntax

```
schtasks /change /tn <Taskname> [/s <computer> [/u [<domain>\]<user> [/p <password>]]] [/ru <username>] [/rp <password>] [/tr <Taskrun>] [/st <Starttime>] [/ri <interval>] [/rl <level>] [{/et <Endtime> | /du <duration>} [/k]] [/sd <Startdate>] [/ed <Enddate>] [/{ENABLE | DISABLE}] [/it] [/z]
```

### Parameters

| Parameter | Description |
|--|--|
| /tn `<Taskname>` | Identifies the task to be changed. Enter the task name (**Note**: Task names that have a space in its name are required to be wrapped in double quotes). |
| /s `<computer>` | Specifies the name or IP address of a remote computer (with or without backslashes). The default is the local computer. |
| /u `[<domain>]` | Runs this command with the permissions of the specified user account. By default, the command runs with the permissions of the current user of the local computer. The specified user account must be a member of the Administrators group on the remote computer. The **/u** and **/p** parameters are valid only when you use **/s**. |
| /p `<password>` | Specifies the password of the user account specified in the **/u** parameter. If you use the **/u** parameter without the **/p** parameter or the password argument, schtasks will prompt you for a password. The **/u** and **/p** parameters are valid only when you use **/s**. |
| /ru `<username>` | Changes the user name under which the scheduled task has to run. For the system account, valid values are *""*, *"NT AUTHORITY\SYSTEM"*, or *"SYSTEM"*. |
| /rp `<password>` | Specifies a new password for the existing user account, or the user account specified by the **/ru** parameter. This parameter is ignored with used with the local System account. |
| /tr `<Taskrun>` | Changes the program that the task runs. Enter the fully qualified path and file name of an executable file, script file, or batch file. If you don't add the path, **schtasks** assumes that the file is in the `<systemroot>\System32` directory. The specified program replaces the original program run by the task. |
| /st `<Starttime>` | Specifies the start time for the task, using the 24-hour time format, HH:mm. For example, a value of 14:30 is equivalent to the 12-hour time of 2:30 PM. |
| /ri `<interval>` | Specifies the repetition interval for the scheduled task, in minutes. Valid range is 1 - 599940 (599940 minutes = 9999 hours). If either the **/et** or **/du** parameters are specified, the default is **10 minutes**. |
| /rl `<level>` | Specifies the Run Level for the job. Acceptable values are LIMITED (scheduled tasks will be ran with the least level of privileges, such as Standard User accounts) and HIGHEST (scheduled tasks will be ran with the highest level of privileges, such as Superuser accounts). (**Note**: LIMITED is the default value).
| /et `<Endtime>` | Specifies the end time for the task, using the 24-hour time format, HH:mm. For example, a value of 14:30 is equivalent to the 12-hour time of 2:30 PM. |
| /du `<duration>` | A value that specifies the duration to run the task. The time format is HH:mm (24-hour time). For example, a value of 14:30 is equivalent to the 12-hour time of 2:30 PM. |
| /k | Stops the program that the task runs at the time specified by **/et** or **/du**. Without **/k**, schtasks doesn't start the program again after it reaches the time specified by **/et** or **/du** nor does it stop the program if it's still running. This parameter is optional and valid only with a MINUTE or HOURLY schedule. |
| /sd `<Startdate>` | Specifies the first date on which the task should be run. The date format is MM/DD/YYYY. |
| /ed `<Enddate>` | Specifies the last date on which the task should be run. The format is MM/DD/YYYY. |
| /ENABLE | Specifies to enable the scheduled task. |
| /DISABLE | Specifies to disable the scheduled task. |
| /it | Specifies to run the scheduled task only when the run as user (the user account under which the task runs) is logged on to the computer. This parameter has no effect on tasks that run with system permissions or tasks that already have the interactive-only property set. You can't use a change command to remove the interactive-only property from a task. By default, run as user is the current user of the local computer when the task is scheduled or the account specified by the **/u** parameter, if one is used. However, if the command includes the **/ru** parameter, then the run as user is the account specified by the **/ru** parameter. |
| /z | Specifies to delete the task upon the completion of its schedule. |
| /? | Displays help at the command prompt. |

#### Remarks

- The **/tn** and **/s** parameters identify the task. The **/tr**, **/ru**, and **/rp** parameters specify properties of the task that you can change.

- The **/ru** and **/rp** parameters specify the permissions under which the task runs. The **/u** and **/p** parameters specify the permissions used to change the task.

- To change tasks on a remote computer, the user must be logged on to the local computer with an account that is a member of the Administrators group on the remote computer.

- To run a **/change** command with the permissions of a different user (**/u**, **/p**), the local computer must be in the same domain as the remote computer or must be in a domain that the remote computer domain trusts.

- The System account doesn't have interactive logon rights. Users don't see, and can't interact with, programs run with system permissions.
To identify tasks with the **/it** property, use a verbose query (**/query /v**). In a verbose query display of a task with **/it**, the Logon Mode field has a value of Interactive only.

## Examples

To change the program that the Virus Check task runs from *VirusCheck.exe* to *VirusCheck2.exe*, type:

```
schtasks /change /tn Virus Check /tr C:\VirusCheck2.exe
```

This command uses the **/tn** parameter to identify the task and the **/tr** parameter to specify the new program for the task. (You can't change the task name.)

To change the password of the user account for the *RemindMe* task on the remote computer, *Svr01*, type:

```
schtasks /change /tn RemindMe /s Svr01 /rp p@ssWord3
```

This procedure is required whenever the password for a user account expires or changes. If the password saved in a task is no longer valid, then the task doesn't run. The command uses the **/tn** parameter to identify the task and the **/s** parameter to specify the remote computer. It uses the **/rp** parameter to specify the new password, *p@ssWord3*.

To change the ChkNews task, which starts Notepad.exe every morning at 9:00 A.M., to start Internet Explorer instead, type:

```
schtasks /change /tn ChkNews /tr c:\program files\Internet Explorer\iexplore.exe /ru DomainX\Admin01
```

The command uses the **/tn** parameter to identify the task. It uses the **/tr** parameter to change the program that the task runs and the /ru parameter to change the user account under which the task runs. The **/ru** and **/rp** parameters, which provide the password for the user account, is not used. You must provide a password for the account, but you can use the **/ru** and **/rp** parameter and type the password in clear text, or wait for SchTasks.exe to prompt you for a password, and then enter the password in obscured text.

To change the SecurityScript task so that it runs with permissions of the System account, type:

```
schtasks /change /tn SecurityScript /ru
```

The command uses the **/ru** parameter to indicate the System account. Because tasks run with System account permissions do not require a password, SchTasks.exe does not prompt for one.

To add the interactive-only property to MyApp, an existing task, type:

```
schtasks /change /tn MyApp /it
```

This property assures that the task runs only when the run as user, that is, the user account under which the task runs, is logged on to the computer. The command uses the **/tn** parameter to identify the task and the **/it** parameter to add the interactive-only property to the task. Because the task already runs with the permissions of my user account, you don't need to change the **/ru** parameter for the task.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [schtasks create command](schtasks-create.md)

- [schtasks delete command](schtasks-delete.md)

- [schtasks end command](schtasks-end.md)

- [schtasks query command](schtasks-query.md)

- [schtasks run command](schtasks-run.md)
