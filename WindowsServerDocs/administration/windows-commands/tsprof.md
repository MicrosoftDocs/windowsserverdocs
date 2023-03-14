---
title: tsprof
description: Reference article for the tsprof command, which copies the Remote Desktop Services user configuration information from one user to another.
ms.topic: reference
ms.assetid: 27047868-b706-4208-b7e0-1437a2325dd3
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# tsprof

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Copies the Remote Desktop Services user configuration information from one user to another. The Remote Desktop Services user configuration information appears in the Remote Desktop Services extensions to Local Users and Groups and active directory Users and computers.

> [!NOTE]
> You can also use the [tsprof command](tsprof.md) to set the profile path for a user.
>
> To find out what's new in the latest version, see [What's New in Remote Desktop Services in Windows Server](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn283323(v=ws.11)).

## Syntax

```
tsprof /update {/domain:<Domainname> | /local} /profile:<path> <username>
tsprof /copy {/domain:<Domainname> | /local} [/profile:<path>] <src_user> <dest_user>
tsprof /q {/domain:<Domainname> | /local} <username>
```

### Parameters

| Parameter | Description |
|--|--|
| /update | Updates profile path information for `<username>` in domain `<domainname>` to `<profilepath>`. |
| /domain:`<Domainname>` | Specifies the name of the domain in which the operation is applied. |
| /local | Applies the operation only to local user accounts. |
| /profile:`<path>` | Specifies the profile path as displayed in the Remote Desktop Services extensions in Local Users and Groups and active directory Users and computers. |
| `<username>` | Specifies the name of the user for whom you want to update or query the server profile path. |
| /copy | Copies user configuration information from `<src_user>` to `<dest_user>` and updates the profile path information for `<dest_user>` to `<profilepath>`. Both `<src_user>` and `<dest_user>` must either be local or must be in domain `<domainname>`. |
| `<src_user>` | Specifies the name of the user from whom you want to copy the user configuration information. Also known as the source user. |
| `<dest_user>` | Specifies the name of the user to whom you want to copy the user configuration information. Also known as the destination user. |
| /q | Displays the current profile path of the user for whom you want to query the server profile path. |
| /? | Displays help at the command prompt. |

## Examples

To copy user configuration information from *LocalUser1* to *LocalUser2*, type:

```
tsprof /copy /local LocalUser1 LocalUser2
```

To set the Remote Desktop Services profile path for *LocalUser1* to a directory called *c:\profiles*, type:

```
tsprof /update /local /profile:c:\profiles LocalUser1
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Remote Desktop Services (Terminal Services) Command Reference](remote-desktop-services-terminal-services-command-reference.md)
