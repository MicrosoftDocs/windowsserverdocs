---
title: doskey
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4874fd43-d5ea-45f3-ae24-388ae925ed76
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# doskey



Calls Doskey.exe (which recalls previously entered command-line commands), edits command lines, and creates macros.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
doskey [/reinstall] [/listsize=<Size>] [/macros:[all | <ExeName>] [/history] [/insert | /overstrike] [/exename=<ExeName>] [/macrofile=<FileName>] [<MacroName>=[<Text>]]
```

## Parameters

|       Parameter        |                                                                                                                          Description                                                                                                                           |
|------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|       /reinstall       |                                                                                            Installs a new copy of Doskey.exe and clears the command history buffer.                                                                                            |
|   /listsize=\<Size>    |                                                                                                Specifies the maximum number of commands in the history buffer.                                                                                                 |
|        /macros         |                                        Displays a list of all **doskey** macros. You can use the redirection symbol (**>**) with **/macros** to redirect the list to a file. You can abbreviate **/macros** to **/m**.                                         |
|      /macros:all       |                                                                                                        Displays **doskey** macros for all executables.                                                                                                         |
|   /macros:\<ExeName>   |                                                                                             Displays **doskey** macros for the executable specified by *ExeName*.                                                                                              |
|        /history        |                                    Displays all commands that are stored in memory. You can use the redirection symbol (**>**) with **/history** to redirect the list to a file. You can abbreviate **/history** as **/h**.                                    |
| /insert | Specifies that new text you type is inserted in old text. |
| /overstrike | Specifies that new text overwrites old text. |
|  /exename=\<ExeName>   |                                                                                        Specifies the program (that is, executable) in which the **doskey** macro runs.                                                                                         |
| /macrofile=\<FileName> |                                                                                              Specifies a file that contains the macros that you want to install.                                                                                               |
| \<MacroName>=[\<Text>]  | Creates a macro that carries out the commands specified by *Text*. *MacroName* specifies the name you want to assign to the macro. *Text* specifies the commands you want to record. If *Text* is left blank, *MacroName* is cleared of any assigned commands. |
|           /?           |                                                                                                              Displays help at the command prompt.                                                                                                              |

## Remarks

- Using Doskey.exe

  Doskey.exe is always available for all character-based, interactive programs (such as program debuggers or file transfer programs), and it maintains a command history buffer and macros for each program that it starts. You cannot use **doskey** command-line options from a program. You must run **doskey** command-line options before you start a program. Program key assignments override **doskey** key assignments.
- Recalling a command

  To recall a command, you can use any of the following keys after you start Doskey.exe. If you use Doskey.exe within a program, that program's key assignments take precedence.  

  |    Key     |                              Description                              |
  |------------|-----------------------------------------------------------------------|
  |  UP ARROW  |  Recalls the command that you used before the one that is displayed.  |
  | DOWN ARROW |  Recalls the command that you used after the one that is displayed.   |
  |  PAGE UP   |    Recalls the first command that you used in the current session.    |
  | PAGE DOWN  | Recalls the most recent command that you used in the current session. |


- Editing the command line

  With Doskey.exe, you can edit the current command line. If you use Doskey.exe within a program, that program's key assignments take precedence and some Doskey.exe editing keys might not work.

  The following table lists **doskey** editing keys and their functions.  

  | Key or key combination |                                                                                                                                                       Description                                                                                                                                                       |
  |------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  |       LEFT ARROW       |                                                                                                                                      Moves the insertion point back one character.                                                                                                                                      |
  |      RIGHT ARROW       |                                                                                                                                    Moves the insertion point forward one character.                                                                                                                                     |
  |    CTRL+LEFT ARROW     |                                                                                                                                        Moves the insertion point back one word.                                                                                                                                         |
  |    CTRL+RIGHT ARROW    |                                                                                                                                       Moves the insertion point forward one word.                                                                                                                                       |
  |          HOME          |                                                                                                                                 Moves the insertion point to the beginning of the line.                                                                                                                                 |
  |          END           |                                                                                                                                    Moves the insertion point to the end of the line.                                                                                                                                    |
  |          ESC           |                                                                                                                                          Clears the command from the display.                                                                                                                                           |
  |           F1           |                                                                      Copies one character from a column in the template to the same column in the Command Prompt window. (The template is a memory buffer that holds the last command you typed.)                                                                       |
  |           F2           |                                                                 Searches forward in the template for the next key that you type after you press F2. Doskey.exe inserts the text from the template—up to, but not including, the character you specify.                                                                  |
  |           F3           |                                                 Copies the remainder of the template to the command line. Doskey.exe begins copying characters from the position in the template that corresponds to the position indicated by the insertion point on the command line.                                                 |
  |           F4           |                                                                            Deletes all characters from the current insertion point position up to, but not including, the next occurrence of the character that you type after you press F4.                                                                            |
  |           F5           |                                                                                                                                   Copies the template into the current command line.                                                                                                                                    |
  |           F6           |                                                                                                                    Places an end-of-file character (CTRL+Z) at the current insertion point position.                                                                                                                    |
  |           F7           | Displays (in a dialog box) all commands for this program that are stored in memory. Use the UP ARROW key and the DOWN ARROW key to select the command you want, and press ENTER to run the command. You can also note the sequential number in front of the command and use this number in conjunction with the F9 key. |
  |         ALT+F7         |                                                                                                                          Deletes all commands stored in memory for the current history buffer.                                                                                                                          |
  |           F8           |                                                                                                           Displays all commands in the history buffer that start with the characters in the current command.                                                                                                            |
  |           F9           |                                             Prompts you for a history buffer command number, and then displays the command associated with the number that you specify. Press ENTER to run the command. To display all the numbers and their associated commands, press F7.                                             |
  |        ALT+F10         |                                                                                                                                             Deletes all macro definitions.                                                                                                                                              |


- Using **doskey** within a program

  Certain character-based, interactive programs, such as program debuggers or file transfer programs (FTP) automatically use Doskey.exe. To use Doskey.exe, a program must be a console process and use buffered input. Program key assignments override **doskey** key assignments. For example, if the program uses the F7 key for a function, you cannot get a **doskey** command history in a pop-up window.

  With Doskey.exe, you can maintain a command history for each program that you start or repeat. You can edit previous commands at the program's prompt, and start **doskey** macros created for the program. If you exit and then restart a program from the same Command Prompt window, the command history from the previous program session is available.

  You must run Doskey.exe before you start a program. You cannot use **doskey** command-line options from a program's command prompt, even if the program has a shell command.

  If you want to customize how Doskey.exe works with a program and create **doskey** macros for that program, you can create a batch program that modifies Doskey.exe and starts the program.
- Specifying a default Insert mode

  If you press the INSERT key, you can type text on the **doskey** command line in the midst of existing text without replacing the text. However, after you press ENTER, Doskey.exe returns your keyboard to Replace mode. You must press INSERT again to return to Insert mode.

  Use **/insert** to switch your keyboard to Insert mode each time you press ENTER. Your keyboard effectively remains in Insert mode until you use **/overstrike**. You can temporarily return to Replace mode by pressing the INSERT key, but after you press ENTER, Doskey.exe returns your keyboard to Insert mode.

  The insertion point changes shape when you use the INSERT key to change from one mode to the other.
- Creating a macro

  You can use Doskey.exe to create macros that carry out one or more commands. The following table lists special characters that you can use to control command operations when you define a macro.  

  |   Character   |                                                                                                                                                                               Description                                                                                                                                                                               |
  |---------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  |   $G or $g    |                                                                                   Redirects output. Use either of these special characters to send output to a device or a file instead of to the screen. This character is equivalent to the redirection symbol for output (**>**).                                                                                    |
  | $G$G or $g$g  |                                                         Appends output to the end of a file. Use either of these double characters to append output to an existing file instead of replacing the data in the file. These double characters are equivalent to the append redirection symbol for output (**>>**).                                                         |
  |   $L or $l    |                                                                                  Redirects input. Use either of these special characters to read input from a device or a file instead of from the keyboard. This character is equivalent to the redirection symbol for input (**<**).                                                                                  |
  |   $B or $b    |                                                                                                                                    Sends macro output to a command. These special characters are equivalent to using the pipe (\*\*                                                                                                                                     |
  |   $T or $t    |                                                            Separates commands. Use either of these special characters to separate commands when you create macros or type commands on the **doskey** command line. These special characters are equivalent to using the ampersand (**&**) on a command line.                                                            |
  |      $$       |                                                                                                                                                              Specifies the dollar-sign character (**$**).                                                                                                                                                               |
  | $1 through $9 |             Represent any command-line information you want to specify when you run the macro. The special characters **$1** through **$9** are batch parameters that enable you to use different data on the command line each time you run the macro. The **$1** character in a **doskey** command is similar to the **%1** character in a batch program.             |
  |      $\*      | Represents all the command-line information that you want to specify when you type the macro name. The special character **$\\**\* is a replaceable parameter that is similar to the batch parameters **$1** through **$9**, with one important difference: everything you type on the command line after the macro name is substituted for the **$\\**\* in the macro. |


- Running a **doskey** macro

  To run a macro, type the macro name at the command prompt, starting at the first position. If the macro was defined with **$\\*** or any of the batch parameters **$1** through **$9**, use a space to separate the parameters. You cannot run a **doskey** macro from a batch program.
- Creating a macro with the same name as a Windows Server 2003 family command

  If you always use a particular command with specific command-line options, you can create a macro that has the same name as the command. To specify whether you want to run the macro or the command, follow these guidelines:  
  -   To run the macro, type the macro name at the command prompt. Do not add a space before the macro name.
  -   To run the command, insert one or more spaces at the command prompt, and then type the command name.
- Deleting a macro

  To delete a macro, type:  
  ```
  doskey <MacroName> =
  ```

## <a name="BKMK_examples"></a>Examples

The **/macros** and **/history** command-line options are useful for creating batch programs to save macros and commands. For example, to store all current **doskey** macros, type:
```
doskey /macros > macinit 
```
To use the macros stored in Macinit, type:
```
doskey /macrofile=macinit 
```
To create a batch program named Tmp.bat that contains recently used commands, type:
```
doskey /history> tmp.bat 
```
To define a macro with multiple commands, use **$t** to separate commands, as follows:
```
doskey tx=cd temp$tdir/w $*
```
In the preceding example, the TX macro changes the current directory to Temp and then displays a directory listing in wide display format. You can use **$\\*** at the end of the macro to append other command-line options to **dir** when you run TX.

The following macro uses a batch parameter for a new directory name:
```
doskey mc=md $1$tcd $1
```
The macro creates a new directory and then changes to the new directory from the current directory.

To use the preceding macro to create and change to a directory named Books, type:
```
mc books
```
To create a **doskey** macro for a program called Ftp.exe, include **/exename** as follows:
```
doskey /exename=ftp.exe go=open 172.27.1.100$tmget *.TXT c:\reports$tbye 
```
To use the preceding macro, start FTP. At the FTP prompt, type:
```
go
```
FTP runs the **open**, **mget**, and **bye** commands.

To create a macro that quickly and unconditionally formats a disk, type:
```
doskey qf=format $1 /q /u
```
To quickly and unconditionally format a disk in drive A, type:
```
qf a:
```
To delete a macro called vlist, type:
```
doskey vlist =
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
