---
title: serverceipoptin
description: Reference article for **** -

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 3d7d7fa7-0689-4797-b802-36fe260d21a0
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# serverceipoptin

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Allows you to participate in the Customer Experience Improvement Program (CEIP).
## Syntax
```
serverceipoptin [/query] [/enable] [/disable]
```
#### Parameters
|Parameter|Description|
|-------|--------|
|/query|verifies the current setting.|
|/enable|Enables participation.|
|/disable|Disables participation.|
|/?|Displays help at the command prompt.|
## Examples
To verify the current settings, type:
```
serverceipoptin /query
```
To enable participation, type:
```
serverceipoptin /enable
```
To disable participation, type:
```
serverceipoptin /disable
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)

