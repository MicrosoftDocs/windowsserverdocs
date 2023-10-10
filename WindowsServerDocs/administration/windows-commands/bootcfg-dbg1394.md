---
title: bootcfg dbg1394
description: Reference article for the bootcfg dbg1394 command, which configures 1394 port debugging for a specified operating system entry
ms.topic: reference
ms.assetid: 35724697-90dd-4dbe-85b0-337fbd369dcc
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# bootcfg dbg1394

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Configures 1394 port debugging for a specified operating system entry.

## Syntax

```
bootcfg /dbg1394 {on | off}[/s <computer> [/u <domain>\<user> /p <password>]] [/ch <channel>] /id <osentrylinenum>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `{on | off}` | Specifies the value for 1394 port debugging, including:<ul><li>**on.** Enables remote debugging support by adding the /dbg1394 option to the specified `<osentrylinenum>`.</li><li>**off.** Disables remote debugging support by removing the /dbg1394 option from the specified `<osentrylinenum>`.</li></ul> |
| `/s <computer>` | Specifies the name or IP address of a remote computer (don't use backslashes). The default is the local computer. |
| `/u <domain>\<user>`  | Runs the command with the account permissions of the user specified by `<user>` or `<domain>\<user>`. The default is the permissions of the current logged on user on the computer issuing the command. |
| `/p <password>` | Specifies the password of the user account that is specified in the **/u** parameter. |
| `/ch <channel>` | Specifies the channel to use for debugging. Valid values include integers, between 1 and 64. Don't use this parameter if 1394 port debugging is disabled. |
| `/id <osentrylinenum>` | Specifies the operating system entry line number in the [operating systems] section of the Boot.ini file to which the operating system load options are added. The first line after the [operating systems] section header is 1. |
| /? | Displays help at the command prompt. |

## Examples

To use the **bootcfg /dbg1394**command:

```
bootcfg /dbg1394 /id 2
bootcfg /dbg1394 on /ch 1 /id 3
bootcfg /dbg1394 edit /ch 8 /id 2
bootcfg /s srvmain /u maindom\hiropln /p p@ssW23 /dbg1394 off /id 2
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bootcfg command](bootcfg.md)
