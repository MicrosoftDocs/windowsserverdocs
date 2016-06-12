---
title: bitsadmin cache and setexpirationtime
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 00ea6e4e-b707-4b31-88dd-b61a78565c8d
---
# bitsadmin cache and setexpirationtime
Sets the cache expiration time.

## Syntax

```
bitsadmin /Cache /SetExpirationtime secs
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|secs|The number of seconds until the cache expires.|

## <a name="BKMK_examples"></a>Examples
The following example expires the cache in 60 seconds.

```
C:\>bitsadmin /Cache / SetExpirationtime 60
```

## additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)


