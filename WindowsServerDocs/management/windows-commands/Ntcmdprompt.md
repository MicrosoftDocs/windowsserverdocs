---
title: Ntcmdprompt
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0063bdbb-dc2b-41c4-99ee-b011603aaa86
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Ntcmdprompt
Runs the command interpreter **Cmd.exe**, rather than **Command.com**, after running a Terminate and Stay Resident (TSR) or after starting the command prompt from within an MS-DOS application.
## Syntax
```
ntcmdprompt
```
### Parameters
|Parameter|Description|
|-------------|---------------|
|/?|Displays help at the command prompt.|
## Remarks
-   When **Command.com** is running, some features of **Cmd.exe**, such as the **doskey** display of command history, are not available. If you would prefer to run the **Cmd.exe** command interpreter after you have started a Terminate and Stay Resident (TSR) or started the command prompt from within an application based on MS-DOS, you can use the **ntcmdprompt** command. However, keep in mind that the TSR may not be available for use when you are running **Cmd.exe**. You can include the **ntcmdprompt** command in your **Config.nt** file or the equivalent custom startup file in an application's program information file (PIF).
## Examples
To include **ntcmdprompt** in your **Config.nt** file, or the configuration startup file specified in the PIF, type:
**ntcmdprompt**
## Additional references
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)
-   [Command-Line Reference_1](Command-Line-Reference_1.md)
