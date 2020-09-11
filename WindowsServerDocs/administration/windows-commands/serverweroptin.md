---
title: serverweroptin
description: Reference article for **** -




ms.topic: reference
ms.assetid: f3c0b0af-cafb-4f09-8b36-5a357ddf392d
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---
# serverweroptin

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Allows you to enable error reporting.
## Syntax
```
serverweroptin [/query] [/detailed] [/summary]
```
#### Parameters
|Parameter|Description|
|-------|--------|
|/query|verifies the current setting.|
|/detailed|Sends detailed reports automatically.|
|/summary|Sends summary reports automatically.|
|/?|Displays help at the command prompt.|
## Examples
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
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)

