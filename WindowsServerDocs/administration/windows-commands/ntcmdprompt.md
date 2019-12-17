---
title: ntcmdprompt
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0063bdbb-dc2b-41c4-99ee-b011603aaa86
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ntcmdprompt

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Runs the command interpreter **Cmd.exe**, rather than **Command.com**, after running a Terminate and Stay Resident (TSR) or after starting the command prompt from within an MS-DOS application.
## Syntax
```
ntcmdprompt
```
### Parameters

| Parameter |             Description              |
|-----------|--------------------------------------|
|    /?     | Displays help at the command prompt. |

## Remarks
- When **Command.com** is running, some features of **Cmd.exe**, such as the **doskey** display of command history, are not available. If you would prefer to run the **Cmd.exe** command interpreter after you have started a Terminate and Stay Resident (TSR) or started the command prompt from within an application based on MS-DOS, you can use the **ntcmdprompt** command. However, keep in mind that the TSR may not be available for use when you are running **Cmd.exe**. You can include the **ntcmdprompt** command in your **Config.nt** file or the equivalent custom startup file in an application's program information file (Pif).
  ## Examples
  To include **ntcmdprompt** in your **Config.nt** file, or the configuration startup file specified in the Pif, type:
  **ntcmdprompt**
  ## additional references
- [Command-Line Syntax Key](command-line-syntax-key.md)

