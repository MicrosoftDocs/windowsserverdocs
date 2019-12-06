---
title: more
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ded14f6a-d82f-4aeb-a2d8-7ec1c94dfb8f

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 07/26/2019
---

# more



Displays one screen of output at a time.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
<Command> | more [/c] [/p] [/s] [/t<N>] [+<N>]
more [[/c] [/p] [/s] [/t<N>] [+<N>]] < [<Drive>:][<Path>]<FileName>
more [/c] [/p] [/s] [/t<N>] [+<N>] [<Files>]
```

## Parameters

|           Parameter            |                               Description                               |
|--------------------------------|-------------------------------------------------------------------------|
|           \<Command>           |      Specifies a command for which you want to display the output.      |
|               /c               |               Clears the screen before displaying a page.               |
|               /p               |                      Expands form-feed characters.                      |
|               /s               |          Displays multiple blank lines as a single blank line.          |
|             /t\<N>             |         Displays tabs as the number of spaces specified by *N*.         |
|             +\<N>              |     Displays the first file beginning at the line specified by *N*.     |
| [\<Drive>:] [\<Path>]\<FileName> |          Specifies the location and name of a file to display.          |
|            \<Files>            | Specifies a list of files to display. Separate file names with a space. |
|               /?               |                  Displays help at the command prompt.                   |

## Remarks

-   The following subcommands are accepted at the **more** prompt (`-- More --`). 

    | Key | Action |
    | --- | ------ |
    | SPACEBAR | Displays the next page. |
    | ENTER | Displays the next line. |
    | f | Displays the next file. |
    | q | Quits the **more** command. |
    | = | Shows the line number. |
    | p \<N> | Displays the next *N* lines. |
    | s \<N> |S kips the next *N* lines. |
    | ? | Shows the commands that are available at the **more** prompt.| 
    
-   When using the redirection character (**<**), you must specify a file name as the source. When using the pipe (**\|**), you can use such commands as **dir**, **sort**, and **type**.
-   The **more** command, with different parameters, is available from the Recovery Console.

## <a name="BKMK_examples"></a>Examples

To view the first screen of information of a file named Clients.new, type one of the following commands:
```
more < clients.new
type clients.new | more
```
The **more** command displays the first screen of information from Clients.new, and then displays the following prompt:
```
-- More --
```
You can then press the SPACEBAR to see the next screen of information.

To clear the screen and remove all extra blank lines before displaying the file Clients.new, type one of the following commands:
```
more /c /s < clients.new
type clients.new | more /c /s
```
The **more** command displays the first screen of information from Clients.new, and then displays the following prompt:
```
-- More --
```

### Using more subcommands

The following examples can be used at the **more** prompt (`-- More --`).
- To display the file one line at a time, press ENTER at the **more** prompt.
- To display the next screen, press the SPACEBAR at the **more** prompt.
- To display the next file listed on the command line, type **f** at the **more** prompt.
- To show the available commands, type **?** at the **more** prompt.
- To quit **more**, type **q** at the **more** prompt.
- To display the current line number, type **=** at the **more** prompt. The current line number is added to the **more** prompt as follows:  
  ```
  -- More [Line: 24] --
  ```  
- To display a specific number of lines, type **p** at the **more** prompt. **More** prompts you for the number of lines to display as follows:  
  ```
  -- More -- Lines:
  ```  
  Type the number of lines to display, and then press ENTER. **More** displays the specified number of lines.
- To skip a specific number of lines, type **s** at the **more** prompt. **More** prompts you for the number of lines to skip as follows:  
  ```
  -- More -- Lines:
  ```  
  Type the number of lines to skip, and then press ENTER. **More** skips the specified number of lines and displays the next screen of information.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
