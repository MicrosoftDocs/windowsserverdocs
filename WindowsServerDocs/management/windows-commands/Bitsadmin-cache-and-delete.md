---
title: Bitsadmin cache and delete
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 22540273-55a5-46ea-869b-6df2aa6808a1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Bitsadmin cache and delete
Deletes a specific cache entry.
## Syntax
```
bitsadmin /Cache /Delete RecordID 
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|RecordID|The GUID associated with the cache entry.|
## <a name="BKMK_examples"></a>Examples
The following example deletes the cache entry with the RecordID of {6511FB02-E195-40A2-B595-E8E2F8F47702}.
```
C:\>bitsadmin /Cache /Delete {6511FB02-E195-40A2-B595-E8E2F8F47702} 
```
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
