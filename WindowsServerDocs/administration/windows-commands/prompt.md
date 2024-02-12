---
title: prompt
description: Reference article for the prompt command, which customizes your Cmd.exe command prompt.
ms.topic: reference
ms.assetid: 3d98e965-02eb-46ad-9d0a-5dc44830373e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 07/11/2018
---

# prompt

Changes the Cmd.exe command prompt, including displaying any text you want, such as the name of the current directory, the time and date, or the Microsoft Windows version number. If used without parameters, this command resets the command prompt to the default setting, which is the current drive letter and directory followed by the greater than symbol (**>**).

## Syntax

```
prompt [<text>]
```

### Parameters

| Parameter | Description |
|--|--|
| `<text>` | Specifies the text and information that you want to include in the command prompt. |
| /? | Displays help at the command prompt. |

#### Remarks

- The character combinations you can include instead of, or in addition to, one or more character strings in the *text* parameter:

    | Character | Description |
    |--|--|
    | $q | = (Equal sign) |
    | $$ | $ (Dollar sign) |
    | $t | Current time |
    | $d | Current date |
    | $p | Current drive and path |
    | $v | Windows version number |
    | $n | Current drive |
    | $g | > (Greater than sign) |
    | $l | < (Less than sign) |
    | $b | `|` (Pipe symbol) |
    | $_ | ENTER-LINEFEED |
    | $e | ANSI escape code (code 27) |
    | $h | Backspace (to delete a character that has been written to the command line) |
    | $a | & (Ampersand) |
    | $c | ( (Left parenthesis) |
    | $f | ) (Right parenthesis) |
    | $s | Space |

- When command extensions are enabled the **prompt** command supports the following formatting characters:

    | Character | Description |
    |--|--|
    | $+ | Zero or more plus sign (**+**) characters, depending on the depth of the **pushd** directory stack (one character for each level pushed). |
    | $m | The remote name associated with the current drive letter or the empty string if current drive is not a network drive. |

- If you include the **$p** character in the text parameter, your disk is read after you enter each command (to determine the current drive and path). This can take extra time, especially for floppy disk drives.

### Examples

To set a two-line command prompt with the current time and date on the first line and the greater than sign on the next line, type:

```
prompt $d$s$s$t$_$g
```

The prompt is changed as follows, where the date and time are current:

```
Fri 06/01/2007  13:53:28.91
```

To set the command prompt to display as an arrow (`-->`), type:

```
prompt --$g
```

To manually change the command prompt to the default setting (the current drive and path followed by the greater than sign), type:

```
prompt $p$g
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
