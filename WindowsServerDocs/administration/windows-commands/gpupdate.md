---
title: gpupdate
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2fd4e567-2ce1-4637-b611-c2f0895e5708

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# gpupdate

Updates Group Policy settings. For examples of how this command can be used, see [Examples](#examples).

## Syntax

```
gpupdate [/target:{Computer | User}] [/force] [/wait:<VALUE>] [/logoff] [/boot] [/sync] [/?]
```

### Parameters

|     Parameter     |                                                                                                                                                                                                                                                                                                                             Description                                                                                                                                                                                                                                                                                                                             |
|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| /target:{Computer |                                                                                                                                                                                                                                                                                                                                User}                                                                                                                                                                                                                                                                                                                                |
|      /force       |                                                                                                                                                                                                                                                                                   Reapplies all policy settings. By default, only policy settings that have changed are applied.                                                                                                                                                                                                                                                                                    |
|  /wait:\<VALUE>   | Sets the number of seconds to wait for policy processing to finish before returning to the command prompt. When the time limit is exceeded, the command prompt appears, but policy processing continues. The default value is 600 seconds. The value **0** means not to wait. The value **-1** means to wait indefinitely.</br>In a script, by using this command with a time limit specified, you can run **gpupdate** and continue with commands that do not depend upon the completion of **gpupdate**. Alternatively, you can use this command with no time limit specified to let **gpupdate** finish running before other commands that depend on it are run. |
|      /logoff      |                                                                                                                                   Causes a logoff after the Group Policy settings are updated. This is required for those Group Policy client-side extensions that do not process policy on a background update cycle but do process policy when a user logs on. Examples include user-targeted Software Installation and Folder Redirection. This option has no effect if there are no extensions called that require a logoff.                                                                                                                                    |
|       /boot       |                                                                                                                                       Causes a computer restart after the Group Policy settings are applied. This is required for those Group Policy client-side extensions that do not process policy on a background update cycle but do process policy at computer startup. Examples include computer-targeted Software Installation. This option has no effect if there are no extensions called that require a restart.                                                                                                                                        |
|       /sync       |                                                                                                                                                                              Causes the next foreground policy application to be done synchronously. Foreground policy is applied at computer boot and user logon. You can specify this for the user, computer, or both, by using the **/target** parameter. The **/force** and **/wait** parameters are ignored if you specify them.                                                                                                                                                                               |
|        /?         |                                                                                                                                                                                                                                                                                                                Displays Help at the command prompt.                                                                                                                                                                                                                                                                                                                 |

## Remarks

-   The **gpupdate** command is available in Windows Server 2008 R2, Windows Server 2008, Windows 7 Ultimate, Windows 7 Professional, Windows Vista Ultimate, Windows Vista Enterprise, and Windows Vista Business.

## Examples

Force a background update of all Group Policy settings, regardless of whether they have changed.

```
gpupdate /force
```

#### Additional references

-   [Group Policy TechCenter](https://go.microsoft.com/fwlink/?LinkID=145531)
-   [Command-Line Syntax Key](command-line-syntax-key.md)