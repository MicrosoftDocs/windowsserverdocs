---
title: bootcfg addsw
description: Reference article for the bootcfg addsw command, which adds operating system load options for a specified operating system entry.
ms.topic: reference
ms.assetid: d8389293-ecd9-42f0-b84b-b9ead4cf52e6
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# bootcfg addsw

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Adds operating system load options for a specified operating system entry.

## Syntax

```
bootcfg /addsw [/s <computer> [/u <domain>\<user> /p <password>]] [/mm <maximumram>] [/bv] [/so] [/ng] /id <osentrylinenum>
```

### Parameters

| Term | Definition |
| ---- | ---------- |
| `/s <computer>` | Specifies the name or IP address of a remote computer (don't use backslashes). The default is the local computer. |
| `/u <domain>\<user>`  | Runs the command with the account permissions of the user specified by `<user>` or `<domain>\<user>`. The default is the permissions of the current logged on user on the computer issuing the command. |
| `/p <password>` | Specifies the password of the user account that is specified in the **/u** parameter. |
| `/mm <maximumram>` | Specifies the maximum amount of RAM, in megabytes, that the operating system can use. The value must be equal to or greater than 32 Megabytes. |
| /bv | Adds the **/basevideo** option to the specified `<osentrylinenum>`, directing the operating system to use standard VGA mode for the installed video driver. |
| /so | Adds the **/sos** option to the specified `<osentrylinenum>`, directing the operating system to display device driver names while they are being loaded. |
| /ng | Adds the **/noguiboot** option to the specified `<osentrylinenum>`, disabling the progress bar that appears before the CTRL+ALT+DEL logon prompt. |
| `/id <osentrylinenum>` | Specifies the operating system entry line number in the [operating systems] section of the Boot.ini file to which the operating system load options are added. The first line after the [operating systems] section header is 1. |
| /? | Displays help at the command prompt. |

## Examples

To use the **bootcfg /addsw** command:

```
bootcfg /addsw /mm 64 /id 2
bootcfg /addsw /so /id 3
bootcfg /addsw /so /ng /s srvmain /u hiropln /id 2
bootcfg /addsw /ng /id 2
bootcfg /addsw /mm 96 /ng /s srvmain /u maindom\hiropln /p p@ssW23 /id 2
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bootcfg command](bootcfg.md)
