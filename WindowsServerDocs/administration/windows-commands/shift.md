---
title: shift
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b56574e8-570a-4cc9-bbac-1b94fbf6a47a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# shift



Changes the position of batch parameters in a batch file.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
shift [/n <N>]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|/n \<N>|Specifies to start shifting at the *N*th argument, where *N* is any value from 0 to 8. Requires command extensions, which are enabled by default.|
|/?|Displays help at the command prompt.|

## Remarks

- The **shift** command changes the values of the batch parameters **%0** through **%9** by copying each parameter into the previous one—the value of **%1** is copied to **%0**, the value of **%2** is copied to **%1**, and so on. This is useful for writing a batch file that performs the same operation on any number of parameters.
- If command extensions are enabled, the **shift** command supports the **/n** command-line option. The **/n** option specifies to start shifting at the Nth argument, where **N** is any value from 0 to 8. For example, **SHIFT /2** would shift **%3** to **%2**, **%4** to **%3**, and so on, and leave **%0** and **%1** unaffected. Command extensions are enabled by default.
- You can use the **shift** command to create a batch file that can accept more than 10 batch parameters. If you specify more than 10 parameters on the command line, those that appear after the tenth (**%9**) will be shifted one at a time into **%9**.
- The **shift** command has no effect on the **%\\*** batch parameter.
- There is no backward **shift** command. After you implement the **shift** command, you cannot recover the batch parameter (**%0**) that existed before the shift.

## <a name="BKMK_examples"></a>Examples

The following lines from a sample batch file called Mycopy.bat demonstrate how to use **shift** with any number of batch parameters. In this example, Mycopy.bat copies a list of files to a specific directory. The batch parameters are represented by the directory and file name arguments.
```
@echo off 
rem MYCOPY.BAT copies any number of files
rem to a directory.
rem The command uses the following syntax:
rem mycopy dir file1 file2 ... 
set todir=%1
:getfile
shift
if "%1"=="" goto end
copy %1 %todir%
goto getfile
:end
set todir=
echo All done
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)