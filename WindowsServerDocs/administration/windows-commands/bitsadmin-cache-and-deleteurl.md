---
title: bitsadmin cache and deleteurl
description: "Windows Commands topic for **bitsadmin cache and deleteurl** - deletes all cache entries for the given URL."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e108b76b-fae9-4c16-bf4c-d74c9f025953
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# bitsadmin cache and deleteurl

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

deletes all cache entries for the given URL.
## Syntax
```
bitsadmin /deleteURL url
```
## Parameters
|Parameter|Description|
|-------|--------|
|url|The Uniform Resource Locator that identifies a remote file.|
## <a name="BKMK_examples"></a>Examples
The following example deletes all cache entries for http://www.microsoft.com/en/us/default.aspx
```
C:\>bitsadmin /deleteURL http://www.microsoft.com/en/us/default.aspx 
```
## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
