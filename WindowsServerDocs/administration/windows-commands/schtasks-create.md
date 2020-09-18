---
title: schtasks create
description: Reference article for the schtasks create command, which
ms.topic: reference
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 09/16/2020
---

# schtasks create

Schedules a task.

## Syntax

```
schtasks /create /sc <scheduletype> /tn <taskname> /tr <taskrun> [/s <computer> [/u [<domain>\]<user> [/p <password>]]] [/ru {[<domain>\]<user> | system}] [/rp <password>] [/mo <modifier>] [/d <day>[,<day>...] | *] [/m <month>[,<month>...]] [/i <idletime>] [/st <starttime>] [/ri <interval>] [{/et <endtime> | /du <duration>} [/k]] [/sd <startdate>] [/ed <enddate>] [/it] [/z] [/f]
```

### Parameters

| Parameter | Description |
|--|--|
| /sc `<scheduletype>` | Specifies the schedule type. The valid values include:<ul><li>**MINUTE** - Specifies the number of minutes before the task should run.</li><li>**HOURLY** - Specifies the number of hours before the task should run.</li><li>**DAILY** - Specifies the number of days before the task should run.</li><li>**WEEKLY** Specifies the number of weeks before the task should run.</li><li>**MONTHLY** - Specifies the number of months before the task should run.</li><li>**ONCE** - Specifies that that task runs once at a specified date and time.</li><li>**ONSTART** - Specifies that the task runs every time the system starts. You can specify a start date, or run the task the next time the system starts.</li><li>**ONLOGON** - Specifies that the task runs whenever a user (any user) logs on. You can specify a date, or run the task the next time the user logs on.</li><li>**ONIDLE** - Specifies that the task runs whenever the system is idle for a specified period of time. You can specify a date, or run the task the next time the system is idle.</li></ul> |
| /tn `<taskname>` | Specifies a name for the task. Each task on the system must have a unique name and must conform to the rules for file names, not exceeding 238 characters. Use quotation marks to enclose names that include spaces. |
| /tr `<Taskrun>` | Specifies the program or command that the task runs. Type the fully qualified path and file name of an executable file, script file, or batch file. The path name must not exceed 262 characters. If you don't add the path, **schtasks** assumes that the file is in the `<systemroot>\System32` directory. |
| /s `<computer>` | Specifies the name or IP address of a remote computer (with or without backslashes). The default is the local computer. |
| /u `[<domain>]` | Runs this command with the permissions of the specified user account. The default is the permissions of the current user of the local computer. The **/u** and **/p** parameters are valid only when you use **/s**. The permissions of the specified account are used to schedule the task and to run the task. To run the task with the permissions of a different user, use the **/ru** parameter. The user account must be a member of the Administrators group on the remote computer. Also, the local computer must be in the same domain as the remote computer, or must be in a domain that is trusted by the remote computer domain. |
| /p `<password>` | Specifies the password of the user account specified in the **/u** parameter. If you use the **/u** parameter without the **/p** parameter or the password argument, schtasks will prompt you for a password. The **/u** and **/p** parameters are valid only when you use **/s**. |
| /ru `{[<domain>\]<user> | system}` | Runs the task with permissions of the specified user account. By default, the task runs with the permissions of the current user of the local computer, or with the permission of the user specified by the **/u** parameter, if one is included. The **/ru** parameter is valid when scheduling tasks on local or remote computers. The valid options include:<ul><li>**Domain** - Specifies an alternate user account.</li><li>**System** - Specifies the local System account, a highly privileged account used by the operating system and system services.</li></ul> |
| /rp `<password>` | Specifies a the password for the existing user account, or the user account specified by the **/ru** parameter. If you don't use this parameter when specifying a user account, SchTasks.exe will prompt you for the password next time you sign in. Don't use the **/rp** parameter for tasks that run with System account credentials (**/ru System**). The System account doesn't have a password and SchTasks.exe doesn't prompt for one. |
| /mo `<modifiers>` | Specifies how often the task runs within its schedule type. The valid options include:<ul><li>**MINUTE** - Specifies that the task runs every <n> minutes. You can use any value between 1 - 1439 minutes. By default, this is 1 minute.</li><li>**HOURLY** - Specifies that the task runs every <n> hours. You can use any value between 1 - 23 hours. By default, this is 1 hour.</li><li>**DAILY** - Specifies that the task runs every <n> days. You can use any value between 1 - 365 days. By default, this is 1 day.</li><li>**WEEKLY** - Specifies that the task runs every <n> weeks. You can use any value between 1 - 52 weeks. By default, this is 1 week.</li><li>***MONTHLY** - Specifies that the task runs every <n> months. You can use any of the following values:<ul><li>A number between 1 - 12 months</li><li>**LASTDAY** - To run the task on the last day of the month</li><li>**FIRST, SECOND, THIRD, or FOURTH along with the /d <day> parameter** - Specifies the particular week and day to run the task. For example, on the third Wednesday of the month.</li></ul></li><li>**ONCE** - Specifies that the task runs once.</li><li>**ONSTART** - Specifies that the task runs at startup.</li><li>**ONLOGON** - Specifies that the task runs when the user specified by the **/u** parameter logs on.</li><li>**ONIDLE** - Specifies that the task runs after the system is idle for the number of minutes specified by the **/i** parameter</li></ul> |











