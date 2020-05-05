---
title: ktmutil
description: Reference topic for **** - 

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 53bc56df-f0e5-443b-ab20-bbf8b11d4a9a

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# ktmutil



Starts the Kernel Transaction Manager utility. If used without parameters, **ktmutil** displays available subcommands.



## Syntax

```
ktmutil list tms 
ktmutil list transactions [{TmGuid}]
ktmutil resolve complete {TmGuid} {RmGuid} {EnGuid}
ktmutil resolve commit {TxGuid}
ktmutil resolve rollback {TxGuid}
ktmutil force commit {??Guid}
ktmutil force rollback {??Guid}
ktmutil forget
```

### Parameters

## Remarks

## Examples

To force an Indoubt transaction with GUID 311a9209-03f4-11dc-918f-00188b8f707b to commit, type:
```
ktmutil force commit {311a9209-03f4-11dc-918f-00188b8f707b}
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)