---
title: goto
description: Reference article for the goto command, which directs cmd.exe to a labeled line in a batch program.
ms.topic: reference
ms.assetid: e0de1458-1f78-48ff-a746-c285a945a510
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# goto

Directs cmd.exe to a labeled line in a batch program. Within a batch program, this command directs command processing to a line that is identified by a label. When the label is found, processing continues starting with the commands that begin on the next line.

## Syntax

```
goto <label>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<label>` | Specifies a text string that is used as a label in the batch program. |
| /? | Displays help at the command prompt. |

#### Remarks

-  If command extensions are enabled (the default), and you use the **goto** command with a target label of **:EOF**, you transfer control to the end of the current batch script file and exit the batch script file without defining a label. When you use this command with the **:EOF** label, you must insert a colon before the label. For example: `goto:EOF`.

- You can use spaces in the *label* parameter, but you can't include other separators (for example, semicolons (;) or equal signs (=)).

- The *label* value that you specify must match a label in the batch program. The label within the batch program must begin with a colon (:). If a line begins with a colon, it's treated as a label and any commands on that line are ignored. If your batch program doesn't contain the label that you specify in the *label* parameter, then the batch program stops and displays the following message: `Label not found`.

- You can use **goto** with other commands to perform conditional operations. For more information about using **goto** for conditional operations, see the [if command](if.md).

## Examples

The following batch program formats a disk in drive A as a system disk. If the operation is successful, the **goto** command directs processing to the **:end** label:

```
echo off
format a: /s
if not errorlevel 1 goto end
echo An error occurred during formatting.
:end
echo End of batch program.
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [cmd command](cmd.md)

- [if command](if.md)