---
title: Serverweroptin
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f3c0b0af-cafb-4f09-8b36-5a357ddf392d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Serverweroptin

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Allows you to enable error reporting.
## Syntax
```
serverweroptin [/query] [/detailed] [/summary]
```
### Parameters
|Parameter|Description|
|-------|--------|
|/query|Verifies the current setting.|
|/detailed|Sends detailed reports automatically.|
|/summary|Sends summary reports automatically.|
|/?|Displays Help at the command prompt.|
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
## Additional references
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)
-   [Command-Line Reference_1](Command-Line-Reference_1.md)
