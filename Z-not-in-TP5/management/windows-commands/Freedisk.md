---
title: Freedisk
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 91c15166-5baa-4b80-9e0c-4cd815d00530
---
# Freedisk
Checks to see if the specified amount of disk space is available before continuing with an installation process.

For examples of how this command can be used, see [Examples](#BKMK_examples).

## Syntax

```
freedisk [/s <Computer> [/u [<Domain>\]<User> [/p [<Password>]]]] [/d <Drive>] [<Value>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|/s <Computer>|Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer. This parameter applies to all files and folders specified in the command.|
|/u [<Domain>\\]<User>|Runs the script with the permissions of the specified user account. The default is system permissions.|
|/p [<Password>]|Specifies the password of the user account that is specified in **/u**.|
|/d <Drive>|Specifies the drive for which you want to find out the availability of free space. You must specify <Drive>for a remote computer.|
|<Value>|Checks for a specific amount of free disk space. You can specify <Value>in bytes, KB, MB, GB, TB, PB, EB, ZB or YB.|

## Remarks

-   Using the **/s**, **/u**, and **/p** command-line options are available only when you use **/s**. You must use **/p** with **/u**to provide the user’s password.

-   For unattended installations, you can use **freedisk** in installation batch files to check for the prerequisite amount free space before continuing with the installation.

-   When you use **freedisk** in a batch file, it returns a **0** if there is enough space and a **1** if there is not enough space.

## <a name="BKMK_examples"></a>Examples
To determine whether there are at least 50 MB of free space available on drive C:, type:

```
freedisk 50mb 
```

Output similar to the following appears on the screen:

```
INFO: The specified 52,428,800 byte(s) of free space is available on current drive.
```

### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)


