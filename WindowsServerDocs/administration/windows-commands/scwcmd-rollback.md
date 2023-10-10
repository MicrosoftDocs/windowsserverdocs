---
title: scwcmd rollback
description: Reference article for the scwcmd rollback command, which applies the most recent rollback policy available, and then deletes that rollback policy.
ms.topic: reference
ms.assetid: 4fd9f89b-0420-420a-ad20-4a328636b1e7
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# scwcmd rollback

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2012 R2 and Windows Server 2012

Applies the most recent rollback policy available, and then deletes that rollback policy.

## Syntax

```
scwcmd rollback /m:<computername> [/u:<username>] [/pw:<password>]
```

### Parameters

| Parameter | Description |
|--|--|
| /m:`<computername>` | Specifies the NetBIOS name, DNS name, or IP address of a computer where the rollback operation should be performed. |
| /u:`<username>` | Specifies an alternate user account to use when performing a remote rollback. The default is the logged on user. |
| /pw:`<password>` | Specifies an alternate user credential to use when performing a remote rollback. The default is the logged on user. |
| /? | Displays help at the command prompt. |

## Examples

To roll back the security policy on a computer at IP address *172.16.0.0*, type:

```
scwcmd rollback /m:172.16.0.0
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [scwcmd analyze command](scwcmd-analyze.md)

- [scwcmd configure command](scwcmd-configure.md)

- [scwcmd register command](scwcmd-register.md)

- [scwcmd transform command](scwcmd-transform.md)

- [scwcmd view command](scwcmd-view.md)
