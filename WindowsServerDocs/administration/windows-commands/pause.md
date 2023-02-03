---
title: pause
description: Reference article for the pause command, which suspends the processing of batch programs.
ms.topic: reference
ms.assetid: cab3afc3-d046-432f-a0bf-6282f0099032
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# pause

Suspends the processing of a batch program, displaying the prompt, `Press any key to continue . . .`

## Syntax

```
pause
```

### Parameters

| Parameter | Description |
|--|--|
| /? | Displays help at the command prompt. |

## Remarks

- If you press CTRL+C to stop a batch program, the following message appears, `Terminate batch job (Y/N)?`. If you press **Y** (for yes) in response to this message, the batch program ends and control returns to the operating system.

- You can insert the **pause** command before a section of the batch file that you might not want to process. When **pause** suspends processing of the batch program, you can press CTRL+C and then press **Y** to stop the batch program.

## Examples

To create a batch program that prompts the user to change disks in one of the drives, type:

```
@echo off
:Begin
copy a:*.*
echo Put a new disk into Drive A
pause
goto begin
```

In this example, all the files on the disk in Drive A are copied to the current directory. After the message prompts you to put a new disk in Drive A, the **pause** command suspends processing so that you can change disks and then press any key to resume processing. This batch program runs in an endless loop—the **goto begin** command sends the command interpreter to the Begin label of the batch file.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)