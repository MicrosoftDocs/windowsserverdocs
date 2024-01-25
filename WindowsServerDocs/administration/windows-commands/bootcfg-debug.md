---
title: bootcfg debug
description: Reference article for the bootcfg debug command, which adds or changes the debug settings for a specified operating system entry.
ms.topic: reference
ms.assetid: 28afa5fb-a236-46e2-b1a4-a3c43a49c437
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# bootcfg debug

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Adds or changes the debug settings for a specified operating system entry.

>[!NOTE]
> If you're attempting to debug port 1394, use the [bootcfg dbg1394](bootcfg-dbg1394.md) command instead.

## Syntax

```
bootcfg /debug {on | off | edit}[/s <computer> [/u <domain>\<user> /p <password>]] [/port {COM1 | COM2 | COM3 | COM4}] [/baud {9600 | 19200 | 38400 | 57600 | 115200}] [/id <osentrylinenum>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `{on | off | edit}` | Specifies the value for port debugging, including:<ul><li>**on.** Enables remote debugging support by adding the /debug option to the specified `<osentrylinenum>`.</li><li>**off.** Disables remote debugging support by removing the /debug option from the specified `<osentrylinenum>`.</li><li>**edit.** Allows changes to port and baud rate settings by changing the values associated with the /debug option for the specified `<osentrylinenum>`.</li></ul> |
| `/s <computer>` | Specifies the name or IP address of a remote computer (don't use backslashes). The default is the local computer. |
| `/u <domain>\<user>`  | Runs the command with the account permissions of the user specified by `<user>` or `<domain>\<user>`. The default is the permissions of the current logged on user on the computer issuing the command. |
| `/p <password>` | Specifies the password of the user account that is specified in the **/u** parameter. |
| `/port {COM1 | COM2 | COM3 | COM4}` |  Specifies the COM port to be used for debugging. Don't use this parameter if debugging is disabled. |
| `/baud {9600 | 19200 | 38400 | 57600 | 115200}` | Specifies the baud rate to be used for debugging. Don't use this parameter if debugging is disabled. |
| `/id <osentrylinenum>` | Specifies the operating system entry line number in the [operating systems] section of the Boot.ini file to which the operating system load options are added. The first line after the [operating systems] section header is 1. |
| /? | Displays help at the command prompt. |

## Examples

To use the **bootcfg /debug** command:

```
bootcfg /debug on /port com1 /id 2
bootcfg /debug edit /port com2 /baud 19200 /id 2
bootcfg /s srvmain /u maindom\hiropln /p p@ssW23 /debug off /id 2
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bootcfg command](bootcfg.md)
