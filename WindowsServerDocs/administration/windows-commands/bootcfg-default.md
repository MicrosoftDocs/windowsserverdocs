---
title: bootcfg default
description: Reference article for the bootcfg default command, which specifies the operating system entry to designate as the default.
ms.topic: reference
ms.assetid: e21824d7-8278-41d7-a2c5-ce09803d513a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# bootcfg default

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Specifies the operating system entry to designate as the default.

## Syntax

```
bootcfg /default [/s <computer> [/u <domain>\<user> /p <password>]] [/id <osentrylinenum>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `/s <computer>` | Specifies the name or IP address of a remote computer (don't use backslashes). The default is the local computer. |
| `/u <domain>\<user>`  | Runs the command with the account permissions of the user specified by `<user>` or `<domain>\<user>`. The default is the permissions of the current logged on user on the computer issuing the command. |
| `/p <password>` | Specifies the password of the user account that is specified in the **/u** parameter. |
| `/id <osentrylinenum>` | Specifies the operating system entry line number in the [operating systems] section of the Boot.ini file to which the operating system load options are added. The first line after the [operating systems] section header is 1. |
| /? | Displays help at the command prompt. |

## Examples

To use the **bootcfg /default** command:

```
bootcfg /default /id 2
bootcfg /default /s srvmain /u maindom\hiropln /p p@ssW23 /id 2
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bootcfg command](bootcfg.md)
