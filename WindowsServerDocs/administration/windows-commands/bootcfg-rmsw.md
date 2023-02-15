---
title: bootcfg rmsw
description: Reference article for the bootcfg rmsw command, which removes operating system load options for a specified operating system entry.
ms.topic: reference
ms.assetid: fd7e4248-880e-4e2b-929e-87f8d44b9a63
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# bootcfg rmsw

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Removes operating system load options for a specified operating system entry.

## Syntax

```
bootcfg /rmsw [/s <computer> [/u <domain>\<user> /p <password>]] [/mm] [/bv] [/so] [/ng] /id <osentrylinenum>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `/s <computer>` | Specifies the name or IP address of a remote computer (don't use backslashes). The default is the local computer. |
| `/u <domain>\<user>`  | Runs the command with the account permissions of the user specified by `<user>` or `<domain>\<user>`. The default is the permissions of the current logged on user on the computer issuing the command. |
| `/p <password>` | Specifies the password of the user account that is specified in the **/u** parameter. |
| /mm | Removes the /maxmem option and its associated maximum memory value from the specified `<osentrylinenum>`. The /maxmem option specifies the maximum amount of RAM that the operating system can use. |
| /bv | Removes the /basevideo option from the specified `<osentrylinenum>`. The /basevideo option directs the operating system to use standard VGA mode for the installed video driver. |
| /so | Removes the /sos option from the specified `<osentrylinenum>`. The /sos option directs the operating system to display device driver names while they are being loaded. |
| /ng | Removes the /noguiboot option from the specified `<osentrylinenum>`. The /noguiboot option disables the progress bar that appears before the CTRL+ALT+DEL logon prompt. |
| `/id <osentrylinenum>` | Specifies the operating system entry line number in the [operating systems] section of the Boot.ini file to which the operating system load options are added. The first line after the [operating systems] section header is 1. |
| /? | Displays help at the command prompt. |

## Examples

To use the **bootcfg /rmsw** command:

```
bootcfg /rmsw /mm 64 /id 2
bootcfg /rmsw /so /id 3
bootcfg /rmsw /so /ng /s srvmain /u hiropln /id 2
bootcfg /rmsw /ng /id 2
bootcfg /rmsw /mm 96 /ng /s srvmain /u maindom\hiropln /p p@ssW23 /id 2
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bootcfg command](bootcfg.md)
