---
title: pause
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cab3afc3-d046-432f-a0bf-6282f0099032
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# pause



Suspends the processing of a batch program and displays the following prompt:
```
Press any key to continue . . .
```
For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
pause
```

## Parameters

|Parameter|Description|
|---------|-----------|
|/?|Displays help at the command prompt.|

## Remarks

- When you run the **pause** command, the following message appears:  
  ```
  Press any key to continue . . .
  ```  
- If you press CTRL+C to stop a batch program, the following message appears:  
  ```
  Terminate batch job (Y/N)?
  ```  
  If you press Y (for yes) in response to this message, the batch program ends and control returns to the operating system.
- You can insert the **pause** command before a section of the batch file that you might not want to process. When **pause** suspends processing of the batch program, you can press CTRL+C and then press Y to stop the batch program.

## <a name="BKMK_examples"></a>Examples

To create a batch program that prompts the user to change disks in one of the drives, type:
```
@echo off 
:Begin 
copy a:*.* 
echo Put a new disk into drive A 
pause 
goto begin
```
In this example, all the files on the disk in drive A are copied to the current directory. After the message prompts you to put a new disk in drive A, the **pause** command suspends processing so that you can change disks and then press any key to resume processing. This batch program runs in an endless loop—the **goto begin** command sends the command interpreter to the Begin label of the batch file. To stop this batch program, press CTRL+C and then press Y.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)