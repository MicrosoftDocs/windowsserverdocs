---
title: wscript
description: Reference article for the wscript command; wscript provides an environment in which users can execute scripts in various languages that use various object models to perform tasks.
ms.topic: reference
ms.author: jgerend
author: JasonGerend
ms.date: 04/01/2023
---

# wscript

Applies to: Windows Server (All supported versions)

Windows Script Host provides an environment in which users can execute scripts in various languages that use various object models to perform tasks.

## Syntax

```
wscript [<scriptname>] [/b] [/d] [/e:<engine>] [{/h:cscript|/h:wscript}] [/i] [/job:<identifier>] [{/logo|/nologo}] [/s] [/t:<number>] [/x] [/?] [<ScriptArguments>]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|`scriptname`|Specifies the path and file name of the script file.|
|`/b`|Specifies batch mode, which doesn't display alerts, scripting errors, or input prompts. The /b parameter is the opposite of **/i**.|
|`/d`|Starts the debugger.|
|`/e`|Specifies the engine that is used to run the script. This parameter lets you run scripts that use a custom file name extension. Without the /e parameter, you can only run scripts that use registered file name extensions. For example, if you try to run this command:<br>`cscript test.admin`<br>You receive this error message: Input Error: There's no script engine for file extension `.admin`.<br>One advantage of using nonstandard file name extensions is that it guards against accidentally double-selecting a script and running something you didn't actually want to run. <br>Using this extension doesn't create a permanent association between the `.admin` file name extension and VBScript. Each time you run a script that uses a `.admin` file name extension, you need to use the /e parameter.|
|`/h:cscript`|Registers **cscript.exe** as the default script host for running scripts.|
|`/h:wscript`|Registers **wscript.exe** as the default script host for running scripts. This behavior is the default when the **/h** option is omitted.|
|`/i`|Specifies interactive mode, which displays alerts, scripting errors, and input prompts.</br>The /i parameter is the default and the opposite of **/b**.|
|`/job:\<identifier>`|Runs the job identified by *identifier* in a **.wsf** script file.|
|`/logo`|Specifies that the Windows Script Host banner is displayed in the console before the script runs.</br>The /logo parameter is the default and the opposite of **/nologo**.|
|`/nologo`|Specifies that the Windows Script Host banner isn't displayed before the script runs. The /nologo parameter is the opposite of **/logo**.|
|`/s`|Saves the current command prompt options for the current user.|
|`/t:\<number>`|Specifies the maximum time the script can run (in seconds). You can specify up to 32,767 seconds. </br>The default is no time limit.|
|`/x`|Starts the script in the debugger.|
|`ScriptArguments`|Specifies the arguments passed to the script. Each script argument must be preceded with a slash (/).|
|`/?`|Displays Help at the command prompt.|

## Remarks

- Performing this task doesn't require you to have administrative credentials. Consider performing this task as a user without administrative credentials as a security best practice.
- To open a command prompt, on the **Start** screen, type **cmd**, and then select **command prompt**.
- Each parameter is optional. However you can't specify script arguments without specifying a script. If you don't specify a script or any script arguments, **wscript.exe** displays the **Windows Script Host Settings** dialog box. Use the dialog box to set global scripting properties for all scripts that **wscript.exe** runs on the local computer.
- The **/t** parameter prevents excessive running of scripts by setting a timer. When the time exceeds the specified value, **wscript** interrupts the script engine and ends the process.
- Windows script files usually have one of the following file name extensions: **.wsf**, **.vbs**, **.js**.
- If you double-select a script file with an extension that has no association, the **Open With** dialog box appears. Select **wscript** or **cscript**, and then select **Always use this program to open this file type**. This registers **wscript.exe** or **cscript.exe** as the default script host for files of this file type.
- You can set properties for individual scripts. For more information about Windows Script Host, see [Windows Script Host overview](/previous-versions/windows/it-pro/windows-server-2003/cc738350(v=ws.10)).
- Windows Script Host can use **.wsf** script files. Each **.wsf** file can use multiple scripting engines and perform multiple jobs.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)