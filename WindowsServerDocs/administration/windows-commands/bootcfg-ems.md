---
title: bootcfg ems
description: "Windows Commands topic for **bootcfg ems** - 
Enables the user to add or change the settings for redirection of the Emergency Management Services console to a remote computer."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 57abdc50-c64a-45f1-8470-3f8c3a51f743
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# bootcfg ems

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Enables the user to add or change the settings for redirection of the Emergency Management Services console to a remote computer. By enabling Emergency Management Services, you add a "redirect=Port#" line to the [boot loader] section of the Boot.ini file and a /redirect option to the specified operating system entry line. The Emergency Management Services feature is enabled only on servers.

## Syntax
```
bootcfg /ems {ON | OFF | edit} [/s <computer> [/u <Domain>\<User> /p <Password>]] [/port {COM1 | COM2 | COM3 | COM4 | BIOSSET}] [/baud {9600 | 19200 | 38400 | 57600 | 115200}] [/id <OSEntryLineNum>]
```
## Parameters

|                            Parameter                             |                                                                                                                                                                                                                                                                                                                                                              Description                                                                                                                                                                                                                                                                                                                                                              |
|------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|                    {ON &#124; OFF&#124; edit}                    | Specifies the value for Emergency Management Services redirection.<br /><br />**ON** - Enables remote output for the specified <OSEntryLineNum>. adds a /redirect option to the specified <OSEntryLineNum> and a redirect=com<X> setting to the [boot loader] section. The value of com<X> is set by the **/port** parameter.<br /><br />**OFF** - Disables output to a remote computer. removes the /redirect option from the specified <OSEntryLineNum> and the redirect=com<X> setting from the [boot loader] section.<br /><br />**edit** - Allows changes to port settings by changing the redirect=com<X> setting in the [boot loader] section. The value of com<X> is reset to the value specified by the **/port** parameter. |
|                          /s <computer>                           |                                                                                                                                                                                                                                                                                                          Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer.                                                                                                                                                                                                                                                                                                           |
|                       /u <Domain>\\<User>                        |                                                                                                                                                                                                                                                                 Runs the command with the account permissions of the user specified by <User> or <Domain>\\<User>. The default is the permissions of the current logged on user on the computer issuing the command.                                                                                                                                                                                                                                                                  |
|                          /p <Password>                           |                                                                                                                                                                                                                                                                                                                         Specifies the password of the user account that is specified in the **/u** parameter.                                                                                                                                                                                                                                                                                                                         |
| /port {COM1 &#124; COM2 &#124; COM3 &#124; COM4 &#124; BIOSSET}  |                                                                                                                                                                                                                              Specifies the COM port to be used for redirection. **BIOSSET** directs Emergency Management Services to get the BIOS settings to determine which port should be used for redirection. Do not use the **/port** parameter if remotely administered output is being disabled.                                                                                                                                                                                                                              |
| /baud {9600 &#124; 19200 &#124; 38400&#124; 57600 &#124; 115200} |                                                                                                                                                                                                                                                                                               Specifies the baud rate to be used for redirection. Do not use the **/baud** parameter if remotely administered output is being disabled.                                                                                                                                                                                                                                                                                               |
|                       /id <OSEntryLineNum>                       |                                                                                                                                                                                              Specifies the operating system entry line number to which the Emergency Management Services option is added in the [operating systems] section of the Boot.ini file. The first line after the [operating systems] section header is 1. This parameter is required when the Emergency Management Services value is set to **ON** or **OFF**.                                                                                                                                                                                              |
|                                /?                                |                                                                                                                                                                                                                                                                                                                                                 Displays help at the command prompt.                                                                                                                                                                                                                                                                                                                                                  |

## <a name="BKMK_examples"></a>Examples
The following examples show how you can use the **bootcfg /ems** command:
```
bootcfg /ems on /port com1 /baud 19200 /id 2 
bootcfg /ems on /port biosset /id 3 
bootcfg /s srvmain /ems off /id 2 
bootcfg /ems edit /port com2 /baud 115200 
bootcfg /s srvmain /u maindom\hiropln /p p@ssW23 /ems off /id 2
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
