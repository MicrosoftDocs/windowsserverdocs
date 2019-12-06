---
title: chkntfs
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 93eca810-8699-4716-8e9d-aecd54f704be
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# chkntfs



Displays or modifies automatic disk checking when the computer is started. If used without options, **chkntfs** displays the file system of the specified volume. If automatic file checking is scheduled to run, **chkntfs** displays whether the specified volume is dirty or is scheduled to be checked the next time the computer is started.

> [!NOTE]
> To run **chkntfs**, you must be a member of the Administrators group.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
chkntfs <Volume> [...]
chkntfs [/d]
chkntfs [/t[:<Time>]]
chkntfs [/x <Volume> [...]]
chkntfs [/c <Volume> [...]]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<Volume> [...]|Specifies one or more volumes to check when the computer starts. Valid volumes include drive letters (followed by a colon), mount points, or volume names.|
|/d|Restores all **chkntfs** default settings, except the countdown time for automatic file checking. By default, all volumes are checked when the computer is started, and **chkdsk** runs on those that are dirty.|
|/t [:\<Time>]|Changes the Autochk.exe initiation countdown time to the amount of time specified in seconds. If you do not enter a time, **/t** displays the current countdown time.|
|/x \<Volume> [...]|Specifies one or more volumes to exclude from checking when the computer is started, even if the volume is marked as requiring **chkdsk**.|
|/c \<Volume> [...]|Schedules one or more volumes to be checked when the computer is started, and runs **chkdsk** on those that are dirty.|
|/?|Displays help at the command prompt.|

## <a name="BKMK_examples"></a>Examples

To display the type of file system for drive C, type:
```
chkntfs c:
```
The following output indicates an NTFS file system:
```
The type of the file system is NTFS.
```

> [!NOTE]
> If automatic file checking is scheduled to run, additional output will display, indicating whether the drive is dirty or has been manually scheduled to be checked the next time the computer is started.

To display the Autochk.exe initiation countdown time, type:
```
chkntfs /t
```
For example, if the countdown time is set to 10 seconds, the following output displays:
```
The AUTOCHK initiation countdown time is set to 10 second(s).
```
To change the Autochk.exe initiation countdown time to 30 seconds, type:
```
chkntfs /t:30
```

> [!NOTE]
> Although you can set the Autochk.exe initiation countdown time to zero, doing so will prevent you from canceling a potentially time-consuming automatic file check.

The **/x** command-line option is not accumulative. If you type it more than once, the most recent entry overrides the previous entry. To exclude multiple volumes from being checked, you must list each of them in a single command. For example, to exclude both the D and E volumes, type:
```
chkntfs /x d: e:
```
The **/c** command-line option is accumulative. If you type **/c** more than once, each entry remains. To ensure that only a particular volume is checked, reset the defaults to clear all previous commands, exclude all volumes from being checked, and then schedule automatic file checking on the desired volume.

For example, to schedule automatic file checking on the D volume but not the C or E volumes, type the following commands in order:
```
chkntfs /d
chkntfs /x c: d: e:
chkntfs /c d:
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)