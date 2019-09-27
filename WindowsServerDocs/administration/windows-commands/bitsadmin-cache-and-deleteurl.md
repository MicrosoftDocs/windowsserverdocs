---
title: bitsadmin cache and deleteurl
description: "Windows Commands topic for **bitsadmin cache and deleteurl** - deletes all cache entries for the given URL."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e108b76b-fae9-4c16-bf4c-d74c9f025953
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin cache and deleteurl



Deletes all cache entries for the given URL.

## Syntax

```
bitsadmin /DeleteURL url
```

## Parameters

|Parameter|Description|
|---------|-----------|
|url|The Uniform Resource Locator that identifies a remote file.|

## <a name="BKMK_examples"></a>Examples

The following example deletes all cache entries for https://www.microsoft.com/en/us/default.aspx
```
C:\>bitsadmin /DeleteURL https://www.microsoft.com/en/us/default.aspx 
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)