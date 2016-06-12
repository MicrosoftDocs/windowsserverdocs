---
title: goto
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e0de1458-1f78-48ff-a746-c285a945a510
---
# goto
directs cmd.exe to a labeled line in a batch program. Within a batch program, **goto** directs command processing to a line that is identified by a label. When the label is found, processing continues starting with the commands that begin on the next line.

for examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
goto <label> 
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|<label>|Specifies a text string that is used as a label in the batch program.|
|\/?|Displays help at the command prompt.|

## remarks

-   Working with command extensions

    if command extensions are enabled \(the default\), and you use the **goto** command with a target label of **:EOF**, you transfer control to the end of the current batch script file and exit the batch script file without defining a label. When you use **goto** with the **:EOF** label, you must insert a colon before the label. for example:

    ```
    goto:EOF
    ```

-   Using valid *label* values

    You can use spaces in the *label* parameter, but you cannot include other separators \(for example, semicolons or equal signs\).

-   Matching *label* with the label in the batch program

    The *label* value that you specify must match a label in the batch program. The label within the batch program must begin with a colon \(:\). if a line begins with a colon, it is treated as a label and any commands on that line are ignored. if your batch program does not contain the label that you specify in *label*, the batch program stops and displays the following message:

    ```
    label not found
    ```

-   Using **goto** for conditional operations

    You can use **goto** with other commands to perform conditional operations. for more information about using **goto** for conditional operations, see the [if](if.md) command reference.

## <a name="BKMK_examples"></a>Examples
The following batch program formats a disk in drive A as a system disk. if the operation is successful, the **goto** command directs processing to the **:end** label:

```
echo off
format a: /s
if not errorlevel 1 goto end
echo An error occurred during formatting.
:end
echo End of batch program. 
```

#### additional references
[Command-Line Syntax Key](commandline-syntax-key.md)

[cmd](cmd.md)

[if](if.md)


