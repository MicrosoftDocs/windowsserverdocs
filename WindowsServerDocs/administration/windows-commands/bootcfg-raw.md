---
title: bootcfg raw
description: Reference article for the bootcfg raw command, which adds operating system load options, specified as a string, to an operating system entry in the operating system section of the Boot.ini file.
ms.topic: reference
ms.assetid: e3458749-b0a0-460f-a022-3ff199a71f27
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# bootcfg raw

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Adds operating system load options specified as a string to an operating system entry in the [operating systems] section of the Boot.ini file. This command overwrites any existing operating system entry options.

## Syntax

```
bootcfg /raw [/s <computer> [/u <domain>\<user> /p <password>]] <osloadoptionsstring> [/id <osentrylinenum>] [/a]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `/s <computer>` | Specifies the name or IP address of a remote computer (don't use backslashes). The default is the local computer. |
| `/u <domain>\<user>`  | Runs the command with the account permissions of the user specified by `<user>` or `<domain>\<user>`. The default is the permissions of the current logged on user on the computer issuing the command. |
| `/p <password>` | Specifies the password of the user account that is specified in the **/u** parameter. |
| `<osloadoptionsstring>` | Specifies the operating system load options to add to the operating system entry. These load options replace any existing load options associated with the operating system entry. There is no validation against the `<osloadoptions>` parameter.
| `/id <osentrylinenum>` | Specifies the operating system entry line number in the [operating systems] section of the Boot.ini file to which the operating system load options are added. The first line after the [operating systems] section header is 1. |
| /a | Specifies which operating system options should be appended to any existing operating system options. |
| /? | Displays help at the command prompt. |

## Examples

This text should contain valid OS Load Options such as **/debug**, **/fastdetect**, **/nodebug**, **/baudrate**, **/crashdebug**, and **/sos**.

To add **/debug /fastdetect** to the end of the first operating system entry, replacing any previous operating system entry options:

```
bootcfg /raw /debug /fastdetect /id 1
```

To use the **bootcfg /raw** command:

```
bootcfg /raw /debug /sos /id 2
bootcfg /raw /s srvmain /u maindom\hiropln /p p@ssW23 /crashdebug  /id 2
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bootcfg command](bootcfg.md)
