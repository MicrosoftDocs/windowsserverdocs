---
title: exec
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 364e8baf-576f-401b-a431-7d3c06621614
---
# exec
executes a file on the local computer. The file can be a **cmd** script.

## Syntax

```
exec <ScriptFile.cmd>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|<ScriptFile.cmd>|Specifies the script file to execute.|

## remarks

-   This command is used to duplicate or restore data as part of a backup or restore sequence.

-   if the script fails, an error is returned and Diskshadow quits.

#### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


