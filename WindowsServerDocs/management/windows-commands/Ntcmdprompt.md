---
title: ntcmdprompt
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0063bdbb-dc2b-41c4-99ee-b011603aaa86
---
# ntcmdprompt
Runs the command interpreter **cmd.exe**, rather than **Command.com**, after running a Terminate and Stay Resident \(TSR\) or after starting the command prompt from within an MS\-DOS application.

## Syntax

```
ntcmdprompt
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|\/?|Displays help at the command prompt.|

## remarks

-   When **Command.com** is running, some features of **cmd.exe**, such as the **doskey** display of command history, are not available. if you would prefer to run the **cmd.exe** command interpreter after you have started a Terminate and Stay Resident \(TSR\) or started the command prompt from within an application based on MS\-DOS, you can use the **ntcmdprompt** command. However, keep in mind that the TSR may not be available for use when you are running **cmd.exe**. You can include the **ntcmdprompt** command in your **Config.nt** file or the equivalent custom startup file in an application's program information file \(Pif\).

## Examples
To include **ntcmdprompt** in your **Config.nt** file, or the configuration startup file specified in the Pif, type:

**ntcmdprompt**

## additional references

-   [Command-Line Syntax Key](commandline-syntax-key.md)

-   [Command-Line Reference_1](Command-Line-Reference_1.md)


