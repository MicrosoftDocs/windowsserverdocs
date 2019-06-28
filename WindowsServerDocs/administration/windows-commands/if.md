---
title: if
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 698b3fb9-532b-4c2b-af7f-179f8dc57131
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# if



Performs conditional processing in batch programs.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
if [not] ERRORLEVEL <Number> <Command> [else <Expression>]
if [not] <String1>==<String2> <Command> [else <Expression>]
if [not] exist <FileName> <Command> [else <Expression>]
```
If command extensions are enabled, use the following syntax:
```
if [/i] <String1> <CompareOp> <String2> <Command> [else <Expression>]
if cmdextversion <Number> <Command> [else <Expression>]
if defined <Variable> <Command> [else <Expression>]
```

## Parameters

|        Parameter        |                                                                                                                                                                                                                Description                                                                                                                                                                                                                 |
|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|           not           |                                                                                                                                                                              Specifies that the command should be carried out only if the condition is false.                                                                                                                                                                              |
|  errorlevel \<Number>   |                                                                                                                                                      Specifies a true condition only if the previous program run by Cmd.exe returned an exit code equal to or greater than *Number*.                                                                                                                                                       |
|       \<Command>        |                                                                                                                                                                            Specifies the command that should be carried out if the preceding condition is met.                                                                                                                                                                             |
|  \<String1>==<String2>  |                                                                                                             Specifies a true condition only if *String1* and *String2* are the same. These values can be literal strings or batch variables (for example, %1). You do not need to enclose literal strings in quotation marks.                                                                                                              |
|    exist \<FileName>    |                                                                                                                                                                                       Specifies a true condition if the specified file name exists.                                                                                                                                                                                        |
|      \<CompareOp>       |                                                                               Specifies a three-letter comparison operator. The following list represents valid values for *CompareOp*:</br>**EQU** Equal to</br>**NEQ** Not equal to</br>**LSS** Less than</br>**LEQ** Less than or equal to</br>**GTR** Greater than</br>**GEQ** Greater than or equal to                                                                                |
|           /i            |                                                            Forces string comparisons to ignore case.  You can use **/i** on the <em>String1</em>**==**<em>String2</em> form of **if**. These comparisons are generic, in that if both *String1* and *String2* are comprised of numeric digits only, the strings are converted to numbers and a numeric comparison is performed.                                                            |
| cmdextversion \<Number> | Specifies a true condition only if the internal version number associated with the command extensions feature of Cmd.exe is equal to or greater than the number specified. The first version is 1. It increases by increments of one when significant enhancements are added to the command extensions. The **cmdextversion** conditional is never true when command extensions are disabled (by default, command extensions are enabled). |
|   defined \<Variable>   |                                                                                                                                                                                            Specifies a true condition if *Variable* is defined.                                                                                                                                                                                            |
|      \<Expression>      |                                                                                                                                                                   Specifies a command-line command and any parameters to be passed to the command in an **else** clause.                                                                                                                                                                   |
|           /?            |                                                                                                                                                                                                    Displays help at the command prompt.                                                                                                                                                                                                    |

## Remarks

-   If the condition specified in an **if** clause is true, the command that follows the condition is carried out. If the condition is false, the command in the **if** clause is ignored and the command executes any command that is specified in the **else** clause.
-   When a program stops, it returns an exit code. To use exit codes as conditions, use **errorlevel**.
-   If you use **defined**, the following three variables are added to the environment: **%errorlevel%**, **%cmdcmdline%**, and **%cmdextversion%**.  
    -   **%errorlevel%** expands into a string representation of the current value of the ERRORLEVEL environment variable. This assumes that there is not an existing environment variable with the name ERRORLEVEL—if there is, you will get that ERRORLEVEL value instead.
    -   **%cmdcmdline%** expands into the original command line that was passed to Cmd.exe prior to any processing by Cmd.exe. This assumes that there is not an existing environment variable with the name CMDCMDLINE—if there is, you will get the CMDCMDLINE value instead.
    -   **%cmdextversion%** expands into the string representation of the current value of **cmdextversion**. This assumes that there is not an existing environment variable with the name CMDEXTVERSION—if there is, you will get the CMDEXTVERSION value instead.
-   You must use the **else** clause on the same line as the command after the **if**.

## <a name="BKMK_examples"></a>Examples

To display the message "Cannot find data file" if the file Product.dat cannot be found, type:
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
> To echo the value of the ERRORLEVEL environment variable after running a batch file, type the following lines in the batch file:
> ```
> goto answer%errorlevel%
> :answer1
> echo Program had return code 1
> :answer0
> echo Program had return code 0
> goto end
> :end
> echo Done! 
> ```
> To go to the "okay" label if the value of the ERRORLEVEL environment variable is less than or equal to 1, type:
> ```
> if %errorlevel% LEQ 1 goto okay
> ```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

[If](if.md)

[Goto](goto.md)