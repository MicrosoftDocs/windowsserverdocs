---
title: bootcfg query
description: Reference article for the bootcfg query command, which queries and displays the boot loader and operating system section entries from Boot.ini.
ms.topic: reference
ms.assetid: a4cacfd1-10a6-4a11-b0c5-f8abde72bfc8
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# bootcfg query

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Queries and displays the [boot loader] and [operating systems] section entries from Boot.ini.

## Syntax

```
bootcfg /query [/s <computer> [/u <domain>\<user> /p <password>]]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `/s <computer>` | Specifies the name or IP address of a remote computer (don't use backslashes). The default is the local computer. |
| `/u <domain>\<user>`  | Runs the command with the account permissions of the user specified by `<user>` or `<domain>\<user>`. The default is the permissions of the current logged on user on the computer issuing the command. |
| `/p <password>` | Specifies the password of the user account that is specified in the **/u** parameter. |
| /? | Displays help at the command prompt. |

#### Sample output

Sample output for the **bootcfg /query** command:

```
Boot Loader Settings
----------
timeout: 30
default: multi(0)disk(0)rdisk(0)partition(1)\WINDOWS
Boot Entries
------
Boot entry ID:   1
Friendly Name:
path: multi(0)disk(0)rdisk(0)partition(1)\WINDOWS
OS Load Options: /fastdetect /debug /debugport=com1:
```

- The **Boot Loader Settings** area shows each entry in the [boot loader] section of Boot.ini.

- The **Boot Entries** area shows more details for each operating system entry in the [operating systems] section of the Boot.ini

## Examples

To use the **bootcfg /query** command:

```
bootcfg /query
bootcfg /query /s srvmain /u maindom\hiropln /p p@ssW23
bootcfg /query /u hiropln /p p@ssW23
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bootcfg command](bootcfg.md)
