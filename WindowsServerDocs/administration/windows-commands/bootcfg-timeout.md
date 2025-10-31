---
title: bootcfg timeout
description: Reference article for the bootcfg timeout command, which changes the operating system time-out value.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---
# bootcfg timeout



Changes the operating system time-out value.

## Syntax

```
bootcfg /timeout <timeoutvalue> [/s <computer> [/u <domain>\<user> /p <password>]]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `/timeout <timeoutvalue>` | Specifies the timeout value in the [boot loader] section. The `<timeoutvalue>` is the number of seconds the user has to select an operating system from the boot loader screen before NTLDR loads the default. The valid range for `<timeoutvalue>` is 0-999. If the value is 0, NTLDR immediately starts the default operating system without displaying the boot loader screen. |
| `/s <computer>` | Specifies the name or IP address of a remote computer (don't use backslashes). The default is the local computer. |
| `/u <domain>\<user>`  | Runs the command with the account permissions of the user specified by `<user>` or `<domain>\<user>`. The default is the permissions of the current logged on user on the computer issuing the command. |
| `/p <password>` | Specifies the password of the user account that is specified in the **/u** parameter. |
| /? | Displays help at the command prompt. |

## Examples

To use the **bootcfg /timeout** command:

```
bootcfg /timeout 30
bootcfg /s srvmain /u maindom\hiropln /p p@ssW23 /timeout 50
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bootcfg command](bootcfg.md)
