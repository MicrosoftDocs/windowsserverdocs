---
title: bitsadmin cache and setexpirationtime
description: "Windows Commands topic for **bitsadmin cache and setexpirationtime** - Sets the cache expiration time."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 00ea6e4e-b707-4b31-88dd-b61a78565c8d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

# bitsadmin cache and setexpirationtime
Sets the cache expiration time.
## Syntax
```
bitsadmin /Cache /SetExpirationtime secs
```
## Parameters
|Parameter|Description|
|-------|--------|
|secs|The number of seconds until the cache expires.|
## <a name="BKMK_examples"></a>Examples
The following example expires the cache in 60 seconds.
```
C:\>bitsadmin /Cache / SetExpirationtime 60
```
## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
