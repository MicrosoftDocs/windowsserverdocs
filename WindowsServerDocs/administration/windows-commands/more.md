---
title: more
description: Reference article for the more command, which displays one screen of output at a time.
ms.topic: reference
ms.assetid: ded14f6a-d82f-4aeb-a2d8-7ec1c94dfb8f
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 07/26/2019
---

# more

Displays one screen of output at a time.

> [!NOTE]
> The **more** command, with different parameters, is also available from the Recovery Console.

## Syntax

```
<command> | more [/c] [/p] [/s] [/t<n>] [+<n>]
more [[/c] [/p] [/s] [/t<n>] [+<n>]] < [<drive>:][<path>]<filename>
more [/c] [/p] [/s] [/t<n>] [+<n>] [<files>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<command>` | Specifies a command for which you want to display the output. |
| /c | Clears the screen before displaying a page. |
| /p | Expands form-feed characters. |
| /s | Displays multiple blank lines as a single blank line. |
| /t`<n>` | Displays tabs as the number of spaces specified by *n*. |
| +`<n>` | Displays the first file, beginning at the line specified by *n*. |
| `[<drive>:][<path>]<filename>` | Specifies the location and name of a file to display. |
| `<files>` | Specifies a list of files to display. Files must be separated using spaces. |
| /? | Displays help at the command prompt. |

#### Remarks

- The following subcommands are accepted at the **more** prompt (`-- More --`), including:

    | Key | Action |
    | --- | ------ |
    | SPACEBAR | Press the **SPACEBAR** to display the next screen. |
    | ENTER | Press **ENTER** to display the file one line at a time. |
    | f | Press **F** to display the next file listed on the command line. |
    | q | Press **Q** to quit the **more** command. |
    | = | Shows the line number. |
    | p `<n>` | Press **P** to display the next *n* lines. |
    | s `<n>` | Press **S** to skip the next *n* lines. |
    | ? | Press **?** to show the commands that are available at the **more** prompt.|

- If you use the redirection character (`<`), you must also specify a file name as the source.

- If you use the pipe (`|`), you can use such commands as **dir**, **sort**, and **type**.

### Examples

To view the first screen of information of a file named *Clients.new*, type one of the following commands:

```
more < clients.new
type clients.new | more
```

The **more** command displays the first screen of information from Clients.new, and you can press the SPACEBAR to see the next screen of information.

To clear the screen and remove all extra blank lines before displaying the file *Clients.new*, type one of the following commands:

```
more /c /s < clients.new
type clients.new | more /c /s
```

To display the current line number at the **more** prompt, type:

```
more =
```

The current line number is added to the **more** prompt, as `-- More [Line: 24] --`

To display a specific number of lines at the **more** prompt, type:

```
more p
```

The **more** prompt asks you for the number of lines to display, as follows: `-- More -- Lines:`. Type the number of lines to display, and then press ENTER. The screen changes to show only that number of lines.

To skip a specific number of lines at the **more** prompt, type:

```
more s
```

The **more** prompt asks you for the number of lines to skip, as follows: `-- More -- Lines:`. Type the number of lines to skip, and then press ENTER. The screen changes to show that those lines are skipped.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Windows Recovery Environment (WinRE)](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference)
