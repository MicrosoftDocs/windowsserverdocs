---
title: Tscon
description: "Windows Commands topic for **** -- "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 315a9793-cd10-4987-bb68-89a9d13f7fce
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Tscon

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Connects to another session on a Remote Desktop Session Host (RD Session Host) server.  
For examples of how to use this command, see [Examples](#BKMK_examples).  
> [!NOTE]  
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What’s New in Remote Desktop Services in Windows Server 2012](http://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.  
## Syntax  
```  
tscon {<SessionID> | <SessionName>} [/dest:<SessionName>] [/password:<pw> | /password:*] [/v]  
```  
## Parameters  
|Parameter|Description|  
|-------------|---------------|  
|<SessionID>|Specifies the ID of the session to which you want to connect. If you use the optional **/dest:**<*SessionName*> parameter, this is the ID of the session to which you want to connect.|  
|<SessionName>|Specifies the name of the session to which you want to connect.|  
|/dest:<SessionName>|Specifies the name of the current session. This session will disconnect when you connect to the new session.|  
|/password:<pw>|Specifies the password of the user who owns the session to which you want to connect. This password is required when the connecting user does not own the session.|  
|/password:*|Prompts for the password of the user who owns the session to which you want to connect.|  
|/v|Displays information about the actions being performed.|  
|/?|Displays help at the command prompt.|  
## Remarks  
-   You must have Full Control access permission or Connect special access permission to connect to another session.  
-   The **/dest:**<*SessionName*> parameter allows you to connect the session of another user to a different session.  
-   If you do not specify a password in the <*Password*> parameter, and the target session belongs to a user other than the current one, **tscon** fails.  
-   You cannot connect to the console session.  
## <a name="BKMK_examples"></a>Examples  
-   To connect to session 12 on the current RD Session Host server and disconnect the current session, type:  
    ```  
    tscon 12  
    ```  
-   To connect to session 23 on the current RD Session Host server, by using the password mypass, and disconnect the current session, type:  
    ```  
    tscon 23 /password:mypass  
    ```  
-   To connect the session named TERM03 to the session named TERM05, and then disconnect session TERM05, if it is connected, type:  
    ```  
    tscon TERM03 /v /dest:TERM05  
    ```  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
[Remote Desktop Services &#40;Terminal Services&#41; Command Reference](Remote-Desktop-Services--Terminal-Services--Command-Reference.md)  
