---
title: Bitsadmin cache and setlimit
description: "Windows Commands topic for **Bitsadmin cache and setlimit** - Sets the cache size limit."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 46578835-d5ce-423b-be4d-62ddb9e1908d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Bitsadmin cache and setlimit

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Sets the cache size limit.
## Syntax
```
bitsadmin /Cache /SetLimit Percent
```
## Parameters
|Parameter|Description|
|-------|--------|
|Percent|The cache limit defined as a percentage of the total hard disk space..|
## <a name="BKMK_examples"></a>Examples
The following example limits the cache size to 50%.
```
C:\>bitsadmin /Cache /SetLimit 50 
```
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
