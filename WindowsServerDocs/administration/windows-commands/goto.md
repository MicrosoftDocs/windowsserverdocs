---
title: goto
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e0de1458-1f78-48ff-a746-c285a945a510
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# goto



Directs cmd.exe to a labeled line in a batch program. Within a batch program, **goto** directs command processing to a line that is identified by a label. When the label is found, processing continues starting with the commands that begin on the next line.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
goto <Label> 
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<Label>|Specifies a text string that is used as a label in the batch program.|
|/?|Displays help at the command prompt.|

## Remarks

-   Working with command extensions

    If command extensions are enabled (the default), and you use the **goto** command with a target label of **:EOF**, you transfer control to the end of the current batch script file and exit the batch script file without defining a label. When you use **goto** with the **:EOF** label, you must insert a colon before the label. For example:  
    ```
    goto:EOF
    ```  
-   Using valid *Label* values

    You can use spaces in the *Label* parameter, but you cannot include other separators (for example, semicolons or equal signs).
-   Matching *Label* with the label in the batch program

    The *Label* value that you specify must match a label in the batch program. The label within the batch program must begin with a colon (:). If a line begins with a colon, it is treated as a label and any commands on that line are ignored. If your batch program does not contain the label that you specify in *Label*, the batch program stops and displays the following message:  
    ```
    Label not found
    ```  
-   Using **goto** for conditional operations

    You can use **goto** with other commands to perform conditional operations. For more information about using **goto** for conditional operations, see the [If](if.md) command reference.

## <a name="BKMK_examples"></a>Examples

The following batch program formats a disk in drive A as a system disk. If the operation is successful, the **goto** command directs processing to the **:end** label:
```
echo off
format a: /s
if not errorlevel 1 goto end
echo An error occurred during formatting.
:end
echo End of batch program. 
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

[Cmd](cmd.md)

[If](if.md)