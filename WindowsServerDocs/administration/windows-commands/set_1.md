---
title: set
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5fdd60d6-addf-4574-8c92-8aa53fa73d76

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# set



Displays, sets, or removes CMD.EXE environment variables. If used without parameters, **set** displays the current environment variable settings.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
set [<Variable>=[<String>]]
set [/p] <Variable>=[<PromptString>]
set /a <Variable>=<Expression>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<Variable>|Specifies the environment variable to set or modify.|
|\<String>|Specifies the string to associate with the specified environment variable.|
|/p|Sets the value of *Variable* to a line of input entered by the user.|
|\<PromptString>|Optional. Specifies a message to prompt the user for input. This parameter is used with the **/p** command-line option.|
|/a|Sets *String* to a numerical expression that is evaluated.|
|\<Expression>|Specifies a numerical expression. See Remarks for valid operators that can be used in *Expression*.|
|/?|Displays help at the command prompt.|

## Remarks

- Using **set** with command extensions enabled

  When command extensions are enabled (the default) and you run **set** with a value, it displays all of the variables that begin with that value.
- Using special characters

  The characters **<**, **>**, **|**, **&**, **^** are special command shell characters, and they must be preceded by the escape character (**^**) or enclosed in quotation marks when used in *String* (for example, **"StringContaining&Symbol"**). If you use quotation marks to enclose a string that contains one of the special characters, the quotation marks are set as part of the environment variable value.
- Using environment variables

  Use environment variables to control the behavior of some batch files and programs and to control the way Windows and the MS-DOS subsystem appears and works. The **set** command is often used in the Autoexec.nt file to set environment variables.
- Displaying the current environment settings

  When you type the **set** command alone, the current environment settings are displayed. These settings usually include the COMSPEC and PATH environment variables, which are used to help find programs on disk. Two other environment variables used by Windows are PROMPT and DIRCMD.
- Using parameters

  When you specify values for *Variable* and *String*, the specified *variable* value is added to the environment and *String* is associated with that variable. If the variable already exists in the environment, the new string value replaces the old string value.

  If you specify only a variable and an equal sign (without *String*) for the **set** command, the *String* value associated with the variable is cleared (as if the variable is not there).
- Using **/a**

  The following table lists the operators supported for **/a** in descending order of precedence.  

  |        Operator         | Operation performed  |
  |-------------------------|----------------------|
  |           ( )           |       Grouping       |
  |          ! ~ -          |        Unary         |
  |         \* / %          |      Arithmetic      |
  |           + -           |      Arithmetic      |
  |          << >>          |    Logical shift     |
  |            &            |     Bitwise AND      |
  |            ^            | Bitwise exclusive OR |
  |                         |                      |
  | = \*= /= %= += -= &= ^= |      = <<= >>=       |
  |            ,            | Expression separator |

  If you use logical (**&&** or **||**) or modulus (**%**) operators, enclose the expression string in quotation marks. Any non-numeric strings in the expression are considered environment variable names, and their values are converted to numbers before they are processed. If you specify an environment variable name that is not defined in the current environment, a value of zero is allotted, which allows you to perform arithmetic with environment variable values without using the % to retrieve a value.

  If you run **set /a** from the command line outside of a command script, it displays the final value of the expression.

  Numeric values are decimal numbers unless prefixed by 0× for hexadecimal numbers or 0 for octal numbers. Therefore, 0×12 is the same as 18, which is the same as 022.
- Supporting delayed environment variable expansion

  Delayed environment variable expansion support is disabled by default, but you can enable or disable it by using **cmd /v**.
- Working with command extensions

  When command extensions are enabled (the default) and you run **set** alone, it displays all current environment variables. If you run **set** with a value, it displays the variables that match that value.
- Using **set** in batch files

  When creating batch files, you can use **set** to create variables, and then use them in the same way that you would use the numbered variables **%0** through **%9**. You can also use the variables **%0** through **%9** as input for **set**.
- Calling a **set** variable from a batch file

  When you call a variable value from a batch file, enclose the value with percent signs (**%**). For example, if your batch program creates an environment variable named BAUD, you can use the string associated with BAUD as a replaceable parameter by typing **%baud%** at the command prompt.
- Using **set** at the Recovery Console

  The **set** command, with different parameters, is available from the Recovery Console.

## <a name="BKMK_examples"></a>Examples

To set an environment variable named TEST^1, type:
```
set testVar=test^^1
```

> [!NOTE]
> The **set** command assigns everything that follows the equal sign (=) to the value of the variable. If you type:
> ```
> set testVar="test^1"
> ```
> You get the following result:
> ```
> testVar="test^1"
> ```
> To set an environment variable named TEST&1, type:
> ```
> set testVar=test^&1
> ```
> To set an environment variable named INCLUDE so that the string C:\Inc (the \Inc directory on drive C) is associated with it, type:
> ```
> set include=c:\inc
> ```
> You can then use the string C:\Inc in batch files by enclosing the name INCLUDE with percent signs (**%**). For example, you might include the following command in a batch file so that you can display the contents of the directory that is associated with the INCLUDE environment variable:
> ```
> dir %include%
> ```
> When this command is processed, the string C:\Inc replaces **%include%**.

You can also use **set** in a batch program that adds a new directory to the PATH environment variable. For example:
```
@echo off
rem ADDPATH.BAT adds a new directory
rem to the path environment variable.
set path=%1;%path%
set
```
To display a list of all of the environment variables that begin with the letter P, type:
```
set p 
```

> [!NOTE]
> This command requires command extensions, which are enabled by default.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)