| /st `<Starttime>` | Specifies the start time for the task, using the 24-hour time format, HH:mm. For example, a value of 14:30 is equivalent to the 12-hour time of 2:30 PM. |
| /ri `<interval>` | Specifies the repetition interval for the scheduled task, in minutes. Valid range is 1 - 599940 (599940 minutes = 9999 hours). If either the **/et** or **/du** parameters are specified, the default is **10 minutes**. |
| /et `<Endtime>` | Specifies the end time for the task, using the 24-hour time format, HH:mm. For example, a value of 14:30 is equivalent to the 12-hour time of 2:30 PM. |
| /du `<duration>` | A value that specifies the duration to run the task. The time format is HH:mm (24-hour time). For example, a value of 14:30 is equivalent to the 12-hour time of 2:30 PM. |
| /k | Stops the program that the task runs at the time specified by **/et** or **/du**. Without **/k**, schtasks does not start the program again after it reaches the time specified by **/et** or **/du**, but it does not stop the program if it's still running. This parameter is optional and valid only with a MINUTE or HOURLY schedule. |
| /sd `<Startdate>` | Specifies the first date on which the task should be run. The date format is MM/DD/YYYY. |
| /ed `<Enddate>` | Specifies the last date on which the task should be run. The format is MM/DD/YYYY. |
| /ENABLE | Specifies to enable the scheduled task. |
| /DISABLE | Specifies to disable the scheduled task. |
| /it | Specifies to run the scheduled task only when the run as user (the user account under which the task runs) is logged on to the computer.|This parameter has no effect on tasks that run with system permissions or tasks that already have the interactive-only property set. You can't use a change command to remove the interactive-only property from a task. By default, run as user is the current user of the local computer when the task is scheduled or the account specified by the **/u** parameter, if one is used. However, if the command includes the **/ru** parameter, then the run as user is the account specified by the **/ru** parameter. |
| /z | Specifies to delete the task upon the completion of its schedule. |
| /? | Displays help at the command prompt. |

https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/schtasks#schtasks-create















/mo <Modifier>
Specifies how often the task runs within its schedule type. This parameter is valid, but optional, for a MINUTE, HOURLY, DAILY, WEEKLY, and MONTHLY schedule. The default value is 1.

/MO <MODIFIER>
Schedule type	Modifier values	Description
/D DAY[,DAY...] | *
Schedule type	Modifier	Day values (/d)	Description
WEEKLY	1 - 52	MON - SUN[,MON - SUN...]	*
MONTHLY	FIRST, SECOND, THIRD, FOURTH, LAST	MON - SUN	Required for a specific week schedule.
MONTHLY	None or {1 - 12}	1 - 31	Optional and valid only with no modifier (/mo) parameter (a specific date schedule) or when the /mo is 1 - 12 (an every <N> months schedule). The default is day 1 (the first day of the month).
/m Month[,Month...]
Specifies a month or months of the year during which the scheduled task should run. Valid values are JAN - DEC and * (every month). The /m parameter is valid only with a MONTHLY schedule. It is required when the LASTDAY modifier is used. Otherwise, it is optional and the default value is * (every month).

/i <IdleTime>
Specifies how many minutes the computer is idle before the task starts. A valid value is a whole number from 1 to 999. This parameter is valid only with an ONIDLE schedule, and then it is required.

/st <StartTime>
Specifies the time of day that the task starts (each time it starts) in <HH:MM> 24-hour format. The default value is the current time on the local computer. The /st parameter is valid with MINUTE, HOURLY, DAILY, WEEKLY, MONTHLY, and ONCE schedules. It is required for a ONCE schedule.

/ri <Interval>
Specifies the repetition interval in minutes. This is not applicable for schedule types: MINUTE, HOURLY, ONSTART, ONLOGON, and ONIDLE. Valid range is 1 to 599940 minutes (599940 minutes = 9999 hours). If either /ET or /DU is specified, then the repetition interval defaults to 10 minutes.

/et <EndTime>
Specifies the time of day that a minute or hourly task schedule ends in <HH:MM> 24-hour format. After the specified end time, schtasks does not start the task again until the start time recurs. By default, task schedules have no end time. This parameter is optional and valid only with a MINUTE or HOURLY schedule.

For an example, see:

To schedule a task that runs every 100 minutes during non-business hours in the To schedule a task that runs every <N> minutes section.
/du <Duration>
Specifies a maximum length of time for a minute or hourly schedule in <HHHH:MM> 24-hour format. After the specified time elapses, schtasks does not start the task again until the start time recurs. By default, task schedules have no maximum duration. This parameter is optional and valid only with a MINUTE or HOURLY schedule.

For an example, see:

To schedule a task that runs every 3 hours for 10 hours in the To schedule a task that runs every <N> hours section.
/k
Stops the program that the task runs at the time specified by /et or /du. Without /k, schtasks does not start the program again after it reaches the time specified by /et or /du, but it does not stop the program if it is still running. This parameter is optional and valid only with a MINUTE or HOURLY schedule.

For an example, see:

To schedule a task that runs every 100 minutes during non-business hours in the To schedule a task that runs every <N> minutes section.
/sd <StartDate>
Specifies the date on which the task schedule starts. The default value is the current date on the local computer. The /sd parameter is valid and optional for all schedule types.

