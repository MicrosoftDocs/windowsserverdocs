---
title: set
description: Reference article for set, which displays, sets, or removes cmd.exe environment variables.
ms.topic: reference
ms.assetid: 5fdd60d6-addf-4574-8c92-8aa53fa73d76
ms.author: wscontent
author: xelu86
ms.date: 09/06/2023
---

# set (environment variable)

Displays, sets, or removes cmd.exe environment variables. If used without parameters, **set** displays the current environment variable settings.

> [!NOTE]
> This command requires command extensions, which are enabled by default.

The **set** command can also run from the Windows Recovery Console, using different parameters. For more information, see [Windows Recovery Environment (WinRE)](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference).

## Syntax

```
set [<variable>=[<string>]]
set [/p] <variable>=[<promptString>]
set /a <variable>=<expression>
```

### Parameters

| Parameter | Description |
|--|--|
| `<variable>` | Specifies the environment variable to set or modify. |
| `<string>` | Specifies the string to associate with the specified environment variable. |
| /p | Sets the value of `<variable>` to a line of input entered by the user. |
| `<promptstring>` | Specifies a message to prompt the user for input. This parameter must be used with the **/p** parameter. |
| /a | Sets `<string>` to a numerical expression that is evaluated. |
| `<expression>` | Specifies a numerical expression. |
| /? | Displays help at the command prompt. |

#### Remarks

- If command extensions are enabled (the default) and you run **set** with a value, it displays all of the variables that begin with that value.

- The characters `<`, `>`, `|`, `&`, and `^` are special command shell characters, and they must be preceded by the escape character (`^`) or enclosed in quotation marks when used in `<string>` (for example, "StringContaining&Symbol"). If you use quotation marks to enclose a string that contains one of the special characters, the quotation marks are set as part of the environment variable value.

- Use environment variables to control the behavior of some batch files and programs and to control the way Windows and the MS-DOS subsystem appears and works. The **set** command is often used in the **Autoexec.nt** file to set environment variables.

- If you use the **set** command without any parameters, the current environment settings are displayed. These settings usually include the **COMSPEC** and **PATH** environment variables, which are used to help find programs on disk. Two other environment variables used by Windows are **PROMPT** and **DIRCMD**.

- If you specify values for `<variable>` and `<string>`, the specified `<variable>` value is added to the environment and `<string>` is associated with that variable. If the variable already exists in the environment, the new string value replaces the old string value.

- If you specify only a variable and an equal sign (without `<string>`) for the **set** command, the `<string>` value associated with the variable is cleared (as if the variable isn't there).

- If you use the **/a** parameter, the following operators are supported, in descending order of precedence:

  | Operator | Operation performed |
  |--|--|
  | `( )` | Grouping |
  | `! ~ -` | Unary |
  | `* / %` | Arithmetic |
  | `+ -` | Arithmetic |
  | `<< >>` | Logical shift |
  | `&` | Bitwise AND |
  | `^` | Bitwise exclusive OR |
  | `= *= /= %= += -= &= ^=` | `= <<= >>=` |
  | `,` | Expression separator |

- If you use logical (`&&` or `||`) or modulus (**%**) operators, enclose the expression string in quotation marks. Any non-numeric strings in the expression are considered environment variable names, and their values are converted to numbers before they're processed. If you specify an environment variable name that isn't defined in the current environment, a value of zero is allotted, which allows you to perform arithmetic with environment variable values without using the % to retrieve a value.

- If you run **set /a** from the command line outside of a command script, it displays the final value of the expression.

- Numeric values are decimal numbers unless prefixed by 0× for hexadecimal numbers or 0 for octal numbers. Therefore, 0×12 is the same as 18, which is the same as 022.

- Delayed environment variable expansion support is disabled by default, but you can enable or disable it by using **cmd /v**.

- When creating batch files, you can use **set** to create variables, and then use them in the same way that you would use the numbered variables **%0** through **%9**. You can also use the variables **%0** through **%9** as input for **set**.

- If you call a variable value from a batch file, enclose the value with percent signs (**%**). For example, if your batch program creates an environment variable named *BAUD*, you can use the string associated with *BAUD* as a replaceable parameter by typing **%baud%** at the command prompt.

## Examples

To set the value *TEST^1* for the environment variable named `testVar`, type:

```
set testVar=TEST^^1
```

The **set** command assigns everything that follows the equal sign (=) to the value of the variable. Therefore, if you type `set testVar=TEST^1`, you'll get the following result, `testVar=TEST1`.

To set the value *TEST&1* for the environment variable `testVar`, type:

```
set testVar=TEST^&1
```

To set an environment variable named *include* so the string *c:\directory* is associated with it, type:

```
set include=c:\directory
```

You can then use the string *c:\directory* in batch files by enclosing the name *include* with percent signs (**%**). For example, you can use `dir %include%` in a batch file to display the contents of the directory associated with the *include* environment variable. After this command is processed, the string c:\directory replaces **%include%**.

To use the **set** command in a batch program to add a new directory to the *path* environment variable, type:

```
@echo off
rem ADDPATH.BAT adds a new directory
rem to the path environment variable.
set path=%1;%path%
set
```

To display a list of all of the environment variables that begin with the letter *p*, type:

```
set p
```

To display a list of all of the environment variables on the current device, type:

```
set
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
