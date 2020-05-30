---
title: Scwcmd rollback
description: Reference topic for **** -

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 4fd9f89b-0420-420a-ad20-4a328636b1e7
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# Scwcmd: rollback

> Applies to: Windows Server 2012 R2, Windows Server 2012

Applies the most recent rollback policy available, and then deletes that rollback policy.

## Syntax

```
scwcmd rollback /m:<ComputerName> [/u:<UserName>] [/pw:<Password>]
```

#### Parameters

|Parameter|Description|
|---------|-----------|
|/m:\<ComputerName>|Specifies the NetBIOS name, DNS name, or IP address of a computer where the rollback operation should be performed.|
|/u:\<UserName>|Specifies an alternate user account to use when performing a remote rollback. The default is the logged on user.|
|/pw:\<Password>|Specifies an alternate user credential to use when performing a remote rollback. The default is the logged on user.|
|/?|Displays help at the command prompt.|

## Remarks

Scwcmd.exe is only available on computers running Windows Server 2008 R2, Windows Server 2008, or Windows Server 2003.

## Examples

To roll back the security policy on a computer at IP address 172.16.0.0, type:
```
scwcmd rollback /m:172.16.0.0
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)