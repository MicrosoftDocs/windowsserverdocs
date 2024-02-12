---
title: bootcfg ems
description: Reference article for the bootcfg ems command, which enables the user to add or change the settings for redirection of the Emergency Management Services console to a remote computer.
ms.topic: reference
ms.assetid: 57abdc50-c64a-45f1-8470-3f8c3a51f743
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# bootcfg ems

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Enables the user to add or change the settings for redirection of the Emergency Management Services console to a remote computer. Enabling Emergency Management Services, adds a `redirect=Port#` line to the [boot loader] section of the Boot.ini file along with a /redirect option to the specified operating system entry line. The Emergency Management Services feature is enabled only on servers.

## Syntax

```
bootcfg /ems {on | off | edit}[/s <computer> [/u <domain>\<user> /p <password>]] [/port {COM1 | COM2 | COM3 | COM4 | BIOSSET}] [/baud {9600 | 19200 | 38400 | 57600 | 115200}] [/id <osentrylinenum>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `{on | off | edit}` | Specifies the value for Emergency Management Services redirection, including:<ul><li>**on.** Enables remote output for the specified `<osentrylinenum>`. Also adds a /redirect option to the specified `<osentrylinenum>` and a `redirect=com<X>` setting to the [boot loader] section. The value of `com<X>` is set by the **/port** parameter.</li><li>**off.** Disables output to a remote computer. Also removes the /redirect option to the specified `<osentrylinenum>` and the `redirect=com<X>` setting from the [boot loader] section.</li><li>**edit.** Allows changes to port settings by changing the `redirect=com<X>` setting in the [boot loader] section. The value of `com<X>` is set by the **/port** parameter.</li></ul> |
| `/s <computer>` | Specifies the name or IP address of a remote computer (don't use backslashes). The default is the local computer. |
| `/u <domain>\<user>`  | Runs the command with the account permissions of the user specified by `<user>` or `<domain>\<user>`. The default is the permissions of the current logged on user on the computer issuing the command. |
| `/p <password>` | Specifies the password of the user account that is specified in the **/u** parameter. |
| `/port {COM1 | COM2 | COM3 | COM4 | BIOSSET}` |  Specifies the COM port to be used for redirection. The BIOSSET parameter directs Emergency Management Services to get the BIOS settings to determine which port should be used for redirection. Don't use this parameter if remotely administered output is disabled. |
| `/baud {9600 | 19200 | 38400 | 57600 | 115200}` | Specifies the baud rate to be used for redirection. Don't use this parameter if remotely administered output is disabled. |
| `/id <osentrylinenum>` | Specifies the operating system entry line number to which the Emergency Management Services option is added in the [operating systems] section of the Boot.ini file. The first line after the [operating systems] section header is 1. This parameter is required when the Emergency Management Services value is set to **on** or **off**. |
| /? | Displays help at the command prompt. |

## Examples

To use the **bootcfg /ems** command:

```
bootcfg /ems on /port com1 /baud 19200 /id 2
bootcfg /ems on /port biosset /id 3
bootcfg /s srvmain /ems off /id 2
bootcfg /ems edit /port com2 /baud 115200
bootcfg /s srvmain /u maindom\hiropln /p p@ssW23 /ems off /id 2
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bootcfg command](bootcfg.md)
