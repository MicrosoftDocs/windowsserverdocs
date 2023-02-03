---
title: freedisk
description: Reference article for the freedisk command, which checks to see if the specified amount of disk space is available before continuing with an installation process.
ms.topic: reference
ms.assetid: 91c15166-5baa-4b80-9e0c-4cd815d00530
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# freedisk

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Checks to see if the specified amount of disk space is available before continuing with an installation process.

## Syntax

```
freedisk [/s <computer> [/u [<domain>\]<user> [/p [<password>]]]] [/d <drive>] [<value>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /s `<computer>` | Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer. This parameter applies to all files and folders specified in the command. |
| /u [`<domain>`\\]`<user>` | Runs the script with the permissions of the specified user account. The default is system permissions. |
| /p [`<password>`] | Specifies the password of the user account that is specified in **/u**. |
| /d `<drive>` | Specifies the drive for which you want to find out the availability of free space. You must specify `<drive>` for a remote computer. |
| `<value>` | Checks for a specific amount of free disk space. You can specify `<value>` in bytes, KB, MB, GB, TB, PB, EB, ZB, or YB. |

#### Remarks

- Using the **/s**, **/u**, and **/p** command-line options are available only when you use **/s**. You must use **/p** with **/u**to provide the user's password.

- For unattended installations, you can use **freedisk** in installation batch files to check for the prerequisite amount free space before continuing with the installation.

- When you use **freedisk** in a batch file, it returns a **0** if there's enough space and a **1** if there's not enough space.

### Examples

To determine whether there are at least 50 MB of free space available on drive C, type:

```
freedisk 50mb
```

Output similar to the following example appears on the screen:

```
INFO: The specified 52,428,800 byte(s) of free space is available on current drive.
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
