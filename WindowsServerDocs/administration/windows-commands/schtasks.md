---
title: schtasks
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2e713203-3dd8-491b-b9e1-9423618dc7e8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# schtasks



Schedules commands and programs to run periodically or at a specific time. Adds and removes tasks from the schedule, starts and stops tasks on demand, and displays and changes scheduled tasks.

To view the command syntax, click one of the following commands:
-   [schtasks create](#BKMK_create)
-   [schtasks change](#BKMK_change)
-   [schtasks run](#BKMK_run)
-   [schtasks end](#BKMK_end)
-   [schtasks delete](#BKMK_delete)
-   [schtasks query](#BKMK_query)

## Remarks

- **SchTasks.exe** performs the same operations as **Scheduled Tasks** in **Control Panel**. You can use these tools together and interchangeably.
- **Schtasks** replaces **At.exe**, a tool included in previous versions of Windows. Although **At.exe** is still included in the Windows Server 2003 family, **schtasks** is the recommended command-line task scheduling tool.
- The parameters in a **schtasks** command can appear in any order. Typing **schtasks** without any parameters performs a query.
- Permissions for **schtasks**  
  -   You must have permission to run the command. Any user can schedule a task on the local computer, and they can view and change the tasks that they scheduled. Members of the Administrators group can schedule, view, and change all tasks on the local computer.
  -   To schedule, view, or change a task on a remote computer, you must be member of the Administrators group on the remote computer, or you must use the **/u** parameter to provide the credentials of an Administrator of the remote computer.
  -   You can use the **/u** parameter in a **/create** or **/change** operation only when the local and remote computers are in the same domain or the local computer is in a domain that the remote computer domain trusts. Otherwise, the remote computer cannot authenticate the user account specified and it cannot verify that the account is a member of the Administrators group.
  -   The task must have permission to run. The permissions required vary with the task. By default, tasks run with the permissions of the current user of the local computer, or with the permissions of the user specified by the **/u** parameter, if one is included. To run a task with permissions of a different user account or with system permissions, use the **/ru** parameter.
- To verify that a scheduled task ran or to find out why a scheduled task did not run, see the Task Scheduler service transaction log, *SystemRoot*\SchedLgU.txt. This log records attempted runs initiated by all tools that use the service, including **Scheduled Tasks** and **SchTasks.exe**.
- On rare occasions, task files become corrupted. Corrupted tasks do not run. When you try to perform an operation on corrupted tasks, **SchTasks.exe** displays the following error message:  
  ```
  ERROR: The data is invalid.
  ```  
  You cannot recover corrupted tasks. To restore the task scheduling features of the system, use **SchTasks.exe** or **Scheduled Tasks** to delete the tasks from the system and reschedule them.

## <a name="BKMK_create"></a>schtasks create

Schedules a task.

**Schtasks** uses different parameter combinations for each schedule type. To see the combined syntax for creating tasks or to see the syntax for creating a task with a particular schedule type, click one of the following options.
-   [Combined syntax and parameter descriptions](#BKMK_syntax)
-   [To schedule a task that runs every N minutes](#BKMK_minutes)
-   [To schedule a task that runs every N hours](#BKMK_hours)
-   [To schedule a task that runs every N days](#BKMK_days)
-   [To schedule a task that runs every N weeks](#BKMK_weeks)
-   [To schedule a task that runs every N months](#BKMK_months)
-   [To schedule a task that runs on a specific day of the week](#BKMK_spec_day)
-   [To schedule a task that runs on a specific week of the month](#BKMK_spec_week)
-   [To schedule a task that runs on a specific date each month](#BKMK_spec_date)
-   [To schedule a task that runs on the last day of a month](#BKMK_last_day)
-   [To schedule a task that runs once](#BKMK_once)
-   [To schedule a task that runs every time the system starts](#BKMK_startup)
-   [To schedule a task that runs when a user logs on](#BKMK_logon)
-   [To schedule a task that runs when the system is idle](#BKMK_idle)
-   [To schedule a task that runs now](#BKMK_now)
-   [To schedule a task that runs with different permissions](#BKMK_diff_perms)
-   [To schedule a task that runs with system permissions](#BKMK_sys_perms)
-   [To schedule a task that runs more than one program](#BKMK_multi_progs)
-   [To schedule a task that runs on a remote computer](#BKMK_remote)

### <a name="BKMK_syntax"></a>Combined syntax and parameter descriptions

#### Syntax

```
schtasks /create /sc <ScheduleType> /tn <TaskName> /tr <TaskRun> [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]] [/ru {[<Domain>\]<User> | System}] [/rp <Password>] [/mo <Modifier>] [/d <Day>[,<Day>...] | *] [/m <Month>[,<Month>...]] [/i <IdleTime>] [/st <StartTime>] [/ri <Interval>] [{/et <EndTime> | /du <Duration>} [/k]] [/sd <StartDate>] [/ed <EndDate>] [/it] [/z] [/f]
```

#### Parameters

##### /sc \<ScheduleType>

Specifies the schedule type. Valid values are MINUTE, HOURLY, DAILY, WEEKLY, MONTHLY, ONCE, ONSTART, ONLOGON, ONIDLE.

|Schedule type|Description|
|-------------|-----------|
|MINUTE, HOURLY, DAILY, WEEKLY, MONTHLY|Specifies the time unit for the schedule.|
|ONCE|The task runs once at a specified date and time.|
|ONSTART|The task runs every time the system starts. You can specify a start date, or run the task the next time the system starts.|
|ONLOGON|The task runs whenever a user (any user) logs on. You can specify a date, or run the task the next time the user logs on.|
|ONIDLE|The task runs whenever the system is idle for a specified period of time. You can specify a date, or run the task the next time the system is idle.|

##### /tn \<TaskName>

Specifies a name for the task. Each task on the system must have a unique name. The name must conform to the rules for file names and must not exceed 238 characters. Use quotation marks to enclose names that include spaces.

##### /tr \<TaskRun>

Specifies the program or command that the task runs. Type the fully qualified path and file name of an executable file, script file, or batch file. The path name must not exceed 262 characters. If you omit the path, **schtasks** assumes that the file is in the *SystemRoot*\System32 directory.

##### /s \<Computer>

Schedules a task on the specified remote computer. Type the name or IP address of a remote computer (with or without backslashes). The default is the local computer. The **/u** and **/p** parameters are valid only when you use **/s**.

##### /u [\<Domain>\]<User>

Runs this command with the permissions of the specified user account. The default is the permissions of the current user of the local computer. The **/u** and **/p** parameters are valid only for scheduling a task on a remote computer (**/s**).

The permissions of the specified account are used to schedule the task and to run the task. To run the task with the permissions of a different user, use the **/ru** parameter.

The user account must be a member of the Administrators group on the remote computer. Also, the local computer must be in the same domain as the remote computer, or must be in a domain that is trusted by the remote computer domain.

##### /p \<Password>

Provides the password for the user account specified in the **/u** parameter. If you use the **/u** parameter, but omit the **/p** parameter or the password argument, **schtasks** prompts you for a password and obscures the text you type.

The **/u** and **/p** parameters are valid only for scheduling a task on a remote computer (**/s**).

##### /ru {[\<Domain>\]<User> | System}

Runs the task with permissions of the specified user account. By default, the task runs with the permissions of the current user of the local computer, or with the permission of the user specified by the **/u** parameter, if one is included. The **/ru** parameter is valid when scheduling tasks on local or remote computers.


|       Value        |                                                    Description                                                    |
|--------------------|-------------------------------------------------------------------------------------------------------------------|
| [\<Domain>\]<User> |                                       Specifies an alternate user account.                                        |
|    System or ""    | Specifies the local System account, a highly privileged account used by the operating system and system services. |

##### /rp \<Password>

Provides the password for the user account that is specified in the **/ru** parameter. If you omit this parameter when specifying a user account, **SchTasks.exe** prompts you for the password and obscures the text you type.

Do not use the **/rp** parameter for tasks run with System account credentials (**/ru System**). The System account does not have a password and **SchTasks.exe** does not prompt for one.

##### /mo \<Modifier>

Specifies how often the task runs within its schedule type. This parameter is valid, but optional, for a MINUTE, HOURLY, DAILY, WEEKLY, and MONTHLY schedule. The default value is 1.

|Schedule type|Modifier values|Description|
|-------------|---------------|-----------|
|MINUTE|1 - 1439|The task runs every \<N> minutes.|
|HOURLY|1 - 23|The task runs every \<N> hours.|
|DAILY|1 - 365|The task runs every \<N> days.|
|WEEKLY|1 - 52|The task runs every \<N> weeks.|
|ONCE|No modifiers.|The task runs once.|
|ONSTART|No modifiers.|The task runs at startup.|
|ONLOGON|No modifiers.|The task runs when the user specified by the **/u** parameter logs on.|
|ONIDLE|No modifiers.|The task runs after the system is idle for the number of minutes specified by the **/i** parameter, which is required for use with ONIDLE.|
|MONTHLY|1 - 12|The task runs every \<N> months.|
|MONTHLY|LASTDAY|The task runs on the last day of the month.|
|MONTHLY|FIRST, SECOND, THIRD, FOURTH, LAST|Use with the **/d**\<Day> parameter to run a task on a particular week and day. For example, on the third Wednesday of the month.|

##### /d Day[,Day...] | *

Specifies a day (or days) of the week or a day (or days) of a month. Valid only with a WEEKLY or MONTHLY schedule.


| Schedule type |              Modifier              |     Day values (/d)      |                                                                                                 Description                                                                                                 |
|---------------|------------------------------------|--------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    WEEKLY     |               1 - 52               | MON - SUN[,MON - SUN...] |                                                                                                     \*                                                                                                      |
|    MONTHLY    | FIRST, SECOND, THIRD, FOURTH, LAST |        MON - SUN         |                                                                                   Required for a specific week schedule.                                                                                    |
|    MONTHLY    |          None or {1 - 12}          |          1 - 31          | Optional and valid only with no modifier (**/mo**) parameter (a specific date schedule) or when the **/mo** is 1 - 12 (an "every \<N> months" schedule). The default is day 1 (the first day of the month). |

##### /m Month[,Month...]

Specifies a month or months of the year during which the scheduled task should run. Valid values are JAN - DEC and * (every month). The **/m** parameter is valid only with a MONTHLY schedule. It is required when the LASTDAY modifier is used. Otherwise, it is optional and the default value is * (every month).

##### /i \<IdleTime>

Specifies how many minutes the computer is idle before the task starts. A valid value is a whole number from 1 to 999. This parameter is valid only with an ONIDLE schedule, and then it is required.

##### /st \<StartTime>

Specifies the time of day that the task starts (each time it starts) in \<HH:MM> 24-hour format. The default value is the current time on the local computer. The **/st** parameter is valid with MINUTE, HOURLY, DAILY, WEEKLY, MONTHLY, and ONCE schedules. It is required for a ONCE schedule.

##### /ri \<Interval>

Specifies the repetition interval in minutes. This is not applicable for schedule types: MINUTE, HOURLY, ONSTART, ONLOGON, and ONIDLE. Valid range is 1 to 599940 minutes (599940 minutes = 9999 hours). If either /ET or /DU is specified, then the repetition interval defaults to 10 minutes.

##### /et \<EndTime>

Specifies the time of day that a minute or hourly task schedule ends in \<HH:MM> 24-hour format. After the specified end time, **schtasks** does not start the task again until the start time recurs. By default, task schedules have no end time. This parameter is optional and valid only with a MINUTE or HOURLY schedule.

For an example, see:
-   "To schedule a task that runs every 100 minutes during non-business hours" in the **To schedule a task that runs every** \<N> **minutes** section.

##### /du \<Duration>

Specifies a maximum length of time for a minute or hourly schedule in \<HHHH:MM> 24-hour format. After the specified time elapses, **schtasks** does not start the task again until the start time recurs. By default, task schedules have no maximum duration. This parameter is optional and valid only with a MINUTE or HOURLY schedule.

For an example, see:
-   "To schedule a task that runs every 3 hours for 10 hours" in the **To schedule a task that runs every** \<N> **hours** section.

##### /k

Stops the program that the task runs at the time specified by **/et** or **/du**. Without **/k**, **schtasks** does not start the program again after it reaches the time specified by **/et** or **/du**, but it does not stop the program if it is still running. This parameter is optional and valid only with a MINUTE or HOURLY schedule.

For an example, see:
-   "To schedule a task that runs every 100 minutes during non-business hours" in the **To schedule a task that runs every** \<N> **minutes** section.

##### /sd \<StartDate>

Specifies the date on which the task schedule starts. The default value is the current date on the local computer. The **/sd** parameter is valid and optional for all schedule types.

The format for *StartDate* varies with the locale selected for the local computer in **Regional and Language Options** in **Control Panel**. Only one format is valid for each locale.

The valid date formats are listed in the following table. Use the format most similar to the format selected for **Short date** in **Regional and Language Options** in **Control Panel** on the local computer.


|       Value       |                                        Description                                         |
|-------------------|--------------------------------------------------------------------------------------------|
| \<MM>/<DD>/<YYYY> | Use for month-first formats, such as **English (United States)** and **Spanish (Panama)**. |
| \<DD>/<MM>/<YYYY> |       Use for day-first formats, such as **Bulgarian** and **Dutch (Netherlands)**.        |
| \<YYYY>/<MM>/<DD> |          Use for year-first formats, such as **Swedish** and **French (Canada)**.          |

/ed \<EndDate>

Specifies the date on which the schedule ends. This parameter is optional. It is not valid in a ONCE, ONSTART, ONLOGON, or ONIDLE schedule. By default, schedules have no ending date.

The format for *EndDate* varies with the locale selected for the local computer in **Regional and Language Options** in **Control Panel**. Only one format is valid for each locale.

The valid date formats are listed in the following table. Use the format most similar to the format selected for **Short date** in **Regional and Language Options** in **Control Panel** on the local computer.


|       Value       |                                        Description                                         |
|-------------------|--------------------------------------------------------------------------------------------|
| \<MM>/<DD>/<YYYY> | Use for month-first formats, such as **English (United States)** and **Spanish (Panama)**. |
| \<DD>/<MM>/<YYYY> |       Use for day-first formats, such as **Bulgarian** and **Dutch (Netherlands)**.        |
| \<YYYY>/<MM>/<DD> |          Use for year-first formats, such as **Swedish** and **French (Canada)**.          |

##### /it

Specifies to run the task only when the "run as" user (the user account under which the task runs) is logged on to the computer. This parameter has no effect on tasks that run with system permissions.

By default, the "run as" user is the current user of the local computer when the task is scheduled or the account specified by the **/u** parameter, if one is used. However, if the command includes the **/ru** parameter, then the "run as" user is the account specified by the **/ru** parameter.

For examples, see:
-   "To schedule a task that runs every 70 days if I am logged on" in the **To schedule a task that runs every** *N* **days** section.
-   "To run a task only when a particular user is logged on" in the **To schedule a task that runs with different permissions** section.

##### /z

Specifies to delete the task upon completion of its schedule.

##### /f

Specifies to create the task and suppress warnings if the specified task already exists.

##### /?

Displays help at the command prompt.

### <a name="BKMK_minutes"></a>To schedule a task that runs every N minutes

#### Minute Schedule Syntax

```
schtasks /create /tn <TaskName> /tr <TaskRun> /sc minute [/mo {1 - 1439}] [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [{/et <HH:MM> | /du <HHHH:MM>} [/k]] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

#### Remarks

In a minute schedule, the **/sc minute** parameter is required. The **/mo** (modifier) parameter is optional and specifies the number of minutes between each run of the task. The default value for **/mo** is 1 (every minute). The **/et** (end time) and **/du** (duration) parameters are optional and can be used with or without the **/k** (end task) parameter.

#### Examples

#### To schedule a task that runs every 20 minutes

The following command schedules a security script, Sec.vbs, to run every 20 minutes. The command uses the **/sc** parameter to specify a minute schedule and the **/mo** parameter to specify an interval of 20 minutes.

Because the command does not include a starting date or time, the task starts 20 minutes after the command completes, and runs every 20 minutes thereafter whenever the system is running. Notice that the security script source file is located on a remote computer, but that the task is scheduled and executes on the local computer.
```
schtasks /create /sc minute /mo 20 /tn "Security Script" /tr \\central\data\scripts\sec.vbs
```

#### To schedule a task that runs every 100 minutes during non-business hours

The following command schedules a security script, Sec.vbs, to run on the local computer every 100 minutes between 5:00 P.M. and 7:59 A.M. each day. The command uses the **/sc** parameter to specify a minute schedule and the **/mo** parameter to specify an interval of 100 minutes. It uses the **/st** and **/et** parameters to specify the start time and end time of each day's schedule. It also uses the **/k** parameter to stop the script if it is still running at 7:59 A.M. Without **/k**, **schtasks** would not start the script after 7:59 A.M., but if the instance started at 6:20 A.M. was still running, it would not stop it.
```
schtasks /create /tn "Security Script" /tr sec.vbs /sc minute /mo 100 /st 17:00 /et 08:00 /k
```

### <a name="BKMK_hours"></a>To schedule a task that runs every N hours

#### Hourly Schedule Syntax

```
schtasks /create /tn <TaskName> /tr <TaskRun> /sc hourly [/mo {1 - 23}] [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [{/et <HH:MM> | /du <HHHH:MM>} [/k]] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

#### Remarks

In an hourly schedule, the **/sc hourly** parameter is required. The **/mo** (modifier) parameter is optional and specifies the number of hours between each run of the task. The default value for **/mo** is 1 (every hour). The **/k** (end task) parameter is optional and can be used with either **/et** (end at the specified time) or **/du** (end after the specified interval).

#### Examples

#### To schedule a task that runs every five hours

The following command schedules the MyApp program to run every five hours beginning on the first day of March 2002. It uses the **/mo** parameter to specify the interval and the **/sd** parameter to specify the start date. Because the command does not specify a start time, the current time is used as the start time.

Because the local computer is set to use the **English (Zimbabwe)** option in **Regional and Language Options** in **Control Panel**, the format for the start date is MM/DD/YYYY (03/01/2002).
```
schtasks /create /sc hourly /mo 5 /sd 03/01/2002 /tn "My App" /tr c:\apps\myapp.exe
```

#### To schedule a task that runs every hour at five minutes past the hour

The following command schedules the MyApp program to run hourly beginning at five minutes past midnight. Because the **/mo** parameter is omitted, the command uses the default value for the hourly schedule, which is every (1) hour. If this command runs after 12:05 A.M., the program does not run until the next day.
```
schtasks /create /sc hourly /st 00:05 /tn "My App" /tr c:\apps\myapp.exe
```

#### To schedule a task that runs every 3 hours for 10 hours

The following command schedules the MyApp program to run every 3 hours for 10 hours.

The command uses the **/sc** parameter to specify an hourly schedule and the **/mo** parameter to specify the interval of 3 hours. It uses the **/st** parameter to start the schedule at midnight and the **/du** parameter to end the recurrences after 10 hours. Because the program runs for just a few minutes, the **/k** parameter, which stops the program if it is still running when the duration expires, is not necessary.
```
schtasks /create /tn "My App" /tr myapp.exe /sc hourly /mo 3 /st 00:00 /du 0010:00
```
In this example, the task runs at 12:00 A.M., 3:00 A.M., 6:00 A.M., and 9:00 A.M. Because the duration is 10 hours, the task is not run again at 12:00 P.M. Instead, it starts again at 12:00 A.M. the next day.

### <a name="BKMK_days"></a>To schedule a task that runs every N days

#### Daily Schedule Syntax

```
schtasks /create /tn <TaskName> /tr <TaskRun> /sc daily [/mo {1 - 365}] [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

#### Remarks

In a daily schedule, the **/sc daily** parameter is required. The **/mo** (modifier) parameter is optional and specifies the number of days between each run of the task. The default value for **/mo** is 1 (every day).

#### Examples

#### To schedule a task that runs every day

The following example schedules the MyApp program to run once a day, every day, at 8:00 A.M. until December 31, 2002. Because it omits the **/mo** parameter, the default interval of 1 is used to run the command every day.

In this example, because the local computer system is set to the **English (United Kingdom)** option in **Regional and Language Options** in **Control Panel**, the format for the end date is DD/MM/YYYY (31/12/2002)
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc daily /st 08:00 /ed 31/12/2002
```

#### To schedule a task that runs every 12 days

The following example schedules the MyApp program to run every twelve days at 1:00 P.M. (13:00) beginning on December 31, 2002. The command uses the **/mo** parameter to specify an interval of two (2) days and the **/sd** and **/st** parameters to specify the date and time.

In this example, because the system is set to the **English (Zimbabwe)** option in **Regional and Language Options** in **Control Panel**, the format for the end date is MM/DD/YYYY (12/31/2002)
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc daily /mo 12 /sd 12/31/2002 /st 13:00
```

#### To schedule a task that runs every 70 days if I am logged on

The following command schedules a security script, Sec.vbs, to run every 70 days. The command uses the **/mo** parameter to specify an interval of 70 days. It also uses the **/it** parameter to specify that the task runs only when the user under whose account the task runs is logged onto the computer. Because the task will run with the permissions of my user account, then the task will run only when I am logged on.
```
schtasks /create /tn "Security Script" /tr sec.vbs /sc daily /mo 70 /it
```

> [!NOTE]
> To identify tasks with the interactive-only (**/it**) property, use a verbose query **(/query /v**). In a verbose query display of a task with **/it**, the **Logon Mode** field has a value of **Interactive only**.

### <a name="BKMK_weeks"></a>To schedule a task that runs every N weeks

#### Weekly Schedule Syntax

```
schtasks /create /tn <TaskName> /tr <TaskRun> /sc weekly [/mo {1 - 52}] [/d {<MON - SUN>[,MON - SUN...] | *}] [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

#### Remarks

In a weekly schedule, the **/sc weekly** parameter is required. The **/mo** (modifier) parameter is optional and specifies the number of weeks between each run of the task. The default value for **/mo** is 1 (every week).

Weekly schedules also have an optional **/d** parameter to schedule the task to run on specified days of the week, or on all days (*). The default is MON (Monday). The every day (*) option is equivalent to scheduling a daily task.

#### Examples

#### To schedule a task that runs every six weeks

The following command schedules the MyApp program to run on a remote computer every six weeks. The command uses the **/mo** parameter to specify the interval. Because the command omits the **/d** parameter, the task runs on Mondays.

This command also uses the **/s** parameter to specify the remote computer and the **/u** parameter to run the command with the permissions of the user's Administrator account. Because the **/p** parameter is omitted, **SchTasks.exe** prompts the user for the Administrator account password.

Also, because the command is run remotely, all paths in the command, including the path to MyApp.exe, refer to paths on the remote computer.
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc weekly /mo 6 /s Server16 /u Admin01
```

#### To schedule a task that runs every other week on Friday

The following command schedules a task to run every other Friday. It uses the **/mo** parameter to specify the two-week interval and the **/d** parameter to specify the day of the week. To schedule a task that runs every Friday, omit the **/mo** parameter or set it to 1.
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc weekly /mo 2 /d FRI
```

### <a name="BKMK_months"></a>To schedule a task that runs every N months

#### Syntax

```
schtasks /create /tn <TaskName> /tr <TaskRun> /sc monthly [/mo {1 - 12}] [/d {1 - 31}] [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

#### Remarks

In this schedule type, the **/sc monthly** parameter is required. The **/mo** (modifier) parameter, which specifies the number of months between each run of the task, is optional and the default is 1 (every month). This schedule type also has an optional **/d** parameter to schedule the task to run on a specified date of the month. The default is 1 (the first day of the month).

#### Examples

#### To schedule a task that runs on the first day of every month

The following command schedules the MyApp program to run on the first day of every month. Because a value of 1 is the default for both the **/mo** (modifier) parameter and the **/d** (day) parameter, these parameters are omitted from the command.
```
schtasks /create /tn "My App" /tr myapp.exe /sc monthly
```

#### To schedule a task that runs every three months

The following command schedules the MyApp program to run every three months. It uses the **/mo** parameter to specify the interval.
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc monthly /mo 3
```

#### To schedule a task that runs at midnight on the 21st day of every other month

The following command schedules the MyApp program to run every other month on the 21st day of the month at midnight. The command specifies that this task should run for one year, from July 2, 2002 to June 30, 2003.

The command uses the **/mo** parameter to specify the monthly interval (every two months), the **/d** parameter to specify the date, and the **/st** to specify the time. It also uses the **/sd** and **/ed** parameters to specify the start date and end date, respectively. Because the local computer is set to the **English (South Africa)** option in **Regional and Language Options** in **Control Panel**, the dates are specified in the local format, YYYY/MM/DD.
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc monthly /mo 2 /d 21 /st 00:00 /sd 2002/07/01 /ed 2003/06/30 
```

### <a name="BKMK_spec_day"></a>To schedule a task that runs on a specific day of the week

#### Weekly Schedule Syntax

```
schtasks /create /tn <TaskName> /tr <TaskRun> /sc weekly [/d {<MON - SUN>[,MON - SUN...] | *}] [/mo {1 - 52}] [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

#### Remarks

The "day of the week" schedule is a variation of the weekly schedule. In a weekly schedule, the **/sc weekly** parameter is required. The **/mo** (modifier) parameter is optional and specifies the number of weeks between each run of the task. The default value for **/mo** is 1 (every week). The **/d** parameter, which is optional, schedules the task to run on specified days of the week, or on all days (<em>). The default is MON (Monday). The every day option (</em>*/d \***) is equivalent to scheduling a daily task.

#### Examples

#### To schedule a task that runs every Wednesday

The following command schedules the MyApp program to run every week on Wednesday. The command uses the **/d** parameter to specify the day of the week. Because the command omits the **/mo** parameter, the task runs every week.
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc weekly /d WED
```

#### To schedule a task that runs every eight weeks on Monday and Friday

The following command schedules a task to run on Monday and Friday of every eighth week. It uses the **/d** parameter to specify the days and the **/mo** parameter to specify the eight-week interval.
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc weekly /mo 8 /d MON,FRI
```

### <a name="BKMK_spec_week"></a>To schedule a task that runs on a specific week of the month

#### Specific Week Syntax

```
schtasks /create /tn <TaskName> /tr <TaskRun> /sc monthly /mo {FIRST | SECOND | THIRD | FOURTH | LAST} /d MON - SUN [/m {JAN - DEC[,JAN - DEC...] | *}] [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

#### Remarks

In this schedule type, the **/sc monthly** parameter, the **/mo** (modifier) parameter, and the **/d** (day) parameter are required. The **/mo** (modifier) parameter specifies the week on which the task runs. The **/d** parameter specifies the day of the week. (You can specify only one day of the week for this schedule type.) This schedule also has an optional **/m** (month) parameter that lets you schedule the task for particular months or every month (<em>). The default for the **/m</em>* parameter is every month (*).

#### Examples

#### To schedule a task for the second Sunday of every month

The following command schedules the MyApp program to run on the second Sunday of every month. It uses the **/mo** parameter to specify the second week of the month and the **/d** parameter to specify the day.
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc monthly /mo SECOND /d SUN
```

#### To schedule a task for the first Monday in March and September

The following command schedules the MyApp program to run on the first Monday in March and September. It uses the **/mo** parameter to specify the first week of the month and the **/d** parameter to specify the day. It uses **/m** parameter to specify the month, separating the month arguments with a comma.
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc monthly /mo FIRST /d MON /m MAR,SEP
```

### <a name="BKMK_spec_date"></a>To schedule a task that runs on a specific date each month

#### Specific date syntax

```
schtasks /create /tn <TaskName> /tr <TaskRun> /sc monthly /d {1 - 31} [/m {JAN - DEC[,JAN - DEC...] | *}] [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

#### Remarks

In the specific date schedule type, the **/sc monthly** parameter and the **/d** (day) parameter are required. The **/d** parameter specifies a date of the month (1 - 31), not a day of the week. You can specify only one day in the schedule. The **/mo** (modifier) parameter is not valid with this schedule type.

The **/m** (month) parameter is optional for this schedule type and the default is every month (<em>). **Schtasks</em>* does not let you schedule a task for a date that does not occur in a month specified by the **/m** parameter. However, if omit the **/m** parameter, and schedule a task for a date that does not appear in every month, such as the 31st day, then the task does not run in the shorter months. To schedule a task for the last day of the month, use the last day schedule type.

#### Examples

#### To schedule a task for the first day of every month

The following command schedules the MyApp program to run on the first day of every month. Because the default modifier is none (no modifier), the default day is day 1, and the default month is every month, the command does not need any additional parameters.
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc monthly
```

#### To schedule a task for the 15th days of May and June

The following command schedules the MyApp program to run on May 15 and June 15 at 3:00 P.M. (15:00). It uses the **/m** parameter to specify the date and the **/m** parameter to specify the months. It also uses the **/st** parameter to specify the start time.
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc monthly /d 15 /m MAY,JUN /st 15:00
```

### <a name="BKMK_last_day"></a>To schedule a task that runs on the last day of a month

#### Last day syntax

```
schtasks /create /tn <TaskName> /tr <TaskRun> /sc monthly /mo LASTDAY /m {JAN - DEC[,JAN - DEC...] | *} [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

#### Remarks

In the last day schedule type, the **/sc monthly** parameter, the **/mo LASTDAY** (modifier) parameter, and the **/m** (month) parameter are required. The **/d** (day) parameter is not valid.

#### Examples

#### To schedule a task for the last day of every month

The following command schedules the MyApp program to run on the last day of every month. It uses the **/mo** parameter to specify the last day and the **/m** parameter with the wildcard character (*) to indicate that the program runs every month.
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc monthly /mo lastday /m *
```

#### To schedule a task at 6:00 P.M. on the last days of February and March

The following command schedules the MyApp program to run on the last day of February and the last day of March at 6:00 P.M. It uses the **/mo** parameter to specify the last day, the **/m** parameter to specify the months, and the **/st** parameter to specify the start time.
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc monthly /mo lastday /m FEB,MAR /st 18:00
```

### <a name="BKMK_once"></a>To schedule a task that runs once

#### Syntax

```
schtasks /create /tn <TaskName> /tr <TaskRun> /sc once /st <HH:MM> [/sd <StartDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

#### Remarks

In the run-once schedule type, the **/sc once** parameter is required. The **/st** parameter, which specifies the time that the task runs, is required. The **/sd** parameter, which specifies the date that the task runs, is optional. The **/mo** (modifier) and **/ed** (end date) parameters are not valid for this schedule type.

**Schtasks** does not permit you to schedule a task to run once if the date and time specified are in the past, based on the time of the local computer. To schedule a task that runs once on a remote computer in a different time zone, you must schedule it before that date and time occurs on the local computer.

#### Examples

#### To schedule a task that runs one time

The following command schedules the MyApp program to run at midnight on January 1, 2003. It uses the **/sc** parameter to specify the schedule type and the **/sd** and **st** to specify the date and time.

Because the local computer uses the **English (United States)** option in **Regional and Language Options** in **Control Panel**, the format for the start date is MM/DD/YYYY.
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc once /sd 01/01/2003 /st 00:00
```

### <a name="BKMK_startup"></a>To schedule a task that runs every time the system starts

#### Syntax

```
schtasks /create /tn <TaskName> /tr <TaskRun> /sc onstart [/sd <StartDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

#### Remarks

In the on-start schedule type, the **/sc onstart** parameter is required. The **/sd** (start date) parameter is optional and the default is the current date.

#### Examples

#### To schedule a task that runs when the system starts

The following command schedules the MyApp program to run every time the system starts, beginning on March 15, 2001:

Because the local computer is uses the **English (United States)** option in **Regional and Language Options** in **Control Panel**, the format for the start date is MM/DD/YYYY.
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc onstart /sd 03/15/2001
```

### <a name="BKMK_logon"></a>To schedule a task that runs when a user logs on

#### Syntax

```
schtasks /create /tn <TaskName> /tr <TaskRun> /sc onlogon [/sd <StartDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

#### Remarks

The "on logon" schedule type schedules a task that runs whenever any user logs on to the computer. In the "on logon" schedule type, the **/sc onlogon** parameter is required. The **/sd** (start date) parameter is optional and the default is the current date.

#### Examples

#### To schedule a task that runs when a user logs on to a remote computer

The following command schedules a batch file to run every time a user (any user) logs on to the remote computer. It uses the **/s** parameter to specify the remote computer. Because the command is remote, all paths in the command, including the path to the batch file, refer to a path on the remote computer.
```
schtasks /create /tn "Start Web Site" /tr c:\myiis\webstart.bat /sc onlogon /s Server23
```

### <a name="BKMK_idle"></a>To schedule a task that runs when the system is idle

#### Syntax

```
schtasks /create /tn <TaskName> /tr <TaskRun> /sc onidle /i {1 - 999} [/sd <StartDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

#### Remarks

The "on idle" schedule type schedules a task that runs whenever there is no user activity during the time specified by the **/i** parameter. In the "on idle" schedule type, the **/sc onidle** parameter and the **/i** parameter are required. The **/sd** (start date) is optional and the default is the current date.

#### Examples

#### To schedule a task that runs whenever the computer is idle

The following command schedules the MyApp program to run whenever the computer is idle. It uses the required **/i** parameter to specify that the computer must remain idle for ten minutes before the task starts.
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc onidle /i 10
```

### <a name="BKMK_now"></a>To schedule a task that runs now

**Schtasks** does not have a "run now" option, but you can simulate that option by creating a task that runs once and starts in a few minutes.

#### Syntax

```
schtasks /create /tn <TaskName> /tr <TaskRun> /sc once [/st <HH:MM>] /sd <MM/DD/YYYY> [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

#### Examples

#### To schedule a task that runs a few minutes from now.

The following command schedules a task to run once, on November 13, 2002 at 2:18 P.M. local time.

Because the local computer is uses the **English (United States)** option in **Regional and Language Options** in **Control Panel**, the format for the start date is MM/DD/YYYY.
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc once /st 14:18 /sd 11/13/2002
```

### <a name="BKMK_diff_perms"></a>To schedule a task that runs with different permissions

You can schedule tasks of all types to run with permissions of an alternate account on both the local and a remote computer. In addition to the parameters required for the particular schedule type, the **/ru** parameter is required and the **/rp** parameter is optional.

#### Examples

#### To run a task with Administrator permissions on the local computer

The following command schedules the MyApp program to run on the local computer. It uses the **/ru** to specify that the task should run with the permissions of the user's Administrator account (Admin06). In this example, the task is scheduled to run every Tuesday, but you can use any schedule type for a task run with alternate permissions.
```
schtasks /create /tn "My App" /tr myapp.exe /sc weekly /d TUE /ru Admin06
```
In response, **SchTasks.exe** prompts for the "run as" password for the Admin06 account and then displays a success message.
```
Please enter the run as password for Admin06: ********
SUCCESS: The scheduled task "My App" has successfully been created.
```

#### To run a task with alternate permissions on a remote computer

The following command schedules the MyApp program to run on the Marketing computer every four days.

The command uses the **/sc** parameter to specify a daily schedule and **/mo** parameter to specify an interval of four days.

The command uses the **/s** parameter to provide the name of the remote computer and the **/u** parameter to specify an account with permission to schedule a task on the remote computer (Admin01 on the Marketing computer). It also uses the **/ru** parameter to specify that the task should run with the permissions of the user's non-Administrator account (User01 in the Reskits domain). Without the **/ru** parameter, the task would run with the permissions of the account specified by **/u**.
```
schtasks /create /tn "My App" /tr myapp.exe /sc daily /mo 4 /s Marketing /u Marketing\Admin01 /ru Reskits\User01
```
**Schtasks** first requests the password of the user named by the **/u** parameter (to run the command) and then requests the password of the user named by the **/ru** parameter (to run the task). After authenticating the passwords, **schtasks** displays a message indicating that the task is scheduled.
```
Type the password for Marketing\Admin01:********

Please enter the run as password for Reskits\User01: ********

SUCCESS: The scheduled task "My App" has successfully been created.
```

#### To run a task only when a particular user is logged on

The following command schedules the AdminCheck.exe program to run on the Public computer every Friday at 4:00 A.M., but only if the administrator of the computer is logged on.

The command uses the **/sc** parameter to specify a weekly schedule, the **/d** parameter to specify the day, and the **/st** parameter to specify the start time.

The command uses the **/s** parameter to provide the name of the remote computer and the **/u** parameter to specify an account with permission to schedule a task on the remote computer. It also uses the **/ru** parameter to configure the task to run with the permissions of the administrator of the Public computer (Public\Admin01) and the **/it** parameter to indicate that the task runs only when the Public\Admin01 account is logged on.
```
schtasks /create /tn "Check Admin" /tr AdminCheck.exe /sc weekly /d FRI /st 04:00 /s Public /u Domain3\Admin06 /ru Public\Admin01 /it
```
**Note**
-   To identify tasks with the interactive-only (**/it**) property, use a verbose query **(/query /v**). In a verbose query display of a task with **/it**, the **Logon Mode** field has a value of **Interactive only**.

### <a name="BKMK_sys_perms"></a>To schedule a task that runs with system permissions

Tasks of all types can run with permissions of the System account on both the local and a remote computer. In addition to the parameters required for the particular schedule type, the **/ru system** (or **/ru ""**) parameter is required and the **/rp** parameter is not valid.

**Important**
-   The System account does not have interactive logon rights. Users cannot see or  interact with programs or tasks run with system permissions.
-   The **/ru** parameter determines the permissions under which the task runs, not the permissions used to schedule the task. Only Administrators can schedule tasks, regardless of the value of the **/ru** parameter.

**Note**

To identify tasks that run with system permissions, use a verbose query (**/query** **/v**). In a verbose query display of a system-run task, the **Run As User** field has a value of **NT AUTHORITY\SYSTEM** and the **Logon Mode** field has a value of **Background only**.

#### Examples

#### To run a task with system permissions

The following command schedules the MyApp program to run on the local computer with permissions of the System account. In this example, the task is scheduled to run on the fifteenth day of every month, but you can use any schedule type for a task run with system permissions.

The command uses the **/ru System** parameter to specify the system security context. Because system tasks do not use a password, the **/rp** parameter is omitted.
```
schtasks /create /tn "My App" /tr c:\apps\myapp.exe /sc monthly /d 15 /ru System
```
In response, **SchTasks.exe** displays an informational message and a success message. It does not prompt for a password.
```
INFO: The task will be created under user name ("NT AUTHORITY\SYSTEM").
SUCCESS: The Scheduled task "My App" has successfully been created.
```

#### To run a task with system permissions on a remote computer

The following command schedules the MyApp program to run on the Finance01 computer every morning at 4:00 A.M. with system permissions.

The command uses the **/tn** parameter to name the task and the **/tr** parameter to specify the remote copy of the MyApp program. It uses the **/sc** parameter to specify a daily schedule, but omits the **/mo** parameter because 1 (every day) is the default. It uses the **/st** parameter to specify the start time, which is also the time the task will run each day.

The command uses the **/s** parameter to provide the name of the remote computer and the **/u** parameter to specify an account with permission to schedule a task on the remote computer. It also uses the **/ru** parameter to specify that the task should run under the System account. Without the **/ru** parameter, the task would run with the permissions of the account specified by **/u**.
```
schtasks /create /tn "My App" /tr myapp.exe /sc daily /st 04:00 /s Finance01 /u Admin01 /ru System
```
**Schtasks** requests the password of the user named by the **/u** parameter and, after authenticating the password, displays a message indicating that the task is created and that it will run with permissions of the System account.
```
Type the password for Admin01:**********

INFO: The Schedule Task "My App" will be created under user name ("NT AUTHORITY\
SYSTEM").
SUCCESS: The scheduled task "My App" has successfully been created.
```

### <a name="BKMK_multi_progs"></a>To schedule a task that runs more than one program

Each task runs only one program. However, you can create a batch file that runs multiple programs and then schedule a task to run the batch file. The following procedure demonstrates this method:
1. Create a batch file that starts the programs you want to run.

   In this example, you create a batch file that starts Event Viewer (Eventvwr.exe) and System Monitor (Perfmon.exe).  
   - Open a text editor, such as Notepad.
   - Type the name and fully qualified path to the executable file for each program. In this case, the file includes the following statements.  
     ```
     C:\Windows\System32\Eventvwr.exe 
     C:\Windows\System32\Perfmon.exe
     ```  
   - Save the file as MyApps.bat.
2. Use **Schtasks.exe** to create a task that runs MyApps.bat.

   The following command creates the Monitor task, which runs whenever anyone logs on. It uses the **/tn** parameter to name the task, and the **/tr** parameter to run MyApps.bat. It uses the **/sc** parameter to indicate the OnLogon schedule type and the **/ru** parameter to run the task with the permissions of the user's Administrator account.  
   ```
   schtasks /create /tn Monitor /tr C:\MyApps.bat /sc onlogon /ru Reskit\Administrator
   ```  
   As a result of this command, whenever a user logs on to the computer, the task starts both Event Viewer and System Monitor.

### <a name="BKMK_remote"></a>To schedule a task that runs on a remote computer

To schedule a task to run on a remote computer, you must add the task to the remote computer's schedule. Tasks of all types can be scheduled on a remote computer, but the following conditions must be met.
-   You must have permission to schedule the task. As such, you must be logged on to the local computer with an account that is a member of the Administrators group on the remote computer, or you must use the **/u** parameter to provide the credentials of an Administrator of the remote computer.
-   You can use the **/u** parameter only when the local and remote computers are in the same domain or the local computer is in a domain that the remote computer domain trusts. Otherwise, the remote computer cannot authenticate the user account specified and it cannot verify that the account is a member of the Administrators group.
-   The task must have sufficient permission to run on the remote computer. The permissions required vary with the task. By default, the task runs with the permission of the current user of the local computer or, if the **/u** parameter is used, the task runs with the permission of the account specified by the **/u** parameter. However, you can use the **/ru** parameter to run the task with permissions of a different user account or with system permissions.

#### Examples

#### An Administrator schedules a task on a remote computer

The following command schedules the MyApp program to run on the SRV01 remote computer every ten days starting immediately. The command uses the **/s** parameter to provide the name of the remote computer. Because the local current user is an Administrator of the remote computer, the **/u** parameter, which provides alternate permissions for scheduling the task, is not necessary.

Please note that when scheduling tasks on a remote computer, all parameters refer to the remote computer. Therefore, the executable file specified by the **/tr** parameter refers to the copy of MyApp.exe on the remote computer.
```
schtasks /create /s SRV01 /tn "My App" /tr "c:\program files\corpapps\myapp.exe" /sc daily /mo 10
```
In response, **schtasks** displays a success message indicating that the task is scheduled.

#### A user schedules a command on a remote computer (Case 1)

The following command schedules the MyApp program to run on the SRV06 remote computer every three hours. Because Administrator permissions are required to schedule a task, the command uses the **/u** and **/p** parameters to provide the credentials of the user's Administrator account (Admin01 in the Reskits domain). By default, these permissions are also used to run the task. However, because the task does not need Administrator permissions to run, the command includes the **/u** and **/rp** parameters to override the default and run the task with permission of the user's non-Administrator account on the remote computer.
```
schtasks /create /s SRV06 /tn "My App" /tr "c:\program files\corpapps\myapp.exe" /sc hourly /mo 3 /u reskits\admin01 /p R43253@4$ /ru SRV06\user03 /rp MyFav!!Pswd
```
In response, **schtasks** displays a success message indicating that the task is scheduled.

#### A user schedules a command on a remote computer (Case 2)

The following command schedules the MyApp program to run on the SRV02 remote computer on the last day of every month. Because the local current user (user03) is not an Administrator of the remote computer, the command uses the **/u** parameter to provide the credentials of the user's Administrator account (Admin01 in the Reskits domain). The Administrator account permissions will be used to schedule the task and to run the task.
```
schtasks /create /s SRV02 /tn "My App" /tr "c:\program files\corpapps\myapp.exe" /sc monthly /mo LASTDAY /m * /u reskits\admin01
```
Because the command did not include the **/p** (password) parameter, **schtasks** prompts for the password. Then it displays a success message and, in this case, a warning.
```
Type the password for reskits\admin01:********

SUCCESS: The scheduled task "My App" has successfully been created.

WARNING: The Scheduled task "My App" has been created, but may not run because
the account information could not be set.
```
This warning indicates that the remote domain could not authenticate the account specified by the **/u** parameter. In this case, the remote domain could not authenticate the user account because the local computer is not a member of a domain that the remote computer domain trusts. When this occurs, the task job appears in the list of scheduled tasks, but the task is actually empty and it will not run.

The following display from a verbose query exposes the problem with the task. In the display, note that the value of **Next Run Time** is **Never** and that the value of **Run As User** is **Could not be retrieved from the task scheduler database**.

Had this computer been a member of the same domain or a trusted domain, the task would have been successfully scheduled and would have run as specified.
```
HostName: SRV44
TaskName: My App
Next Run Time: Never
Status:
Logon mode: Interactive/Background
Last Run Time: Never
Last Result: 0
Creator: user03
Schedule: At 3:52 PM on day 31 of every month, start
 starting 12/14/2001
Task To Run: c:\program files\corpapps\myapp.exe
Start In: myapp.exe
Comment: N/A
Scheduled Task State: Disabled
Scheduled Type: Monthly
Start Time: 3:52:00 PM
Start Date: 12/14/2001
End Date: N/A
Days: 31
Months: JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NO
V,DEC
Run As User: Could not be retrieved from the task sched
uler database
Delete Task If Not Rescheduled: Enabled
Stop Task If Runs X Hours and X Mins: 72:0
Repeat: Every: Disabled
Repeat: Until: Time: Disabled
Repeat: Until: Duration: Disabled
Repeat: Stop If Still Running: Disabled
Idle Time: Disabled
Power Management: Disabled
```

#### Remarks

-   To run a **/create** command with the permissions of a different user, use the **/u** parameter. The **/u** parameter is valid only for scheduling tasks on remote computers.
-   To view more **schtasks /create** examples, type **schtasks /create /?** at a command prompt.
-   To schedule a task that runs with permissions of a different user, use the **/ru** parameter. The **/ru** parameter is valid for tasks on local and remote computers.
-   To use the **/u** parameter, the local computer must be in the same domain as the remote computer or must be in a domain that the remote computer domain trusts. Otherwise, either the task is not created, or the task job is empty and the task does not run.
-   **Schtasks** always prompts for a password unless you provide one, even when you schedule a task on the local computer using the current user account. This is normal behavior for **schtasks**.
-   **Schtasks** does not verify program file locations or user account passwords. If you do not enter the correct file location or the correct password for the user account, the task is created, but it does not run. Also, if the password for an account changes or expires, and you do not change the password saved in the task, then the task does not run.
-   The System account does not have interactive logon rights. Users do not see and cannot interact with programs run with system permissions.
-   Each task runs only one program. However, you can create a batch file that starts multiple tasks, and then schedule a task that runs the batch file.
-   You can test a task as soon as you create it. Use the **run** operation to test the task and then check the SchedLgU.txt file (*SystemRoot*\SchedLgU.txt) for errors.

## <a name="BKMK_change"></a>schtasks change

Changes one or more of the following properties of a task.
-   The program that the task runs (**/tr**).
-   The user account under which the task runs (**/ru**).
-   The password for the user account (**/rp**).
-   Adds the interactive-only property to the task (**/it**).

### Syntax

```
schtasks /change /tn <TaskName> [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]] [/ru {[<Domain>\]<User> | System}] [/rp <Password>] [/tr <TaskRun>] [/st <StartTime>] [/ri <Interval>] [{/et <EndTime> | /du <Duration>} [/k]] [/sd <StartDate>] [/ed <EndDate>] [/{ENABLE | DISABLE}] [/it] [/z]
```

### Parameters

|          Term           |                                                                                                                                                                                                                                                                                                                                     Definition                                                                                                                                                                                                                                                                                                                                      |
|-------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     /tn \<TaskName>     |                                                                                                                                                                                                                                                                                                               Identifies the task to be changed. Enter the task name.                                                                                                                                                                                                                                                                                                               |
|     /s \<Computer>      |                                                                                                                                                                                                                                                                               Specifies the name or IP address of a remote computer (with or without backslashes). The default is the local computer.                                                                                                                                                                                                                                                                               |
|  /u [\<Domain>\]<User>  |                                                                                                                                                                 Runs this command with the permissions of the specified user account. The default is the permissions of the current user of the local computer. The specified user account must be a member of the Administrators group on the remote computer. The **/u** and **/p** parameters are valid only for changing a task on a remote computer (**/s**).                                                                                                                                                                  |
|     /p \<Password>      |                                                                                                                                                                                              Specifies the password of the user account specified in the **/u** parameter. If you use the **/u** parameter, but omit the **/p** parameter or the password argument, **schtasks** prompts you for a password.</br>The **/u** and **/p** parameters are valid only when you use **/s**.                                                                                                                                                                                               |
| /ru {[\<Domain>\]<User> |                                                                                                                                                                                                                                                                                                                                       System}                                                                                                                                                                                                                                                                                                                                       |
|     /rp \<Password>     |                                                                                                                                                                                                                                                 Specifies a new password for the existing user account, or the user account specified by the **/ru** parameter. This parameter is ignored with used with the local System account.                                                                                                                                                                                                                                                  |
|     /tr \<TaskRun>      |                                                                                                                                                                                  Changes the program that the task runs. Enter the fully qualified path and file name of an executable file, script file, or batch file. If you omit the path, **schtasks** assumes that the file is in the \<systemroot>\System32 directory. The specified program replaces the original program run by the task.                                                                                                                                                                                  |
|    /st \<Starttime>     |                                                                                                                                                                                                                                                              Specifies the start time for the task, using the 24-hour time format, HH:mm. For example, a value of 14:30 is equivalent to the 12-hour time of 2:30 PM.                                                                                                                                                                                                                                                               |
|     /ri \<Interval>     |                                                                                                                                                                                                                                                                           Specifies the repetition interval for the scheduled task, in minutes. Valid range is 1 - 599940 (599940 minutes = 9999 hours).                                                                                                                                                                                                                                                                            |
|     /et \<EndTime>      |                                                                                                                                                                                                                                                               Specifies the end time for the task, using the 24-hour time format, HH:mm. For example, a value of 14:30 is equivalent to the 12-hour time of 2:30 PM.                                                                                                                                                                                                                                                                |
|     /du \<Duration>     |                                                                                                                                                                                                                                                                                                     Specifies to close the task at the \<EndTime> or <Duration>, if specified.                                                                                                                                                                                                                                                                                                      |
|           /k            |                                                                                                                                                                   Stops the program that the task runs at the time specified by **/et** or **/du**. Without **/k**, **schtasks** does not start the program again after it reaches the time specified by **/et** or **/du**, but it does not stop the program if it is still running. This parameter is optional and valid only with a MINUTE or HOURLY schedule.                                                                                                                                                                   |
|    /sd \<StartDate>     |                                                                                                                                                                                                                                                                                              Specifies the first date on which the task should be run. The date format is MM/DD/YYYY.                                                                                                                                                                                                                                                                                               |
|     /ed \<EndDate>      |                                                                                                                                                                                                                                                                                                 Specifies the last date on which the task should be run. The format is MM/DD/YYYY.                                                                                                                                                                                                                                                                                                  |
|         /ENABLE         |                                                                                                                                                                                                                                                                                                                       Specifies to enable the scheduled task.                                                                                                                                                                                                                                                                                                                       |
|        /DISABLE         |                                                                                                                                                                                                                                                                                                                      Specifies to disable the scheduled task.                                                                                                                                                                                                                                                                                                                       |
|           /it           | Specifies to run the scheduled task only when the "run as" user (the user account under which the task runs) is logged on to the computer.</br>This parameter has no effect on tasks that run with system permissions or tasks that already have the interactive-only property set. You cannot use a change command to remove the interactive-only property from a task.</br>By default, the "run as" user is the current user of the local computer when the task is scheduled or the account specified by the **/u** parameter, if one is used. However, if the command includes the **/ru** parameter, then the "run as" user is the account specified by the **/ru** parameter. |
|           /z            |                                                                                                                                                                                                                                                                                                          Specifies to delete the task upon the completion of its schedule.                                                                                                                                                                                                                                                                                                          |
|           /?            |                                                                                                                                                                                                                                                                                                                        Displays help at the command prompt.                                                                                                                                                                                                                                                                                                                         |

### Remarks

-   The **/tn** and **/s** parameters identify the task. The **/tr**, **/ru**, and **/rp** parameters specify properties of the task that you can change.
-   The **/ru**, and **/rp** parameters specify the permissions under which the task runs. The **/u** and **/p** parameters specify the permissions used to change the task.
-   To change tasks on a remote computer, the user must be logged on to the local computer with an account that is a member of the Administrators group on the remote computer.
-   To run a **/change** command with the permissions of a different user (**/u**, **/p**), the local computer must be in the same domain as the remote computer or must be in a domain that the remote computer domain trusts.
-   The System account does not have interactive logon rights. Users do not see and cannot interact with programs run with system permissions.
-   To identify tasks with the **/it** property, use a verbose query (**/query /v**). In a verbose query display of a task with **/it**, the **Logon Mode** field has a value of **Interactive only**.

### Examples

### To change the program that a task runs

The following command changes the program that the Virus Check task runs from VirusCheck.exe to VirusCheck2.exe. This command uses the **/tn** parameter to identify the task and the **/tr** parameter to specify the new program for the task. (You cannot change the task name.)
```
schtasks /change /tn "Virus Check" /tr C:\VirusCheck2.exe
```
In response, **SchTasks.exe** displays the following success message:
```
SUCCESS: The parameters of the scheduled task "Virus Check" have been changed.
```
As a result of this command, the Virus Check task now runs VirusCheck2.exe.

### To change the password for a remote task

The following command changes the password of the user account for the RemindMe task on the remote computer, Svr01. The command uses the **/tn** parameter to identify the task and the **/s** parameter to specify the remote computer. It uses the **/rp** parameter to specify the new password, p@ssWord3.

This procedure is required whenever the password for a user account expires or changes. If the password saved in a task is no longer valid, then the task does not run.
```
schtasks /change /tn RemindMe /s Svr01 /rp p@ssWord3
```
In response, **SchTasks.exe** displays the following success message:
```
SUCCESS: The parameters of the scheduled task "RemindMe" have been changed.
```
As a result of this command, the RemindMe task now runs under its original user account, but with a new password.

### To change the program and user account for a task

The following command changes the program that a task runs and changes the user account under which the task runs. Essentially, it uses an old schedule for a new task. This command changes the ChkNews task, which starts Notepad.exe every morning at 9:00 A.M., to start Internet Explorer instead.

The command uses the **/tn** parameter to identify the task. It uses the **/tr** parameter to change the program that the task runs and the **/ru** parameter to change the user account under which the task runs.

The **/ru**, and **/rp** parameter, which provides the password for the user account, is omitted. You must provide a password for the account, but you can use the **/ru**, and **/rp** parameter and type the password in clear text, or wait for **SchTasks.exe** to prompt you for a password, and then enter the password in obscured text.
```
schtasks /change /tn ChkNews /tr "c:\program files\Internet Explorer\iexplore.exe" /ru DomainX\Admin01
```
In response, **SchTasks.exe** requests the password for the user account. It obscures the text you type, so the password is not visible.
```
Please enter the password for DomainX\Admin01: 
```
Note that the **/tn** parameter identifies the task and that the **/tr** and **/ru** parameters change the properties of the task. You cannot use another parameter to identify the task and you cannot change the task name.

In response, **SchTasks.exe** displays the following success message:
```
SUCCESS: The parameters of the scheduled task "ChkNews" have been changed.
```
As a result of this command, the ChkNews task now runs Internet Explorer with the permissions of an Administrator account.

### To change a program to the System account

The following command changes the SecurityScript task so that it runs with permissions of the System account. It uses the **/ru ""** parameter to indicate the System account.
```
schtasks /change /tn SecurityScript /ru ""
```
In response, **SchTasks.exe** displays the following success message:
```
INFO: The run as user name for the scheduled task "SecurityScript" will be changed to "NT AUTHORITY\SYSTEM".
SUCCESS: The parameters of the scheduled task "SecurityScript" have been changed.
```
Because tasks run with System account permissions do not require a password, **SchTasks.exe** does not prompt for one.

### To run a program only when I am logged on

The following command adds the interactive-only property to MyApp, an existing task. This property assures that the task runs only when the "run as" user, that is, the user account under which the task runs, is logged on to the computer.

The command uses the **/tn** parameter to identify the task and the **/it** parameter to add the interactive-only property to the task. Because the task already runs with the permissions of my user account, I do not need to change the **/ru** parameter for the task.
```
schtasks /change /tn MyApp /it
```
In response, **SchTasks.exe** displays the following success message.
```
SUCCESS: The parameters of the scheduled task "MyApp" have been changed.
```

## <a name="BKMK_run"></a>schtasks run

Starts a scheduled task immediately. The **run** operation ignores the schedule, but uses the program file location, user account, and password saved in the task to run the task immediately.

### Syntax

```
schtasks /run /tn <TaskName> [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

### Parameters

|         Term          |                                                                                                                                                                 Definition                                                                                                                                                                  |
|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    /tn \<TaskName>    |                                                                                                                                                       Required. Identifies the task.                                                                                                                                                        |
|    /s \<Computer>     |                                                                                                           Specifies the name or IP address of a remote computer (with or without backslashes). The default is the local computer.                                                                                                           |
| /u [\<Domain>\]<User> | Runs this command with the permissions of the specified user account. By default, the command runs with the permissions of the current user of the local computer.</br>The specified user account must be a member of the Administrators group on the remote computer. The **/u** and **/p** parameters are valid only when you use **/s**. |
|    /p \<Password>     |                          Specifies the password of the user account specified in the **/u** parameter. If you use the **/u** parameter, but omit the **/p** parameter or the password argument, **schtasks** prompts you for a password.</br>The **/u** and **/p** parameters are valid only when you use **/s**.                           |
|          /?           |                                                                                                                                                    Displays help at the command prompt.                                                                                                                                                     |

### Remarks

-   Use this operation to test your tasks. If a task does not run, check the Task Scheduler Service transaction log, \<Systemroot>\SchedLgU.txt, for errors.
-   Running a task does not affect the task schedule and does not change the next run time scheduled for the task.
-   To run a task remotely, the task must be scheduled on the remote computer. When you run it, the task runs only on the remote computer. To verify that a task is running on a remote computer, use Task Manager or the Task Scheduler transaction log, \<Systemroot>\SchedLgU.txt.

### Examples

### To run a task on the local computer

The following command starts the "Security Script" task.
```
schtasks /run /tn "Security Script"
```
In response, **SchTasks.exe** starts the script associated with the task and displays the following message:
```
SUCCESS: Attempted to run the scheduled task "Security Script".
```
As the message implies, **schtasks** tries to start the program, but it cannot very that the program actually started.

### To run a task on a remote computer

The following command starts the Update task on a remote computer, Svr01:
```
schtasks /run /tn Update /s Svr01
```
In this case, **SchTasks.exe** displays the following error message:
```
ERROR: Unable to run the scheduled task "Update".
```
To find the cause of the error, look in the Scheduled Tasks transaction log, C:\Windows\SchedLgU.txt on Svr01. In this case, the following entry appears in the log:
```
"Update.job" (update.exe) 3/26/2001 1:15:46 PM ** ERROR **
The attempt to log on to the account associated with the task failed, therefore, the task did not run.
The specific error is:
0x8007052e: Logon failure: unknown user name or bad password.
Verify that the task's Run-as name and password are valid and try again.
```
Apparently, the user name or password in the task is not valid on the system. The following **schtasks /change** command updates the user name and password for the Update task on Svr01:
```
schtasks /change /tn Update /s Svr01 /ru Administrator /rp PassW@rd3
```
After the **change** command completes, the **run** command is repeated. This time, the Update.exe program starts and **SchTasks.exe** displays the following message:
```
SUCCESS: Attempted to run the scheduled task "Update".
```
As the message implies, **schtasks** tries to start the program, but it cannot very that the program actually started.

## <a name="BKMK_end"></a>schtasks end

Stops a program started by a task.

### Syntax

```
schtasks /end /tn <TaskName> [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

### Parameters

|         Term          |                                                                                                                                                               Definition                                                                                                                                                                |
|-----------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    /tn \<TaskName>    |                                                                                                                                         Required. Identifies the task that started the program.                                                                                                                                         |
|    /s \<Computer>     |                                                                                                                        Specifies the name or IP address of a remote computer. The default is the local computer.                                                                                                                        |
| /u [\<Domain>\]<User> | Runs this command with the permissions of the specified user account. By default, the command runs with the permissions of the current user of the local computer. The specified user account must be a member of the Administrators group on the remote computer. The **/u** and **/p** parameters are valid only when you use **/s**. |
|    /p \<Password>     |                        Specifies the password of the user account specified in the **/u** parameter. If you use the **/u** parameter, but omit the **/p** parameter or the password argument, **schtasks** prompts you for a password.</br>The **/u** and **/p** parameters are valid only when you use **/s**.                         |
|          /?           |                                                                                                                                                             Displays help.                                                                                                                                                              |

### Remarks

**SchTasks.exe** ends only the instances of a program started by a scheduled task. To stop other processes, use TaskKill. For more information, see [Taskkill](taskkill.md).

### Examples

### To end a task on a local computer

The following command stops the instance of Notepad.exe that was started by the My Notepad task:
```
schtasks /end /tn "My Notepad"
```
In response, **SchTasks.exe** stops the instance of Notepad.exe that the task started, and it displays the following success message:
```
SUCCESS: The scheduled task "My Notepad" has been terminated successfully.
```

### To end a task on a remote computer

The following command stops the instance of Internet Explorer that was started by the InternetOn task on the remote computer, Svr01:
```
schtasks /end /tn InternetOn /s Svr01
```
In response, **SchTasks.exe** stops the instance of Internet Explorer that the task started, and it displays the following success message:
```
SUCCESS: The scheduled task "InternetOn" has been terminated successfully.
```

## <a name="BKMK_delete"></a>schtasks delete

Deletes a scheduled task.

### Syntax

```
schtasks /delete /tn {<TaskName> | *} [/f] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

### Parameters

|         Term          |                                                                                                                                                                 Definition                                                                                                                                                                  |
|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|   /tn {\<TaskName>    |                                                                                                                                                                     \*}                                                                                                                                                                     |
|          /f           |                                                                                                                                  Suppresses the confirmation message. The task is deleted without warning.                                                                                                                                  |
|    /s \<Computer>     |                                                                                                           Specifies the name or IP address of a remote computer (with or without backslashes). The default is the local computer.                                                                                                           |
| /u [\<Domain>\]<User> | Runs this command with the permissions of the specified user account. By default, the command runs with the permissions of the current user of the local computer.</br>The specified user account must be a member of the Administrators group on the remote computer. The **/u** and **/p** parameters are valid only when you use **/s**. |
|    /p \<Password>     |                          Specifies the password of the user account specified in the **/u** parameter. If you use the **/u** parameter, but omit the **/p** parameter or the password argument, **schtasks** prompts you for a password.</br>The **/u** and **/p** parameters are valid only when you use **/s**.                           |
|          /?           |                                                                                                                                                    Displays help at the command prompt.                                                                                                                                                     |

### Remarks

- The **delete** operation deletes the task from the schedule. It does not delete the program that the task runs or interrupt a running program.
- The **delete \\*** command deletes all tasks scheduled for the computer, not just the tasks scheduled by the current user.

### Examples

### To delete a task from the schedule of a remote computer

The following command deletes the "Start Mail" task from the schedule of a remote computer. It uses the **/s** parameter to identify the remote computer.
```
schtasks /delete /tn "Start Mail" /s Svr16
```
In response, **SchTasks.exe** displays the following confirmation message. To delete the task, press Y<strong>.</strong> To cancel the command, type **n**:
```
WARNING: Are you sure you want to remove the task "Start Mail" (Y/N )? 
SUCCESS: The scheduled task "Start Mail" was successfully deleted.
```

### To delete all tasks scheduled for the local computer

The following command deletes all tasks from the schedule of the local computer, including tasks scheduled by other users. It uses the **/tn \\*** parameter to represent all tasks on the computer and the **/f** parameter to suppress the confirmation message.
```
schtasks /delete /tn * /f
```
In response, **SchTasks.exe** displays the following success messages indicating that the only task scheduled, SecureScript, is deleted.

`SUCCESS: The scheduled task "SecureScript" was successfully deleted.`

## <a name="BKMK_query"></a>schtasks query

Displays tasks scheduled to run on the computer.

### Syntax

```
schtasks [/query] [/fo {TABLE | LIST | CSV}] [/nh] [/v] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
```

### Parameters

|         Term          |                                                                                                                                                                 Definition                                                                                                                                                                  |
|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|       [/query]        |                                                                                                                        The operation name is optional. Typing **schtasks** without any parameters performs a query.                                                                                                                         |
|      /fo {TABLE       |                                                                                                                                                                    LIST                                                                                                                                                                     |
|          /nh          |                                                                                                            Omits column headings from the table display. This parameter is valid with the **TABLE** and **CSV** output formats.                                                                                                             |
|          /v           |                                                                                                         Adds advanced properties of the tasks to the display.</br>Queries using **/v** should be formatted as **LIST** or **CSV**.                                                                                                          |
|    /s \<Computer>     |                                                                                                           Specifies the name or IP address of a remote computer (with or without backslashes). The default is the local computer.                                                                                                           |
| /u [\<Domain>\]<User> | Runs this command with the permissions of the specified user account. By default, the command runs with the permissions of the current user of the local computer.</br>The specified user account must be a member of the Administrators group on the remote computer. The **/u** and **/p** parameters are valid only when you use **/s**. |
|    /p \<Password>     |                                        Specifies the password of the user account specified in the **/u** parameter. If you use **/u**, but omit **/p** or the password argument, **schtasks** prompts you for a password.</br>The **/u** and **/p** parameters are valid only when you use **/s**.                                         |
|          /?           |                                                                                                                                                    Displays help at the command prompt.                                                                                                                                                     |

### Remarks

**SchTasks.exe** ends only the instances of a program started by a scheduled task. To stop other processes, use TaskKill. For more information, see [Taskkill](taskkill.md).

### Examples

### To display the scheduled tasks on the local computer

The following commands display all tasks scheduled for the local computer. These commands produce the same result and can be used interchangeably.
```
schtasks
schtasks /query
```
In response, **SchTasks.exe** displays the tasks in the default, simple table format, as shown in the following table:
```
TaskName Next Run Time Status
========================= ======================== ==============
Microsoft Outlook At logon time
SecureScript 14:42:00 PM , 2/4/2001
```

### To display advanced properties of scheduled tasks

The following command requests a detailed display of the tasks on the local computer. It uses the **/v** parameter to request a detailed (verbose) display and the **/fo LIST** parameter to format the display as a list for easy reading. You can use this command to verify that a task you created has the intended recurrence pattern.

**schtasks /query /fo LIST /v**

In response, **SchTasks.exe** displays a detailed property list for all tasks. The following display shows the task list for a task scheduled to run at 4:00 A.M. on the last Friday of every month:
```
HostName: RESKIT01
TaskName: SecureScript
Next Run Time: 4:00:00 AM , 3/30/2001
Status: Not yet run
Logon mode: Interactive/Background
Last Run Time: Never
Last Result: 0
Creator: user01
Schedule: At 4:00 AM on the last Fri of every month, starting 3/24/2001
Task To Run: C:\WINDOWS\system32\notepad.exe
Start In: notepad.exe
Comment: N/A
Scheduled Task State: Enabled
Scheduled Type: Monthly
Modifier: Last FRIDAY
Start Time: 4:00:00 AM
Start Date: 3/24/2001
End Date: N/A
Days: FRIDAY
Months: JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC
Run As User: RESKIT\user01
Delete Task If Not Rescheduled: Enabled
Stop Task If Runs X Hours and X Mins: 72:0
Repeat: Until Time: Disabled
Repeat: Duration: Disabled
Repeat: Stop If Still Running: Disabled
Idle: Start Time(For IDLE Scheduled Type): Disabled
Idle: Only Start If Idle for X Minutes: Disabled
Idle: If Not Idle Retry For X Minutes: Disabled
Idle: Stop Task If Idle State End: Disabled
Power Mgmt: No Start On Batteries: Disabled
Power Mgmt: Stop On Battery Mode: Disabled
```

### To log tasks scheduled for a remote computer

The following command requests a list of tasks scheduled for a remote computer, and adds the tasks to a comma-separated log file on the local computer. You can use this command format to collect and track tasks that are scheduled for multiple computers.

The command uses the **/s** parameter to identify the remote computer, Reskit16, the **/fo** parameter to specify the format and the **/nh** parameter to suppress the column headings. The **>>** append symbol redirects the output to the task log, p0102.csv, on the local computer, Svr01. Because the command runs on the remote computer, the local computer path must be fully qualified.
```
schtasks /query /s Reskit16 /fo csv /nh >> \\svr01\data\tasklogs\p0102.csv
```
In response, **SchTasks.exe** adds the tasks scheduled for the Reskit16 computer to the p0102.csv file on the local computer, Svr01.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
