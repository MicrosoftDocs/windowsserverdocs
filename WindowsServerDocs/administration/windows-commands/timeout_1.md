---
title: timeout
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e26b4a84-0e30-46e1-aa10-0667b7d3cb4c

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# timeout



Pauses the command processor for the specified number of seconds.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
timeout /t <TimeoutInSeconds> [/nobreak] 
```

## Parameters

|Parameter|Description|
|---------|-----------|
|/t \<TimeoutInSeconds>|Specifies the decimal number of seconds (between -1 and 99999) to wait before the command processor continues processing. The value -1 causes the computer to wait indefinitely for a keystroke.|
|/nobreak|Specifies to ignore user key strokes.|
|/?|Displays help at the command prompt.|

## Remarks

-   The **timeout** command is typically used in batch files.
-   A user keystroke resumes the command processor execution immediately, even if the timeout period has not expired.
-   When used in conjunction with the **sleep** command, **timeout** is similar to the **pause** command.

## <a name="BKMK_examples"></a>Examples

To pause the command processor for ten seconds, type:
```
timeout /t 10
```
To pause the command processor for 100 seconds and ignore any keystroke, type:
```
timeout /t 100 /nobreak
```
To pause the command processor indefinitely until a key is pressed, type:
```
timeout /t -1
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
