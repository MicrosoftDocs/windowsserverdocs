---
title: bootcfg copy
description: Reference article for the bootcfg copy command, which makes a copy of an existing boot entry, to which you can add command-line options.
ms.topic: reference
ms.assetid: 2a236c2a-8675-444d-b695-9cbc9aff643b
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# bootcfg copy

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Makes a copy of an existing boot entry, to which you can add command-line options.

## Syntax

```
bootcfg /copy [/s <computer> [/u <domain>\<user> /p <password>]] [/d <description>] [/id <osentrylinenum>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `/s <computer>` | Specifies the name or IP address of a remote computer (don't use backslashes). The default is the local computer. |
| `/u <domain>\<user>`  | Runs the command with the account permissions of the user specified by `<user>` or `<domain>\<user>`. The default is the permissions of the current logged on user on the computer issuing the command. |
| `/p <password>` | Specifies the password of the user account that is specified in the **/u** parameter. |
| `/d <description>` | Specifies the description for the new operating system entry. |
| `/id <osentrylinenum>` | Specifies the operating system entry line number in the [operating systems] section of the Boot.ini file to which the operating system load options are added. The first line after the [operating systems] section header is 1. |
| /? | Displays help at the command prompt. |

## Examples

To copy boot entry 1 and enter \ABC Server\ as the description:

```
bootcfg /copy /d \ABC Server\ /id 1
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bootcfg command](bootcfg.md)
