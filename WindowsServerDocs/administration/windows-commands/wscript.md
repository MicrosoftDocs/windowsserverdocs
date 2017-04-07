---
title: wscript
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2fbaf193-cdbd-414c-84c9-bb5720f84c29
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# wscript

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Windows Script Host provides an environment in which users can execute scripts in a variety of languages, languages that use a variety of object models to perform tasks.
## Syntax
```
wscript[<scriptname>] [/b] [/d] [/e:<engine>] [{/h:cscript|/h:wscript}] [/i] [/job:<identifier>] [{/logo|/nologo}] [/s] [/t:<number>] [/x] [/?] [<ScriptArguments>]
```
### Parameters
|Parameter|Description|
|-------|--------|
|ScriptName|Specifies the path and file name of the script file.|
|/b|Specifies batch mode, which does not display alerts, scripting errors, or input prompts.|
|/d|starts the debugger.|
|/e|Specifies the engine that is used to run the script.|
|/h:cscript|registers **cscript.exe** as the default script host for running scripts.|
|/h:wscript|Default. registers **wscript.exe** as the default script host for running scripts. This is the default.|
|/i|Specifies interactive mode, which displays alerts, scripting errors, and input prompts.<br /><br />This is the default and the opposite of **/b**.|
|/job:<identifier>|Runs the job identified by *identifier* in a **.wsf** script file.|
|/logo|Specifies that the Windows Script Host banner is displayed in the console before the script runs.<br /><br />This is the default and the opposite of **/nologo**.|
|/nologo|Specifies that the Windows Script Host banner is not displayed before the script runs.|
|/s|Saves the current command-prompt options for the current user.|
|/t:<number>|Specifies the maximum time the script can run (in seconds). You can specify up to 32,767 seconds.<br /><br />The default is no time limit.|
|/x|starts the script in the debugger.|
|ScriptArguments|Specifies the arguments passed to the script. Each script argument must be preceded by a slash (/).|
|/?|Displays help at the command prompt.|
## remarks
-   Performing this task does not require you to have administrative credentials. Therefore, as a security best practice, consider performing this task as a user without administrative credentials.
-   To open a command prompt, on the **start** screen, type **cmd**, and then click **command prompt**.
-   Each parameter is optional; however, you cannot specify script arguments without specifying a script. If you do not specify a script or any script arguments, **wscript.exe** displays the **Windows Script Host Settings** dialog box, which you can use to set global scripting properties for all scripts that **wscript.exe** runs on the local computer.
-   The **/t** parameter prevents excessive running of scripts by setting a timer. When the time exceeds the specified value, **wscript** interrupts the script engine and ends the process.
-   Windows script files usually have one of the following file name extensions: **.wsf**, **.vbs**, **.js**.
-   if you double-click a script file with an extension that has no association, the **Open With** dialog box appears. select **wscript** or **cscript**, and then select **Always use this program to open this file type**. This registers **wscript.exe** or **cscript** as the default script host for files of this file type.
-   You can set properties for individual scripts. See [Windows Script Host overview](https://technet.microsoft.com/library/cc738350(v=ws.10).aspx) for more information.
-   Windows Script Host can use **.wsf** script files. Each **.wsf** file can use multiple scripting engines and perform multiple jobs.
## additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)
