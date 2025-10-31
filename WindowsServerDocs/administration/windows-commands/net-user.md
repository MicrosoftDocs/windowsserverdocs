---
title: net user
description: Reference article for the net user command, which adds, deletes, modifies, and displays user account information.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 08/06/2025
---

# net user

The `net user` command allows you to add, modify, or delete user accounts, and display detailed information about user accounts on a local computer or domain.

## Syntax

```
net user [<UserName> {<Password> | *} [<Options>]] [/domain]
net user [<UserName> {<Password> | *} /add [<Options>] [/domain]]
net user [<UserName> [/delete] [/domain]]
net user username [/times:{times | all}]
net user username [/active: {yes | no}]
```

## Parameters

|Parameter|Description|
|---|---|
| `<UserName>` | Specifies the name of the user account to add, delete, modify, or view. The name of the user account can have as many as 20 characters. |
| `<Password>` | Assigns or changes a password for the user's account. Type an asterisk (`*`) to produce a prompt for the password. The password isn't displayed when the user types it at the password prompt. |
| `<Options>` | Specifies a command-line option. Refer to the next table for descriptions of the command-line option syntax. |
| `/domain` | Performs the operation on the domain controller in the computer's primary domain. |
| `/add` | Adds a new user account. When combined with `/domain`, it specifies that the account should be created on the domain instead of the local machine. |
| `/delete` | Deletes the specified user account. When combined with `/domain`, it deletes the account from the domain rather than the local machine. |
| `/times:{<Day>[-<Day>][,<Day>[-<Day>]],<Time>[-<Time>][,<Time>[-<Time>]][;] \| all}` | Specifies the days and times when users are permitted to sign into the computer. <br><br> `<Time>` must be in one-hour increments. <br><br> `<Day>` can be spelled out or abbreviated (`M, T, W, Th, F, Sa, Su`). Hours can be specified in either 12-hour (with AM/PM or A.M./P.M.) or 24-hour format. <br><br> Use **all** to allow sign in at any time, or leave blank to prevent sign in entirely. Separate days and times with commas, and separate multiple day/time entries with semicolons (for example: **M,4AM-5PM;T,1PM-3PM**). Don't include spaces in the time designations. |
| `/active:{yes \| no}` | Enables or disables the user account. If the user account isn't active, the user can't access resources on the computer. The default is **yes**. |
| ? | Displays the command help information. |

| Options parameter syntax | Description |
|---|---|
| `/comment:"<Text>"` | Provides a descriptive comment about the user's account. This comment can have as many as 48 characters. The text must be enclosed in double quotes. |
| `/countrycode:<NNN>` | Uses the operating system Country/Region codes to implement the specified language files for a user's Help and error messages. A value of 0 signifies the **default** Country/Region code. |
| `/expires:{{<MM/DD/YYYY> \| <DD/MM/YYYY> \| <mmm,dd,YYYY>} \| never}` | Sets the expiration period for the specified user account. Expiration dates can be in [MM/DD/YYYY], [DD/MM/YYYY], or [mmm,dd,YYYY] formats, depending on the Country/Region code. <br><br> `never` specifies that a user account doesn't have an expiration date. When you set an account to never expire, it means the account remains active indefinitely, unless manually disabled or deleted by an administrator. Accounts are set to never expire by default. <br><br> The account expires at the beginning of the specified date. For the *month* value, you can use numbers (`1` for January), spell it out (`January`), or use a three-letter abbreviation (`Jan`, `Feb`, etc.). You can use two or four numbers for the year value. Use commas or slashes to separate parts of the date. Don't use spaces. If you omit`<YYYY>`, the next occurrence of the date is assumed. <br><br>For example, the following entries are equivalent if entered between Jan. 10, 2018, and Jan. 8, 2019: <br><br> **Jan,9**<br>**1/9/18**<br>**January,9,2019**<br>**1/9** |
| `/fullname:"<Name>"` | Specifies a user's full name rather than a user name. Enclose the name in quotation marks. |
| `/homedir:<Path>` | Sets the path for the user's home directory. The path must exist. |
| `/passwordchg:{yes \| no}` | Specifies whether users can change their own password. The default is **yes**. |
| `/passwordreq:{yes \| no}` | Specifies whether a user account must have a password. The default is **yes**. |
| `/profilepath:[<Path>]` | Sets a path for the user's sign in profile. This path points to a registry profile. |
| `/scriptpath:<Path>` | Specifies the relative path to the user's sign-in script. The path must not be absolute; use a relative path such as `\\domain\SysVol\domain\scripts`. |
| `/usercomment:"<Text>"` | Specifies that an administrator can add or change the "User comment" for the account. The text must be enclosed in double quotes. |
| `/workstations:{<ComputerName>[,...] \| *}` | Lists as many as eight (8) workstations from which a user can sign into the network. Separate multiple entries in the list with commas. If `/workstations` has no list or if the list is an asterisk (`*`), users can sign in from any computer. |

> [!NOTE]
> A password must satisfy the minimum password length value that is set with the **net accounts /minpwlen** command. A password can have as many as 127 characters.

## Examples

To display a list of all user accounts for the local computer, run the following command:

```cmd
net user
```

To display information about the user account **TommyH**, run the following command:

```cmd
net user tommyh
```

To add a user account for **Jay Samson** (user name: **jays**), with sign in rights from 8 AM to 5 PM, Monday through Friday, with the mandatory password **Cyk4^g3B**, and use the user's full name, run the following command:

```cmd
net user jays Cyk4^g3B /add /passwordreq:yes /times:monday-friday,8am-5pm /fullname:"Jay Jamison"
```

To set the sign-in time from 8 AM to 5 PM for the username **MikeD** using 24-hour notation, run the following command:

```cmd
net user miked /time:M-F,08:00-17:00
```

To set the sign-in time from 8 AM to 5 PM for **MikeD** using 12-hour notation, run the following command:

```cmd
net user miked /time:M-F,8AM-5PM
```

To specify sign-in hours of 4 AM to 12 PM on Monday, 12 PM to 8 PM on Tuesday, and 8 AM to 5 PM Wednesday through Friday for username **AnibalS**, run the following command:

```cmd
net user anibals /time:M,4AM-12PM;T,12PM-8PM;W-F,8AM-5PM
```

## See also

[Command-Line Syntax Key](command-line-syntax-key.md)