The format for StartDate varies with the locale selected for the local computer in Regional and Language Options in Control Panel. Only one format is valid for each locale.

The valid date formats are listed in the following table. Use the format most similar to the format selected for Short date in Regional and Language Options in Control Panel on the local computer.

/SD <STARTDATE>
Value	Description
<MM>/
/
Use for month-first formats, such as English (United States) and Spanish (Panama).
<DD>//	Use for day-first formats, such as Bulgarian and Dutch (Netherlands).
<YYYY>//
Use for year-first formats, such as Swedish and French (Canada).
/ed <EndDate>

Specifies the date on which the schedule ends. This parameter is optional. It is not valid in a ONCE, ONSTART, ONLOGON, or ONIDLE schedule. By default, schedules have no ending date.

The format for EndDate varies with the locale selected for the local computer in Regional and Language Options in Control Panel. Only one format is valid for each locale.

The valid date formats are listed in the following table. Use the format most similar to the format selected for Short date in Regional and Language Options in Control Panel on the local computer.

TABLE 6
Value	Description
<MM>/
/
Use for month-first formats, such as English (United States) and Spanish (Panama).
<DD>//	Use for day-first formats, such as Bulgarian and Dutch (Netherlands).
<YYYY>//
Use for year-first formats, such as Swedish and French (Canada).
/it
Specifies to run the task only when the run as user (the user account under which the task runs) is logged on to the computer. This parameter has no effect on tasks that run with system permissions.

By default, the run as user is the current user of the local computer when the task is scheduled or the account specified by the /u parameter, if one is used. However, if the command includes the /ru parameter, then the run as user is the account specified by the /ru parameter.

For examples, see:

To schedule a task that runs every 70 days if I am logged on in the To schedule a task that runs every N days section.
To run a task only when a particular user is logged on in the To schedule a task that runs with different permissions section.
/z
Specifies to delete the task upon completion of its schedule.

/f
Specifies to create the task and suppress warnings if the specified task already exists.

/?
Displays help at the command prompt.

## Examples

To schedule a task that runs every N minutes
Minute Schedule Syntax

