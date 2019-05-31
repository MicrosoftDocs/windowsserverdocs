---
title: telnet set
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 67316b5f-9c6f-43e3-86d5-dcff9ae2ac3e vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# telnet: set

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sets options.   
## Syntax  
```  
set [bsasdel] [crlf] [delasbs] [escape <Char>] [localecho] [logfile <FileName>] [logging] [mode {console | stream}] [ntlm] [term {ansi | vt100 | vt52 | vtnt}] [?]  
```  
### Parameters  

|                    Parameter                     |                                                                                                                                              Description                                                                                                                                              |
|--------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|                     bsasdel                      |                                                                                                                                 Sends **Backspace** as a **delete**.                                                                                                                                  |
|                       crlf                       |                                                                                                        Sends CR & LF (0x0D, 0x 0A) when the **Enter** key is pressed. Known as  New line mode.                                                                                                        |
|                     delasbs                      |                                                                                                                                 Sends **delete** as a **Backspace**.                                                                                                                                  |
|                escape <Character>                | Sets the escape character used to enter the telnet client prompt. The escape character can be a single character, or it can be a combination of the **CTRL** key plus a character. To set a control-key combination, hold down the **CTRL** key while you type the character that you want to assign. |
|                    localecho                     |                                                                                                                                         Turns on local echo.                                                                                                                                          |
|                logfile <FileName>                |                                                                                               Logs the current telnet session to the local file. Logging begins automatically when you set this option.                                                                                               |
|                     logging                      |                                                                                                                  Turns on logging. If no log file is set, an error message appears.                                                                                                                   |
|           mode {console &#124; screen}           |                                                                                                                                       Sets the operation mode.                                                                                                                                        |
|                       ntlm                       |                                                                                                                                     Turns on NTLM authentication.                                                                                                                                     |
| term {ansi &#124; vt100 &#124; vt52 &#124; vtnt} |                                                                                                                                        Sets the terminal type.                                                                                                                                        |
|                        ?                         |                                                                                                                                    Displays help for this command.                                                                                                                                    |

## Remarks  
1. You can use the **unset** command to turn off an option that was previously set.  
2. On non-English versions of telnet, the **codeset** <option> is available. **Codeset** <option> sets the current code set to an option, which can be any one of the following: **shift JIS**, **Japanese EUC**, **JIS Kanji**, **JIS Kanji (78)**, **DEC Kanji**, **NEC Kanji**. You should set the same code set on the remote computer.  
   ## <a name="BKMK_Examples"></a>Examples  
   Set the log file and begin logging to the local file tnlog.txt  
   ```  
   set logfile tnlog.txt  
   ```  
   ## additional references  
3. [Command-Line Syntax Key](command-line-syntax-key.md)  
