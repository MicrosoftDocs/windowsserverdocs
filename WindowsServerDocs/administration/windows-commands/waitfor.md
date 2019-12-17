---
title: waitfor
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a48ef70d-4d28-4035-b6b0-7d7b46ac2157
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# waitfor



Sends or waits for a signal on a system. **Waitfor** is used to synchronize computers across a network.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
waitfor [/s <Computer> [/u [<Domain>\]<User> [/p [<Password>]]]] /si <SignalName>
waitfor [/t <Timeout>] <SignalName>
```

## Parameters

|       Parameter       |                                                                                         Description                                                                                          |
|-----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    /s \<Computer>     | Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer. This parameter applies to all files and folders specified in the command. |
| /u [\<Domain>\]<User> |                              Runs the script using the credentials of the specified user account. By default, **waitfor** uses the current user's credentials.                               |
|   /p [\<Password>]    |                                                    Specifies the password of the user account that is specified in the **/u** parameter.                                                     |
|          /si          |                                                                        Sends the specified signal across the network.                                                                        |
|     /t \<Timeout>     |                                              Specifies the number of seconds to wait for a signal. By default, **waitfor** waits indefinitely.                                               |
|     \<SignalName>     |                                                Specifies the signal that **waitfor** waits for or sends. *SignalName* is not case-sensitive.                                                 |
|          /?           |                                                                             Displays help at the command prompt.                                                                             |

## Remarks

-   Signal names cannot exceed 225 characters. Valid characters include a-z, A-Z, 0-9, and the ASCII extended character set (128-255).
-   If you do not use **/s**, the signal is broadcast to all the systems in a domain. If you use **/s**, the signal is sent only to the specified system.
-   You can run multiple instances of **waitfor** on a single computer, but each instance of **waitfor** must wait for a different signal. Only one instance of **waitfor** can wait for a given signal on a given computer.
-   You can activate a signal manually by using the **/si** command-line option.
-   **Waitfor** runs only on Windows XP and servers running a Windows Server 2003 operating system, but it can send signals to any computer running a Windows operating system.
-   Computers can only receive signals if they are in the same domain as the computer sending the signal.
-   You can use **waitfor** when you test software builds. For example, the compiling computer can send a signal to several computers running **waitfor** after the compile has completed successfully. On receipt of the signal, the batch file that includes **waitfor** can instruct the computers to immediately start installing software or running tests on the compiled build.

## <a name="BKMK_examples"></a>Examples

To wait until the "espresso\build007" signal is received, type:
```
waitfor espresso\build007
```
By default, **waitfor** waits indefinitely for a signal.

To wait 10 seconds for the "espresso\compile007" signal to be received before timing out, type:
```
waitfor /t 10 espresso\build007
```
To manually activate the "espresso\build007" signal, type:
```
waitfor /si espresso\build007
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)