Copy
schtasks /create /tn <TaskName> /tr <TaskRun> /sc minute [/mo {1 - 1439}] [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [{/et <HH:MM> | /du <HHHH:MM>} [/k]] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
Remarks
In a minute schedule, the /sc minute parameter is required. The /mo (modifier) parameter is optional and specifies the number of minutes between each run of the task. The default value for /mo is 1 (every minute). The /et (end time) and /du (duration) parameters are optional and can be used with or without the /k (end task) parameter.

Examples
To schedule a task that runs every 20 minutes
The following command schedules a security script, Sec.vbs, to run every 20 minutes. The command uses the /sc parameter to specify a minute schedule and the /mo parameter to specify an interval of 20 minutes.

Because the command does not include a starting date or time, the task starts 20 minutes after the command completes, and runs every 20 minutes thereafter whenever the system is running. Notice that the security script source file is located on a remote computer, but that the task is scheduled and executes on the local computer.


Copy
schtasks /create /sc minute /mo 20 /tn Security Script /tr \\central\data\scripts\sec.vbs
To schedule a task that runs every 100 minutes during non-business hours
The following command schedules a security script, Sec.vbs, to run on the local computer every 100 minutes between 5:00 P.M. and 7:59 A.M. each day. The command uses the /sc parameter to specify a minute schedule and the /mo parameter to specify an interval of 100 minutes. It uses the /st and /et parameters to specify the start time and end time of each day's schedule. It also uses the /k parameter to stop the script if it is still running at 7:59 A.M. Without /k, schtasks would not start the script after 7:59 A.M., but if the instance started at 6:20 A.M. was still running, it would not stop it.


Copy
schtasks /create /tn Security Script /tr sec.vbs /sc minute /mo 100 /st 17:00 /et 08:00 /k
To schedule a task that runs every N hours
Hourly Schedule Syntax

Copy
schtasks /create /tn <TaskName> /tr <TaskRun> /sc hourly [/mo {1 - 23}] [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [{/et <HH:MM> | /du <HHHH:MM>} [/k]] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
Remarks
In an hourly schedule, the /sc hourly parameter is required. The /mo (modifier) parameter is optional and specifies the number of hours between each run of the task. The default value for /mo is 1 (every hour). The /k (end task) parameter is optional and can be used with either /et (end at the specified time) or /du (end after the specified interval).

Examples
To schedule a task that runs every five hours
The following command schedules the MyApp program to run every five hours beginning on the first day of March 2002. It uses the /mo parameter to specify the interval and the /sd parameter to specify the start date. Because the command does not specify a start time, the current time is used as the start time.

Because the local computer is set to use the English (Zimbabwe) option in Regional and Language Options in Control Panel, the format for the start date is MM/DD/YYYY (03/01/2002).


Copy
schtasks /create /sc hourly /mo 5 /sd 03/01/2002 /tn My App /tr c:\apps\myapp.exe
To schedule a task that runs every hour at five minutes past the hour
The following command schedules the MyApp program to run hourly beginning at five minutes past midnight. Because the /mo parameter is omitted, the command uses the default value for the hourly schedule, which is every (1) hour. If this command runs after 12:05 A.M., the program does not run until the next day.


Copy
schtasks /create /sc hourly /st 00:05 /tn My App /tr c:\apps\myapp.exe
To schedule a task that runs every 3 hours for 10 hours
The following command schedules the MyApp program to run every 3 hours for 10 hours.

The command uses the /sc parameter to specify an hourly schedule and the /mo parameter to specify the interval of 3 hours. It uses the /st parameter to start the schedule at midnight and the /du parameter to end the recurrences after 10 hours. Because the program runs for just a few minutes, the /k parameter, which stops the program if it is still running when the duration expires, is not necessary.


Copy
schtasks /create /tn My App /tr myapp.exe /sc hourly /mo 3 /st 00:00 /du 0010:00
In this example, the task runs at 12:00 A.M., 3:00 A.M., 6:00 A.M., and 9:00 A.M. Because the duration is 10 hours, the task is not run again at 12:00 P.M. Instead, it starts again at 12:00 A.M. the next day.

To schedule a task that runs every N days
Daily Schedule Syntax

Copy
schtasks /create /tn <TaskName> /tr <TaskRun> /sc daily [/mo {1 - 365}] [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
Remarks
In a daily schedule, the /sc daily parameter is required. The /mo (modifier) parameter is optional and specifies the number of days between each run of the task. The default value for /mo is 1 (every day).

Examples
To schedule a task that runs every day
To schedules the MyApp program to run once a day, every day, at 8:00 A.M. until December 31, 2002. Because it omits the /mo parameter, the default interval of 1 is used to run the command every day.

In this example, because the local computer system is set to the English (United Kingdom) option in Regional and Language Options in Control Panel, the format for the end date is DD/MM/YYYY (31/12/2002)


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc daily /st 08:00 /ed 31/12/2002
To schedule a task that runs every 12 days
To schedules the MyApp program to run every twelve days at 1:00 P.M. (13:00) beginning on December 31, 2002. The command uses the /mo parameter to specify an interval of two (2) days and the /sd and /st parameters to specify the date and time.

In this example, because the system is set to the English (Zimbabwe) option in Regional and Language Options in Control Panel, the format for the end date is MM/DD/YYYY (12/31/2002)


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc daily /mo 12 /sd 12/31/2002 /st 13:00
To schedule a task that runs every 70 days if I am logged on
The following command schedules a security script, Sec.vbs, to run every 70 days. The command uses the /mo parameter to specify an interval of 70 days. It also uses the /it parameter to specify that the task runs only when the user under whose account the task runs is logged onto the computer. Because the task will run with the permissions of my user account, then the task will run only when I am logged on.


Copy
schtasks /create /tn Security Script /tr sec.vbs /sc daily /mo 70 /it
 Note

To identify tasks with the interactive-only (/it) property, use a verbose query (/query /v). In a verbose query display of a task with /it, the Logon Mode field has a value of Interactive only.

To schedule a task that runs every N weeks
Weekly Schedule Syntax

Copy
schtasks /create /tn <TaskName> /tr <TaskRun> /sc weekly [/mo {1 - 52}] [/d {<MON - SUN>[,MON - SUN...] | *}] [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
Remarks
In a weekly schedule, the /sc weekly parameter is required. The /mo (modifier) parameter is optional and specifies the number of weeks between each run of the task. The default value for /mo is 1 (every week).

Weekly schedules also have an optional /d parameter to schedule the task to run on specified days of the week, or on all days (). The default is MON (Monday). The every day () option is equivalent to scheduling a daily task.

Examples
To schedule a task that runs every six weeks
The following command schedules the MyApp program to run on a remote computer every six weeks. The command uses the /mo parameter to specify the interval. Because the command omits the /d parameter, the task runs on Mondays.

This command also uses the /s parameter to specify the remote computer and the /u parameter to run the command with the permissions of the user's Administrator account. Because the /p parameter is omitted, SchTasks.exe prompts the user for the Administrator account password.

Also, because the command is run remotely, all paths in the command, including the path to MyApp.exe, refer to paths on the remote computer.


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc weekly /mo 6 /s Server16 /u Admin01
To schedule a task that runs every other week on Friday
The following command schedules a task to run every other Friday. It uses the /mo parameter to specify the two-week interval and the /d parameter to specify the day of the week. To schedule a task that runs every Friday, omit the /mo parameter or set it to 1.


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc weekly /mo 2 /d FRI
To schedule a task that runs every N months
Syntax

Copy
schtasks /create /tn <TaskName> /tr <TaskRun> /sc monthly [/mo {1 - 12}] [/d {1 - 31}] [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
Remarks
In this schedule type, the /sc monthly parameter is required. The /mo (modifier) parameter, which specifies the number of months between each run of the task, is optional and the default is 1 (every month). This schedule type also has an optional /d parameter to schedule the task to run on a specified date of the month. The default is 1 (the first day of the month).

Examples
To schedule a task that runs on the first day of every month
The following command schedules the MyApp program to run on the first day of every month. Because a value of 1 is the default for both the /mo (modifier) parameter and the /d (day) parameter, these parameters are omitted from the command.


Copy
schtasks /create /tn My App /tr myapp.exe /sc monthly
To schedule a task that runs every three months
The following command schedules the MyApp program to run every three months. It uses the /mo parameter to specify the interval.


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc monthly /mo 3
To schedule a task that runs at midnight on the 21st day of every other month
The following command schedules the MyApp program to run every other month on the 21st day of the month at midnight. The command specifies that this task should run for one year, from July 2, 2002 to June 30, 2003.

The command uses the /mo parameter to specify the monthly interval (every two months), the /d parameter to specify the date, and the /st to specify the time. It also uses the /sd and /ed parameters to specify the start date and end date, respectively. Because the local computer is set to the English (South Africa) option in Regional and Language Options in Control Panel, the dates are specified in the local format, YYYY/MM/DD.


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc monthly /mo 2 /d 21 /st 00:00 /sd 2002/07/01 /ed 2003/06/30
To schedule a task that runs on a specific day of the week
Weekly Schedule Syntax

Copy
schtasks /create /tn <TaskName> /tr <TaskRun> /sc weekly [/d {<MON - SUN>[,MON - SUN...] | *}] [/mo {1 - 52}] [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
Remarks
The day of the week schedule is a variation of the weekly schedule. In a weekly schedule, the /sc weekly parameter is required. The /mo (modifier) parameter is optional and specifies the number of weeks between each run of the task. The default value for /mo is 1 (every week). The /d parameter, which is optional, schedules the task to run on specified days of the week, or on all days (*). The default is MON (Monday). The every day option (/d *) is equivalent to scheduling a daily task.

Examples
To schedule a task that runs every Wednesday
The following command schedules the MyApp program to run every week on Wednesday. The command uses the /d parameter to specify the day of the week. Because the command omits the /mo parameter, the task runs every week.


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc weekly /d WED
To schedule a task that runs every eight weeks on Monday and Friday
The following command schedules a task to run on Monday and Friday of every eighth week. It uses the /d parameter to specify the days and the /mo parameter to specify the eight-week interval.


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc weekly /mo 8 /d MON,FRI
To schedule a task that runs on a specific week of the month
Specific Week Syntax

Copy
schtasks /create /tn <TaskName> /tr <TaskRun> /sc monthly /mo {FIRST | SECOND | THIRD | FOURTH | LAST} /d MON - SUN [/m {JAN - DEC[,JAN - DEC...] | *}] [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
Remarks
In this schedule type, the /sc monthly parameter, the /mo (modifier) parameter, and the /d (day) parameter are required. The /mo (modifier) parameter specifies the week on which the task runs. The /d parameter specifies the day of the week. (You can specify only one day of the week for this schedule type.) This schedule also has an optional /m (month) parameter that lets you schedule the task for particular months or every month (*). The default for the /m parameter is every month (*).

Examples
To schedule a task for the second Sunday of every month
The following command schedules the MyApp program to run on the second Sunday of every month. It uses the /mo parameter to specify the second week of the month and the /d parameter to specify the day.


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc monthly /mo SECOND /d SUN
To schedule a task for the first Monday in March and September
The following command schedules the MyApp program to run on the first Monday in March and September. It uses the /mo parameter to specify the first week of the month and the /d parameter to specify the day. It uses /m parameter to specify the month, separating the month arguments with a comma.


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc monthly /mo FIRST /d MON /m MAR,SEP
To schedule a task that runs on a specific date each month
Specific date syntax

Copy
schtasks /create /tn <TaskName> /tr <TaskRun> /sc monthly /d {1 - 31} [/m {JAN - DEC[,JAN - DEC...] | *}] [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
Remarks
In the specific date schedule type, the /sc monthly parameter and the /d (day) parameter are required. The /d parameter specifies a date of the month (1 - 31), not a day of the week. You can specify only one day in the schedule. The /mo (modifier) parameter is not valid with this schedule type.

The /m (month) parameter is optional for this schedule type and the default is every month (). *Schtasks does not let you schedule a task for a date that does not occur in a month specified by the /m parameter. However, if omit the /m parameter, and schedule a task for a date that does not appear in every month, such as the 31st day, then the task does not run in the shorter months. To schedule a task for the last day of the month, use the last day schedule type.

Examples
To schedule a task for the first day of every month
The following command schedules the MyApp program to run on the first day of every month. Because the default modifier is none (no modifier), the default day is day 1, and the default month is every month, the command does not need any additional parameters.


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc monthly
To schedule a task for the 15th days of May and June
The following command schedules the MyApp program to run on May 15 and June 15 at 3:00 P.M. (15:00). It uses the /m parameter to specify the date and the /m parameter to specify the months. It also uses the /st parameter to specify the start time.


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc monthly /d 15 /m MAY,JUN /st 15:00
To schedule a task that runs on the last day of a month
Last day syntax

Copy
schtasks /create /tn <TaskName> /tr <TaskRun> /sc monthly /mo LASTDAY /m {JAN - DEC[,JAN - DEC...] | *} [/st <HH:MM>] [/sd <StartDate>] [/ed <EndDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
Remarks
In the last day schedule type, the /sc monthly parameter, the /mo LASTDAY (modifier) parameter, and the /m (month) parameter are required. The /d (day) parameter is not valid.

Examples
To schedule a task for the last day of every month
The following command schedules the MyApp program to run on the last day of every month. It uses the /mo parameter to specify the last day and the /m parameter with the wildcard character (*) to indicate that the program runs every month.


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc monthly /mo lastday /m *
To schedule a task at 6:00 P.M. on the last days of February and March
The following command schedules the MyApp program to run on the last day of February and the last day of March at 6:00 P.M. It uses the /mo parameter to specify the last day, the /m parameter to specify the months, and the /st parameter to specify the start time.


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc monthly /mo lastday /m FEB,MAR /st 18:00
To schedule a task that runs once
Syntax

Copy
schtasks /create /tn <TaskName> /tr <TaskRun> /sc once /st <HH:MM> [/sd <StartDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
Remarks
In the run-once schedule type, the /sc once parameter is required. The /st parameter, which specifies the time that the task runs, is required. The /sd parameter, which specifies the date that the task runs, is optional. The /mo (modifier) and /ed (end date) parameters are not valid for this schedule type.

Schtasks does not permit you to schedule a task to run once if the date and time specified are in the past, based on the time of the local computer. To schedule a task that runs once on a remote computer in a different time zone, you must schedule it before that date and time occurs on the local computer.

Examples
To schedule a task that runs one time
The following command schedules the MyApp program to run at midnight on January 1, 2003. It uses the /sc parameter to specify the schedule type and the /sd and st to specify the date and time.

Because the local computer uses the English (United States) option in Regional and Language Options in Control Panel, the format for the start date is MM/DD/YYYY.


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc once /sd 01/01/2003 /st 00:00
To schedule a task that runs every time the system starts
Syntax

Copy
schtasks /create /tn <TaskName> /tr <TaskRun> /sc onstart [/sd <StartDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
Remarks
In the on-start schedule type, the /sc onstart parameter is required. The /sd (start date) parameter is optional and the default is the current date.

Examples
To schedule a task that runs when the system starts
The following command schedules the MyApp program to run every time the system starts, beginning on March 15, 2001:

Because the local computer is uses the English (United States) option in Regional and Language Options in Control Panel, the format for the start date is MM/DD/YYYY.


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc onstart /sd 03/15/2001
To schedule a task that runs when a user logs on
Syntax

Copy
schtasks /create /tn <TaskName> /tr <TaskRun> /sc onlogon [/sd <StartDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
Remarks
The on logon schedule type schedules a task that runs whenever any user logs on to the computer. In the on logon schedule type, the /sc onlogon parameter is required. The /sd (start date) parameter is optional and the default is the current date.

Examples
To schedule a task that runs when a user logs on to a remote computer
The following command schedules a batch file to run every time a user (any user) logs on to the remote computer. It uses the /s parameter to specify the remote computer. Because the command is remote, all paths in the command, including the path to the batch file, refer to a path on the remote computer.


Copy
schtasks /create /tn Start Web Site /tr c:\myiis\webstart.bat /sc onlogon /s Server23
To schedule a task that runs when the system is idle
Syntax

Copy
schtasks /create /tn <TaskName> /tr <TaskRun> /sc onidle /i {1 - 999} [/sd <StartDate>] [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
Remarks
The on idle schedule type schedules a task that runs whenever there is no user activity during the time specified by the /i parameter. In the on idle schedule type, the /sc onidle parameter and the /i parameter are required. The /sd (start date) is optional and the default is the current date.

Examples
To schedule a task that runs whenever the computer is idle
The following command schedules the MyApp program to run whenever the computer is idle. It uses the required /i parameter to specify that the computer must remain idle for ten minutes before the task starts.


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc onidle /i 10
To schedule a task that runs now
Schtasks does not have a run now option, but you can simulate that option by creating a task that runs once and starts in a few minutes.

Syntax

Copy
schtasks /create /tn <TaskName> /tr <TaskRun> /sc once [/st <HH:MM>] /sd <MM/DD/YYYY> [/it] [/ru {[<Domain>\]<User> [/rp <Password>] | System}] [/s <Computer> [/u [<Domain>\]<User> [/p <Password>]]]
Examples
To schedule a task that runs a few minutes from now.
The following command schedules a task to run once, on November 13, 2002 at 2:18 P.M. local time.

Because the local computer is uses the English (United States) option in Regional and Language Options in Control Panel, the format for the start date is MM/DD/YYYY.


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc once /st 14:18 /sd 11/13/2002
To schedule a task that runs with different permissions
You can schedule tasks of all types to run with permissions of an alternate account on both the local and a remote computer. In addition to the parameters required for the particular schedule type, the /ru parameter is required and the /rp parameter is optional.

Examples
To run a task with Administrator permissions on the local computer
The following command schedules the MyApp program to run on the local computer. It uses the /ru to specify that the task should run with the permissions of the user's Administrator account (Admin06). In this example, the task is scheduled to run every Tuesday, but you can use any schedule type for a task run with alternate permissions.


Copy
schtasks /create /tn My App /tr myapp.exe /sc weekly /d TUE /ru Admin06
In response, SchTasks.exe prompts for the run as password for the Admin06 account and then displays a success message.


Copy
Please enter the run as password for Admin06: ********
SUCCESS: The scheduled task My App has successfully been created.
To run a task with alternate permissions on a remote computer
The following command schedules the MyApp program to run on the Marketing computer every four days.

The command uses the /sc parameter to specify a daily schedule and /mo parameter to specify an interval of four days.

The command uses the /s parameter to provide the name of the remote computer and the /u parameter to specify an account with permission to schedule a task on the remote computer (Admin01 on the Marketing computer). It also uses the /ru parameter to specify that the task should run with the permissions of the user's non-Administrator account (User01 in the Reskits domain). Without the /ru parameter, the task would run with the permissions of the account specified by /u.


Copy
schtasks /create /tn My App /tr myapp.exe /sc daily /mo 4 /s Marketing /u Marketing\Admin01 /ru Reskits\User01
Schtasks first requests the password of the user named by the /u parameter (to run the command) and then requests the password of the user named by the /ru parameter (to run the task). After authenticating the passwords, schtasks displays a message indicating that the task is scheduled.


Copy
Type the password for Marketing\Admin01:********

Please enter the run as password for Reskits\User01: ********

SUCCESS: The scheduled task My App has successfully been created.
To run a task only when a particular user is logged on
The following command schedules the AdminCheck.exe program to run on the Public computer every Friday at 4:00 A.M., but only if the administrator of the computer is logged on.

The command uses the /sc parameter to specify a weekly schedule, the /d parameter to specify the day, and the /st parameter to specify the start time.

The command uses the /s parameter to provide the name of the remote computer and the /u parameter to specify an account with permission to schedule a task on the remote computer. It also uses the /ru parameter to configure the task to run with the permissions of the administrator of the Public computer (Public\Admin01) and the /it parameter to indicate that the task runs only when the Public\Admin01 account is logged on.


Copy
schtasks /create /tn Check Admin /tr AdminCheck.exe /sc weekly /d FRI /st 04:00 /s Public /u Domain3\Admin06 /ru Public\Admin01 /it
Note

To identify tasks with the interactive-only (/it) property, use a verbose query (/query /v). In a verbose query display of a task with /it, the Logon Mode field has a value of Interactive only.
To schedule a task that runs with system permissions
Tasks of all types can run with permissions of the System account on both the local and a remote computer. In addition to the parameters required for the particular schedule type, the /ru system (or **/ru **) parameter is required and the /rp parameter is not valid.

Important

The System account does not have interactive logon rights. Users cannot see or interact with programs or tasks run with system permissions.
The /ru parameter determines the permissions under which the task runs, not the permissions used to schedule the task. Only Administrators can schedule tasks, regardless of the value of the /ru parameter.
Note

To identify tasks that run with system permissions, use a verbose query (/query /v). In a verbose query display of a system-run task, the Run As User field has a value of NT AUTHORITY\SYSTEM and the Logon Mode field has a value of Background only.

Examples
To run a task with system permissions
The following command schedules the MyApp program to run on the local computer with permissions of the System account. In this example, the task is scheduled to run on the fifteenth day of every month, but you can use any schedule type for a task run with system permissions.

The command uses the /ru System parameter to specify the system security context. Because system tasks do not use a password, the /rp parameter is omitted.


Copy
schtasks /create /tn My App /tr c:\apps\myapp.exe /sc monthly /d 15 /ru System
In response, SchTasks.exe displays an informational message and a success message. It does not prompt for a password.


Copy
INFO: The task will be created under user name (NT AUTHORITY\SYSTEM).
SUCCESS: The Scheduled task My App has successfully been created.
To run a task with system permissions on a remote computer
The following command schedules the MyApp program to run on the Finance01 computer every morning at 4:00 A.M. with system permissions.

The command uses the /tn parameter to name the task and the /tr parameter to specify the remote copy of the MyApp program. It uses the /sc parameter to specify a daily schedule, but omits the /mo parameter because 1 (every day) is the default. It uses the /st parameter to specify the start time, which is also the time the task will run each day.

The command uses the /s parameter to provide the name of the remote computer and the /u parameter to specify an account with permission to schedule a task on the remote computer. It also uses the /ru parameter to specify that the task should run under the System account. Without the /ru parameter, the task would run with the permissions of the account specified by /u.


Copy
schtasks /create /tn My App /tr myapp.exe /sc daily /st 04:00 /s Finance01 /u Admin01 /ru System
Schtasks requests the password of the user named by the /u parameter and, after authenticating the password, displays a message indicating that the task is created and that it will run with permissions of the System account.


Copy
Type the password for Admin01:**********

INFO: The Schedule Task My App will be created under user name (NT AUTHORITY\
SYSTEM).
SUCCESS: The scheduled task My App has successfully been created.
To schedule a task that runs more than one program
Each task runs only one program. However, you can create a batch file that runs multiple programs and then schedule a task to run the batch file. The following procedure demonstrates this method:

Create a batch file that starts the programs you want to run.

In this example, you create a batch file that starts Event Viewer (Eventvwr.exe) and System Monitor (Perfmon.exe).

Open a text editor, such as Notepad.
Type the name and fully qualified path to the executable file for each program. In this case, the file includes the following statements.

Copy
C:\Windows\System32\Eventvwr.exe
C:\Windows\System32\Perfmon.exe
Save the file as MyApps.bat.
Use Schtasks.exe to create a task that runs MyApps.bat.

The following command creates the Monitor task, which runs whenever anyone logs on. It uses the /tn parameter to name the task, and the /tr parameter to run MyApps.bat. It uses the /sc parameter to indicate the OnLogon schedule type and the /ru parameter to run the task with the permissions of the user's Administrator account.


Copy
schtasks /create /tn Monitor /tr C:\MyApps.bat /sc onlogon /ru Reskit\Administrator
As a result of this command, whenever a user logs on to the computer, the task starts both Event Viewer and System Monitor.

To schedule a task that runs on a remote computer
To schedule a task to run on a remote computer, you must add the task to the remote computer's schedule. Tasks of all types can be scheduled on a remote computer, but the following conditions must be met.

You must have permission to schedule the task. As such, you must be logged on to the local computer with an account that is a member of the Administrators group on the remote computer, or you must use the /u parameter to provide the credentials of an Administrator of the remote computer.
You can use the /u parameter only when the local and remote computers are in the same domain or the local computer is in a domain that the remote computer domain trusts. Otherwise, the remote computer cannot authenticate the user account specified and it cannot verify that the account is a member of the Administrators group.
The task must have sufficient permission to run on the remote computer. The permissions required vary with the task. By default, the task runs with the permission of the current user of the local computer or, if the /u parameter is used, the task runs with the permission of the account specified by the /u parameter. However, you can use the /ru parameter to run the task with permissions of a different user account or with system permissions.
Examples
An Administrator schedules a task on a remote computer
The following command schedules the MyApp program to run on the SRV01 remote computer every ten days starting immediately. The command uses the /s parameter to provide the name of the remote computer. Because the local current user is an Administrator of the remote computer, the /u parameter, which provides alternate permissions for scheduling the task, is not necessary.

Please note that when scheduling tasks on a remote computer, all parameters refer to the remote computer. Therefore, the executable file specified by the /tr parameter refers to the copy of MyApp.exe on the remote computer.


Copy
schtasks /create /s SRV01 /tn My App /tr c:\program files\corpapps\myapp.exe /sc daily /mo 10
In response, schtasks displays a success message indicating that the task is scheduled.

A user schedules a command on a remote computer (Case 1)
The following command schedules the MyApp program to run on the SRV06 remote computer every three hours. Because Administrator permissions are required to schedule a task, the command uses the /u and /p parameters to provide the credentials of the user's Administrator account (Admin01 in the Reskits domain). By default, these permissions are also used to run the task. However, because the task does not need Administrator permissions to run, the command includes the /u and /rp parameters to override the default and run the task with permission of the user's non-Administrator account on the remote computer.


Copy
schtasks /create /s SRV06 /tn My App /tr c:\program files\corpapps\myapp.exe /sc hourly /mo 3 /u reskits\admin01 /p R43253@4$ /ru SRV06\user03 /rp MyFav!!Pswd
In response, schtasks displays a success message indicating that the task is scheduled.

A user schedules a command on a remote computer (Case 2)
The following command schedules the MyApp program to run on the SRV02 remote computer on the last day of every month. Because the local current user (user03) is not an Administrator of the remote computer, the command uses the /u parameter to provide the credentials of the user's Administrator account (Admin01 in the Reskits domain). The Administrator account permissions will be used to schedule the task and to run the task.


Copy
schtasks /create /s SRV02 /tn My App /tr c:\program files\corpapps\myapp.exe /sc monthly /mo LASTDAY /m * /u reskits\admin01
Because the command did not include the /p (password) parameter, schtasks prompts for the password. Then it displays a success message and, in this case, a warning.


Copy
Type the password for reskits\admin01:********

SUCCESS: The scheduled task My App has successfully been created.

WARNING: The Scheduled task My App has been created, but may not run because
the account information could not be set.
This warning indicates that the remote domain could not authenticate the account specified by the /u parameter. In this case, the remote domain could not authenticate the user account because the local computer is not a member of a domain that the remote computer domain trusts. When this occurs, the task job appears in the list of scheduled tasks, but the task is actually empty and it will not run.

The following display from a verbose query exposes the problem with the task. In the display, note that the value of Next Run Time is Never and that the value of Run As User is Could not be retrieved from the task scheduler database.

Had this computer been a member of the same domain or a trusted domain, the task would have been successfully scheduled and would have run as specified.


Copy
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
Remarks
To run a /create command with the permissions of a different user, use the /u parameter. The /u parameter is valid only for scheduling tasks on remote computers.
To view more schtasks /create examples, type schtasks /create /? at a command prompt.
To schedule a task that runs with permissions of a different user, use the /ru parameter. The /ru parameter is valid for tasks on local and remote computers.
To use the /u parameter, the local computer must be in the same domain as the remote computer or must be in a domain that the remote computer domain trusts. Otherwise, either the task is not created, or the task job is empty and the task does not run.
Schtasks always prompts for a password unless you provide one, even when you schedule a task on the local computer using the current user account. This is normal behavior for schtasks.
Schtasks does not verify program file locations or user account passwords. If you do not enter the correct file location or the correct password for the user account, the task is created, but it does not run. Also, if the password for an account changes or expires, and you do not change the password saved in the task, then the task does not run.
The System account does not have interactive logon rights. Users do not see and cannot interact with programs run with system permissions.
Each task runs only one program. However, you can create a batch file that starts multiple tasks, and then schedule a task that runs the batch file.
You can test a task as soon as you create it. Use the run operation to test the task and then check the SchedLgU.txt file (SystemRoot\SchedLgU.txt) for errors.