---
title: if
description: Reference article for the if command, which performs conditional processing in batch programs.
ms.topic: reference
ms.assetid: 698b3fb9-532b-4c2b-af7f-179f8dc57131
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# if

Performs conditional processing in batch programs.

## Syntax

```
if [not] ERRORLEVEL <number> <command> [else <expression>]
if [not] <string1>==<string2> <command> [else <expression>]
if [not] exist <filename> <command> [else <expression>]
```

If command extensions are enabled, use the following syntax:

```
if [/i] <string1> <compareop> <string2> <command> [else <expression>]
if cmdextversion <number> <command> [else <expression>]
if defined <variable> <command> [else <expression>]
```

### Parameters

| Parameter | Description |
| --------- |------------ |
| not | Specifies that the command should be carried out only if the condition is false. |
| errorlevel `<number>` | Specifies a true condition only if the previous program run by Cmd.exe returned an exit code equal to or greater than *number*. |
| `<command>` | Specifies the command that should be carried out if the preceding condition is met. |
| `<string1>==<string2>` | Specifies a true condition only if *string1* and *string2* are the same. These values can be literal strings or batch variables (for example, `%1`). You do not need to enclose literal strings in quotation marks. |
| exist `<filename>` | Specifies a true condition if the specified file name exists. |
| `<compareop>` | Specifies a three-letter comparison operator, including:<ul><li>**EQU** - Equal to</li><li>**NEQ** - Not equal to</li><li>**LSS** - Less than</li><li>**LEQ** - Less than or equal to</li><li>**GTR** - Greater than</li><li>**GEQ** - Greater than or equal to</li></ul> |
| /i | Forces string comparisons to ignore case. You can use **/i** on the `string1==string2` form of **if**. These comparisons are generic, in that if both *string1* and *string2* are comprised of numeric digits only, the strings are converted to numbers and a numeric comparison is performed. |
| cmdextversion `<number>` | Specifies a true condition only if the internal version number associated with the command extensions feature of Cmd.exe is equal to or greater than the number specified. The first version is 1. It increases by increments of one when significant enhancements are added to the command extensions. The **cmdextversion** conditional is never true when command extensions are disabled (by default, command extensions are enabled). |
| defined `<variable>` | Specifies a true condition if *variable* is defined. |
| `<expression>` | Specifies a command-line command and any parameters to be passed to the command in an **else** clause. |
| /? | Displays help at the command prompt. |

#### Remarks

- If the condition specified in an **if** clause is true, the command that follows the condition is carried out. If the condition is false, the command in the **if** clause is ignored and the command executes any command that is specified in the **else** clause.

- When a program stops, it returns an exit code. To use exit codes as conditions, use the **errorlevel** parameter.

- If you use **defined**, the following three variables are added to the environment: **%errorlevel%**, **%cmdcmdline%**, and **%cmdextversion%**.

  - **%errorlevel%**: Expands into a string representation of the current value of the ERRORLEVEL environment variable. This variable assumes that there isn't already an existing environment variable with the name ERRORLEVEL. If there is, you'll get that ERRORLEVEL value instead.

  - **%cmdcmdline%**: Expands into the original command line that was passed to Cmd.exe prior to any processing by Cmd.exe. This assumes that there isn't already an existing environment variable with the name CMDCMDLINE. If there is, you'll get that CMDCMDLINE value instead.

  - **%cmdextversion%**: Expands into the string representation of the current value of **cmdextversion**. This assumes that there isn't already an existing environment variable with the name CMDEXTVERSION. If there is, you'll get that CMDEXTVERSION value instead.

- You must use the **else** clause on the same line as the command after the **if**.

### Examples

To display the message **Cannot find data file if the file Product.dat cannot be found**, type:

```
if not exist product.dat echo Cannot find data file
```

To format a disk in drive A and display an error message if an error occurs during the formatting process, type the following lines in a batch file:

```
:begin
@echo off
format a: /s
if not errorlevel 1 goto end
echo An error occurred during formatting.
:end
echo End of batch program.
```

To delete the file Product.dat from the current directory or display a message if Product.dat is not found, type the following lines in a batch file:

```
IF EXIST Product.dat (
del Product.dat
) ELSE (
echo The Product.dat file is missing.
)
```

> [!NOTE]
> These lines can be combined into a single line as follows:
> ```
> IF EXIST Product.dat (del Product.dat) ELSE (echo The Product.dat file is missing.)
> ```

To echo the value of the ERRORLEVEL environment variable after running a batch file, type the following lines in the batch file:

```
goto answer%errorlevel%
:answer1
echo The program returned error level 1
goto end
:answer0
echo The program returned error level 0
goto end
:end
echo Done!
```

To go to the okay label if the value of the ERRORLEVEL environment variable is less than or equal to 1, type:

```
if %errorlevel% LEQ 1 goto okay
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [goto command](goto.md)
