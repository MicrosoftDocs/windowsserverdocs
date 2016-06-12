---
title: bitsadmin cache and delete
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 22540273-55a5-46ea-869b-6df2aa6808a1
---
# bitsadmin cache and delete
deletes a specific cache entry.

## Syntax

```
bitsadmin /Cache /delete RecordID 
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|RecordID|The GUID associated with the cache entry.|

## <a name="BKMK_examples"></a>Examples
The following example deletes the cache entry with the RecordID of {6511FB02\-E195\-40A2\-B595\-E8E2F8F47702}.

```
C:\>bitsadmin /Cache /delete {6511FB02-E195-40A2-B595-E8E2F8F47702} 
```

## additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)


