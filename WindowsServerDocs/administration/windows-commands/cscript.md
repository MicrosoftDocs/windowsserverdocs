---
title: cscript
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fba3cbca-594e-4663-bb22-4ee0f63a1ac6
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# cscript

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

starts a script so that it runs in a command-line environment.
## Syntax
```
cscript <Scriptname.extension> [/B] [/D] [/E:<Engine>] [{/H:cscript|/H:wscript}] [/I] [/Job:<Identifier>] [{/Logo|/NoLogo}] [/S] [/T:<Seconds>] [/X] [/U] [/?] [<ScriptArguments>]
```
### Parameters

|      Parameter       |                                                                      Description                                                                       |
|----------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| Scriptname.extension |                                 Specifies the path and file name of the script file with optional file name extension.                                 |
|          /B          |                                Specifies batch mode, which does not display alerts, scripting errors, or input prompts.                                |
|          /D          |                                                                  Starts the debugger.                                                                  |
|     /E:<Engine>      |                                                  Specifies the engine that is used to run the script.                                                  |
|      /H:cscript      |                                         Registers cscript.exe as the default script host for running scripts.                                          |
|      /H:wscript      |                               Registers wscript.exe as the default script host for running scripts. This is the default.                               |
|          /I          |        Specifies interactive mode, which displays alerts, scripting errors, and input prompts. This is the default and the opposite of **/B**.         |
|  /Job:<Identifier>   |                                             Runs the job identified by *Identifier* in a .wsf script file.                                             |
|        /Logo         | Specifies that the Windows Script Host banner is displayed in the console before the script runs. This is the default and the opposite of **/Nologo**. |
|       /Nologo        |                                 Specifies that the Windows Script Host banner is not displayed before the script runs.                                 |
|          /S          |                                             Saves the current command-prompt options for the current user.                                             |
|     /T:<Seconds>     |            Specifies the maximum time the script can run (in seconds). You can specify up to 32,767 seconds. The default is no time limit.             |
|          /U          |                                      Specifies Unicode for input and output that is redirected from the console.                                       |
|          /X          |                                                           starts the script in the debugger.                                                           |
|          /?          |  Displays available command parameters and provides help for using them. This is the same as typing **cscript.exe** with no parameters and no script.  |
|   ScriptArguments    |                        Specifies the arguments passed to the script. Each script argument must be preceded by a slash (**/**).                         |

### Remarks
-   Performing this task does not require you to have administrative credentials. Therefore, as a security best practice, consider performing this task as a user without administrative credentials.
-   To open a command prompt, on the **start** screen, type **cmd**, and then click **command prompt**.
-   Each parameter is optional; however, you cannot specify script arguments without specifying a script. If you do not specify a script or any script arguments, cscript.exe displays the cscript.exe syntax and the valid host options.
-   The **/T** parameter prevents excessive running of scripts by setting a timer. When the run time exceeds the specified value, cscript interrupts the script engine and ends the process.
-   Windows script files usually have one of the following file name extensions: .wsf, .vbs, .js.
-   You can set properties for individual scripts. See Related Topics for more information.
-   Windows Script Host can use .wsf script files. Each .wsf file can use multiple scripting engines and perform multiple jobs.
-   if you double-click a script file with an extension that has no association, the **Open With** dialog box appears. select wscript or cscript, and then select **Always use this program to open this file type**. This registers wscript.exe or cscript as the default script host for files of this file type.
-   You can set properties for individual scripts. See [additional References](#BKMK_references) for more information.
-   Windows Script Host can use .wsf script files. Each .wsf file can use multiple scripting engines and perform multiple jobs.

#### <a name="BKMK_references"></a>Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
