---
title: ktmutil
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 53bc56df-f0e5-443b-ab20-bbf8b11d4a9a

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# ktmutil

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

starts the Kernel Transaction Manager utility. If used without parameters, **ktmutil** displays available subcommands.  
for examples of how to use this command, see [Examples](#BKMK_examples).  
## Syntax  
```  
ktmutil list tms   
ktmutil list transactions [{TmGuid}]  
ktmutil resolve complete {TmGuid} {RmGuid} {EnGuid}  
ktmutil resolve commit {TxGuid}  
ktmutil resolve rollback {TxGuid}  
ktmutil force commit { Guid}  
ktmutil force rollback { Guid}  
ktmutil forget  
```  
## Parameters  
## remarks  
## <a name="BKMK_examples"></a>Examples  
To force an Indoubt transaction with GUID 311a9209-03f4-11dc-918f-00188b8f707b to commit, type:  
```  
ktmutil force commit {311a9209-03f4-11dc-918f-00188b8f707b}  
```  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
