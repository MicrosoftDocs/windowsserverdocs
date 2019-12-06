---
title: serverweroptin
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f3c0b0af-cafb-4f09-8b36-5a357ddf392d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# serverweroptin

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Allows you to enable error reporting.
## Syntax
```
serverweroptin [/query] [/detailed] [/summary]
```
### Parameters
|Parameter|Description|
|-------|--------|
|/query|verifies the current setting.|
|/detailed|Sends detailed reports automatically.|
|/summary|Sends summary reports automatically.|
|/?|Displays help at the command prompt.|
## <a name="BKMK_Examples"></a>Examples
To verify the current setting, type:
```
serverweroptin /query
```
To automatically send detailed reports, type:
```
serverweroptin /detailed
```
To automatically send summary reports, type
```
serverweroptin /summary
```
## additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)

