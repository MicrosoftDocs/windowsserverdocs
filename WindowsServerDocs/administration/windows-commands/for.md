---
title: for
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e275726c-035f-4a74-8062-013c37f5ded1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# for



Runs a specified command for each file in a set of files.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
for {%%|%}<Variable> in (<Set>) do <Command> [<CommandLineOptions>]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|{%%\|%}\<Variable>|Required. Represents a replaceable parameter. Use a single percent sign (**%**) to carry out the **for** command at the command prompt. Use double percent signs (**%%**) to carry out the **for** command within a batch file. Variables are case sensitive, and they must be represented with an alphabetical value such as **%A**, **%B**, or **%C**.|
|(\<Set>)|Required. Specifies one or more files, directories, or text strings, or a range of values on which to run the command. The parentheses are required.|
|\<Command>|Required. Specifies the command that you want to carry out on each file, directory, or text string, or on the range of values included in *Set*.|
|\<CommandLineOptions>|Specifies any command-line options that you want to use with the specified command.|
|/?|Displays help at the command prompt.|

## Remarks

- Using **for**

  You can use the **for** command within a batch file or directly from the command prompt.
- Using batch parameters

  The following attributes apply to the **for** command:  
  - The **for** command replaces **%**<em>Variable</em> or **%%**<em>Variable</em> with each text string in the specified set until the specified command processes all of the files.
  - Variable names are case sensitive, global, and no more than 52 can be active at a time.
  - To avoid confusion with the batch parameters **%0** through **%9**, you can use any character for *Variable* except the numerals 0 through 9. For simple batch files, a single character such as **%%f** will work.
  - You can use multiple values for *Variable* in complex batch files to distinguish different replaceable variables.
