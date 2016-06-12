---
title: Exec
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
# Exec
Executes a file on the local computer. The file can be a **cmd** script.

## Syntax

```
exec <ScriptFile.cmd>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|<ScriptFile.cmd>|Specifies the script file to execute.|

## Remarks

-   This command is used to duplicate or restore data as part of a backup or restore sequence.

-   If the script fails, an error is returned and DiskShadow quits.

#### Additional references
[Command-Line Syntax Key](../Command-Line-Syntax-Key.md)


