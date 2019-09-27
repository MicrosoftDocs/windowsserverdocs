---
title: shutdown
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c432f5cf-c5aa-4665-83af-0ec52c87112e

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# shutdown



Enables you to shut down or restart local or remote computers one at a time.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
shutdown [/i | /l | /s | /r | /a | /p | /h | /e] [/f] [/m \\<ComputerName>] [/t <XXX>] [/d [p|u:]<XX>:<YY> [/c "comment"]] 
```

## Parameters

|Parameter|Description|
|---------|-----------|
|/i|Displays the **Remote Shutdown Dialog** box. The **/i** option must be the first parameter following the command. If **/i** is specified, all other options are ignored.|
|/l|Logs off the current user immediately, with no time-out period. You cannot use **/l** with **/m** or **/t**.|
|/s|Shuts down the computer.|
|/r|Restarts the computer after shutdown.|
|/a|Aborts a system shutdown. Effective only during the timeout period. To use **/a**, you must also use the **/m** option.|
|/p|Turns off the local computer only (not a remote computer)—with no time-out period or warning. You can use **/p** only with **/d** or **/f**. If your computer does not support power-off functionality, it will shut down when you use **/p**, but the power to the computer will remain on.|
|/h|Puts the local computer into hibernation, if hibernation is enabled. You can use **/h** only with **/f**.|
|/e|Enables you to document the reason for the unexpected shutdown on the target computer.|
|/f|Forces running applications to close without warning users.</br>Caution: Using the **/f** option might result in loss of unsaved data.|
|/m \\\\\<ComputerName>|Specifies the target computer. Cannot be used with the **/l** option.|
|/t \<XXX>|Sets the time-out period or delay to *XXX* seconds before a restart or shutdown. This causes a warning to display on the local console. You can specify 0-600 seconds. If you do not use **/t**, the time-out period is 30 seconds by default.|
|/d [p\|u:]\<XX>:\<YY>|Lists the reason for the system restart or shutdown. The following are the parameter values:</br>**p** Indicates that the restart or shutdown is planned.</br>**u** Indicates that the reason is user defined.</br>Note: If **p** or **u** are not specified, the restart or shutdown is unplanned.</br>*XX* Specifies the major reason number (positive integer less than 256).</br>*YY* Specifies the minor reason number (positive integer less than 65536).|
|/c "\<Comment>"|Enables you to comment in detail about the reason for the shutdown. You must first provide a reason by using the **/d** option. You must enclose comments in quotation marks. You can use a maximum of 511 characters.|
|/?|Displays help at the command prompt, including a list of the major and minor reasons that are defined on your local computer.|

## Remarks

-   Users must be assigned the **Shut down the system** user right to shut down a local or remotely administered computer that is using the **shutdown** command.
-   Users must be members of the Administrators group to annotate an unexpected shutdown of a local or remotely administered computer. If the target computer is joined to a domain, members of the Domain Admins group might be able to perform this procedure. For more information, see:  
    -   [Default local groups](https://technet.microsoft.com/library/cc785098(v=ws.10).aspx)
    -   [Default groups](https://technet.microsoft.com/library/cc756898(v=ws.10).aspx)
-   If you want to shut down more than one computer at a time, you can call **shutdown** for each computer by using a script, or you can use **shutdown** **/i** to display the Remote Shutdown Dialog box.
-   If you specify major and minor reason codes, you must first define these reason codes on each computer where you plan to use the reasons. If the reason codes are not defined on the target computer, Shutdown Event Tracker cannot log the correct reason text.
-   Remember to indicate that a shutdown is planned by using the **p:** parameter. Omitting **p:** indicates that a shutdown is unplanned. If you type **p:** followed by the reason code for an unplanned shutdown, the command will not carry out the shutdown. Conversely, if you omit **p:** and type in the reason code for a planned shutdown, the command will not carry out the shutdown.

## <a name="BKMK_examples"></a>Examples

To force applications to close and restart the local computer after a one-minute delay with the reason "Application: Maintenance (Planned)" and the comment "Reconfiguring myapp.exe" type:
```
shutdown /r /t 60 /c "Reconfiguring myapp.exe" /f /d p:4:1
```
To restart the remote computer \\\\ServerName with the same parameters, type:
```
shutdown /r /m \\servername /t 60 /c "Reconfiguring myapp.exe" /f /d p:4:1
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
