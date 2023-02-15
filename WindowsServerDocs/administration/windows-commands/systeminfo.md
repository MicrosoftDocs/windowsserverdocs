---
title: systeminfo
description: Reference article for the systeminfo command, which displays detailed configuration information about a computer and its operating system, including operating system configuration, security information, product ID, and hardware properties (such as RAM, disk space, and network cards).
ms.topic: reference
ms.assetid: 39954968-3c2e-4d3e-9d89-c9c43347461e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# systeminfo

Displays detailed configuration information about a computer and its operating system, including operating system configuration, security information, product ID, and hardware properties (such as RAM, disk space, and network cards).

## Syntax

```
systeminfo [/s <computer> [/u <domain>\<username> [/p <password>]]] [/fo {TABLE | LIST | CSV}] [/nh]
```

### Parameters

| Parameter | Description |
|--|--|
| /s `<computer>` | Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer. |
| /u `<domain>\<username>` | Runs the command with the account permissions of the specified user account. If **/u** is not specified, this command uses the permissions of the user who is currently logged on to the computer that is issuing the command. |
| /p `<password>` | Specifies the password of the user account that is specified in the **/u** parameter. |
| /fo `<format>` | Specifies the output format with one of the following values:<ul><li>**TABLE** - Displays output in a table.</li><li>**LIST** - Displays output in a list.</li><li>**CSV** - Displays output in comma-separated values (.csv) format.</li></ul> |
| /nh | Suppresses column headers in the output. Valid when the **/fo** parameter is set to TABLE or CSV. |
| /? | Displays help at the command prompt. |

## Examples

To view configuration information for a computer named *Srvmain*, type:

```
systeminfo /s srvmain
```

To remotely view configuration information for a computer named *Srvmain2* that is located on the *Maindom* domain, type:

```
systeminfo /s srvmain2 /u maindom\hiropln
```

To remotely view configuration information (in list format) for a computer named *Srvmain2* that is located on the *Maindom* domain, type:

```
systeminfo /s srvmain2 /u maindom\hiropln /p p@ssW23 /fo list
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
