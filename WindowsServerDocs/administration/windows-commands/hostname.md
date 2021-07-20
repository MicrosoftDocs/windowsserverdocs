---
title: hostname
description: Reference article for the hostname command, which displays the host name portion of the full computer name of the computer.
ms.topic: reference
ms.assetid: b9e7aab4-8f8d-4e18-b5a2-8e81b34a8566
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# hostname

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays the host name portion of the full computer name of the computer.

>[!IMPORTANT]
> This command is available only if the Internet Protocol (TCP/IP) protocol is installed as a component in the properties of a network adapter in Network.

## Syntax

```
hostname
```

### Parameters
| Parameter | Description |
| ------- | -------- |
| /? | Displays help at the command prompt. |

Any parameter different than `/?` will produce an error message and will set the errorlevel to 1.

### Notes

- Environment variable `%COMPUTERNAME%` usually will print the same string as hostname but in uppercase
- If environment variable `_CLUSTER_NETWORK_NAME_` is defend hostname will print its value.

### Examples

- To display the name of the computer, type:

```
hostname
```

- To display the name of the computer in upper case:

```
echo %COMPUTERNAME%
```

- To alter the hostname output:

```
set "_CLUSTER_NETWORK_NAME_=Altered Computer Name"
hostname
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
