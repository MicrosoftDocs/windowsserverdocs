---
title: shift
description: Reference article for the shift command, which changes the position of batch parameters in a batch file.
ms.topic: reference
ms.assetid: b56574e8-570a-4cc9-bbac-1b94fbf6a47a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# shift

Changes the position of batch parameters in a batch file.

## Syntax

```
shift [/n <N>]
```

### Parameters

| Parameter | Description |
|--|--|
| /n `<N>` | Specifies to start shifting at the *N*th argument, where *N* is any value from *0* to *8*. Requires command extensions, which are enabled by default. |
| /? | Displays help at the command prompt. |

## Remarks

- The **shift** command changes the values of the batch parameters **%0** through **%9** by copying each parameter into the previous one—the value of **%1** is copied to **%0**, the value of **%2** is copied to **%1**, and so on. This is useful for writing a batch file that performs the same operation on any number of parameters.

- If command extensions are enabled, the **shift** command supports the **/n** command-line option. The **/n** option specifies to start shifting at the Nth argument, where **N** is any value from 0 to 8. For example, **SHIFT /2** would shift **%3** to **%2**, **%4** to **%3**, and so on, and leave **%0** and **%1** unaffected. Command extensions are enabled by default.

- You can use the **shift** command to create a batch file that can accept more than 10 batch parameters. If you specify more than 10 parameters on the command line, those that appear after the tenth (**%9**) will be shifted one at a time into **%9**.

- The **shift** command has no effect on the **%\*** batch parameter.

- There's no backward **shift** command. After you implement the **shift** command, you can't recover the batch parameter (**%0**) that existed before the shift.

## Examples

To use a batch file, called *Mycopy.bat*, to copy a list of files to a specific directory, type:

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

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
