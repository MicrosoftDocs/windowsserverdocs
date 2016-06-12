---
title: dispdiag
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5079e1dd-b57c-44ed-970f-e6b409369e03
---
# dispdiag
Logs display information to a file.

## Syntax

```
dispdiag [-testacpi] [-d] [-delay <Seconds>] [-out <Filepath>]
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|\- testacpi|Runs hotkey diagnostics test. Displays the key name, code and scan code for any key pressed during the test.|
|\-d|Generates a dump file with test results.|
|\-delay <Seconds>|delays the collection of data by specified time in *seconds*.|
|\-out <Filepath>|Specifies path and filename to save collected data. This must be the last parameter.|
|\-?|Displays available command parameters and provides help for using them.|


