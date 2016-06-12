---
title: bitsadmin cache and info
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 15975cbf-dba6-49ca-a725-d15ce1952de5
---
# bitsadmin cache and info
Dumps a specific cache entry.

## Syntax

```
bitsadmin /Cache /Info RecordID [/verbose] 
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|RecordID|The GUID associated with the cache entry.|

## <a name="BKMK_examples"></a>Examples
The following example dumps the cache entry with the RecordID of {6511FB02\-E195\-40A2\-B595\-E8E2F8F47702}.

```
C:\>bitsadmin /Cache /Info {6511FB02-E195-40A2-B595-E8E2F8F47702} 
```

## additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)