- Specifying a group of files

  The *Set* parameter can represent a single group of files or several groups of files. You can use wildcard characters (**&#42;** and **?**) to specify a file set. The following are valid file sets:  
  ```
  (*.doc) 
  (*.doc *.txt *.me)
  (jan*.doc jan*.rpt feb*.doc feb*.rpt)
  (ar??1991.* ap??1991.*)
  ```  
  When you use the **for** command, the first value in *Set* replaces **%**<em>Variable</em> or **%%**<em>Variable</em>, and then the specified command processes this value. This continues until all of the files (or groups of files) that correspond to the *Set* value are processed.
- Using the **in** and **do** keywords

  **In** and **do** are not parameters, but you must use them with **for**. If you omit either of these keywords, an error message appears.
- Using additional forms of **for**

  If command extensions are enabled (that is the default), the following additional forms of **for** are supported:  
  - Directories only

    If *Set* contains wildcard characters (**&#42;** or **?**), the specified *Command* executes for each directory (instead of a set of files in a specified directory) that matches *Set*.

    The syntax is:  
    ```
    for /d {%%|%}<Variable> in (<Set>) do <Command> [<CommandLineOptions>] 
    ```  
  - Recursive

    Walks the directory tree that is rooted at *Drive*:*Path* and executes the **for** statement in each directory of the tree. If no directory is specified after **/r**, the current directory is used as the root directory. If *Set* is just a single period (.), it only enumerates the directory tree.

    The syntax is:  
    ```
    for /r [[<Drive>:]<Path>] {%%|%}<Variable> in (<Set>) do <Command> [<CommandLineOptions>]
    ```  
  - Iterating a range of values

    Use an iterative variable to set the starting value (*Start*#) and then step through a set range of values until the value exceeds the set ending value (*End*#). **/l** will execute the iterative by comparing *Start*# with *End*#. If *Start*# is less than *End*# the command will execute. When the iterative variable exceeds *End*#, the command shell exits the loop. You can also use a negative *Step*# to step through a range in decreasing values. For example, (1,1,5) generates the sequence 1 2 3 4 5 and (5,-1,1) generates the sequence 5 4 3 2 1.

    The syntax is:  
    ```
    for /l {%%|%}<Variable> in (<Start#>,<Step#>,<End#>) do <Command> [<CommandLineOptions>]
    ```  
  - Iterating and file parsing

    Use file parsing to process command output, strings, and file content.  Use iterative variables to define the content or strings that you want to examine, and use the various *ParsingKeywords* options to further modify the parsing.  Use the *ParsingKeywords* token option to specify which tokens should be passed as iterative variables. Note that when used without the token option, **/f** will only examine the first token.

    File parsing consists of reading the output, string, or file content, and then breaking it into individual lines of text and parsing each line into zero or more tokens. The **for** loop is then called with the iterative variable value set to the token. By default, **/f** passes the first blank separated token from each line of each file. Blank lines are skipped.

    The syntaxes are:  
    ```
    for /f ["<ParsingKeywords>"] {%%|%}<Variable> in (<Set>) do <Command> [<CommandLineOptions>]
    for /f ["<ParsingKeywords>"] {%%|%}<Variable> in ("<LiteralString>") do <Command> [<CommandLineOptions>]
    for /f ["<ParsingKeywords>"] {%%|%}<Variable> in ('<Command>') do <Command> [<CommandLineOptions>]
    ```  
    The *Set* argument specifies one or more file names. Each file is opened, read, and processed before moving to the next file in *Set*. To override the default parsing behavior, specify *ParsingKeywords*. This is a quoted string that contains one or more keywords to specify different parsing options.

    If you use the **usebackq** option, use one of the following syntaxes:  
    ```
    for /f ["usebackq <ParsingKeywords>"] {%%|%}<Variable> in ("<Set>") do <Command> [<CommandLineOptions>]
    for /f ["usebackq <ParsingKeywords>"] {%%|%}<Variable> in ('<LiteralString>') do <Command> [<CommandLineOptions>]
    for /f ["usebackq <ParsingKeywords>"] {%%|%}<Variable> in (`<Command>`) do <Command> [<CommandLineOptions>]
    ```  
    The following table lists the parsing keywords that you can use for *ParsingKeywords*.  

    |      Keyword      |                                                                                                                                                                                                          Description                                                                                                                                                                                                          |
    |-------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    |     eol=\<c>      |                                                                                                                                                                                   Specifies an end of line character (just one character).                                                                                                                                                                                    |
    |     skip=\<N>     |                                                                                                                                                                              Specifies the number of lines to skip at the beginning of the file.                                                                                                                                                                              |
    |   delims=\<xxx>   |                                                                                                                                                                     Specifies a delimiter set. This replaces the default delimiter set of space and tab.                                                                                                                                                                      |
    | tokens=\<X,Y,M–N> | Specifies which tokens from each line are to be passed to the **for** loop for each iteration. As a result, additional variable names are allocated. *M*–*N* specifies a range, from the *M*th through the *N*th tokens. If the last character in the **tokens=** string is an asterisk (**&#42;**), an additional variable is allocated, and it receives the remaining text on the line after the last token that is parsed. |
    |     usebackq      |                                                                                             Specifies to:  execute a back-quoted string as a command, use a single-quoted string as a literal string, or, for long file names that contain spaces, allow file names in *\<Set\>*, to each be enclosed in double-quotation marks.                                                                                              |


  - Variable substitution

    The following table lists optional syntax (for any variable **I**).  

    |Variable with modifier|Description|
    |----------------------|-----------|
    |%~I|Expands **%I** which removes any surrounding quotation marks (" ").|
    |%~fI|Expands **%I** to a fully qualified path name.|
    |%~dI|Expands **%I** to a drive letter only.|
    |%~pI|Expands **%I** to a path only.|
    |%~nI|Expands **%I** to a file name only.|
    |%~xI|Expands **%I** to a file name extension only.|
    |%~sI|Expands path to contain short names only.|
    |%~aI|Expands **%I** to the file attributes of file.|
    |%~tI|Expands **%I** to the date and time of file.|
    |%~zI|Expands **%I** to the size of the file.|
    |%~$PATH:I|Searches the directories listed in the PATH environment variable and expands **%I** to the fully qualified name of the first directory found. If the environment variable name is not defined or the file is not found by the search, this modifier expands to the empty string.|

    The following table lists modifier combinations that you can use to get compound results.  

    |Variable with combined modifiers|Description|
    |--------------------------------|-----------|
    |%~dpI|Expands **%I** to a drive letter and path only.|
    |%~nxI|Expands **%I** to a file name and extension only.|
    |%~fsI|Expands **%I** to a full path name with short names only.|
    |%~dp$PATH:I|Searches the directories that are listed in the PATH environment variable for **%I** and expands to the drive letter and path of the first one found.|
    |%~ftzaI|Expands **%I** to an output line that is like **dir**.|

    In the above examples, you can replace **%I** and PATH with other valid values. A valid **for** variable name terminates the **%~** syntax.

    By using uppercase variable names such as **%I**, you can make your code more readable and avoid confusion with the modifiers, which are not case sensitive.
- Parsing a string

  You can use the **for /f** parsing logic on an immediate string by wrapping *\<LiteralString\>* in either: double quotes (*without* "usebackq") or in single quotes (*with* "usebackq") --for example, ("MyString") or ('MyString'). *\<LiteralString\>* is treated as a single line of input from a file. When parsing *\<LiteralString\>* in double-quotes, command symbols (such as **\\ \& \| \> \< \^**) are treated as ordinary characters.
- Parsing output

  You can use the **for /f** command to parse the output of a command by placing a back-quoted *\<command\>* between the parentheses. It is treated as a command line, which is passed to a child Cmd.exe. The output is captured into memory and parsed as if it is a file.

## <a name="BKMK_examples"></a>Examples

To use **for** in a batch file, use the following syntax:
```
for {%%|%}<Variable> in (<Set>) do <Command> [<CommandLineOptions>]
```
To display the contents of all the files in the current directory that have the extension .doc or .txt by using the replaceable variable **%f**, type:
```
for %f in (*.doc *.txt) do type %f 
```
In the preceding example, each file that has the .doc or .txt extension in the current directory is substituted for the **%f** variable until the contents of every file are displayed. To use this command in a batch file, replace every occurrence of **%f** with **%%f**. Otherwise, the variable is ignored and an error message is displayed.

To parse a file, ignoring commented lines, type:
```
for /f "eol=; tokens=2,3* delims=," %i in (myfile.txt) do @echo %i %j %k
```
This command parses each line in Myfile.txt. It ignores lines that begin with a semicolon and passes the second and third token from each line to the **for** body (tokens are delimited by commas or spaces). The body of the **for** statement references **%i** to get the second token, **%j** to get the third token, and **%k** to get all of the remaining tokens. If the file names that you supply contain spaces, use quotation marks around the text (for example, "File Name"). To use quotation marks, you must use **usebackq**. Otherwise, the quotation marks are interpreted as defining a literal string to parse.

**%i** is explicitly declared in the **for** statement. **%j** and **%k** are implicitly declared by using **tokens=**. You can use **tokens=** to specify up to 26 tokens, provided that it does not cause an attempt to declare a variable higher than the letter "z" or "Z."

The following example enumerates the environment variable names in the current environment. To parse the output of a command by placing *Set* between the parentheses, type:
```
for /f "usebackq delims==" %i in ('set') do @echo %i 
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
