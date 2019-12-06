---
title: reset session
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4f029ecc-874e-415a-95a8-8b731bae35f9
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 07/11/2018
---
# reset session

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Enables you to reset (delete) a session on a Remote Desktop Session Host (rd Session Host) server.  
for examples of how to use this command, see [Examples](#BKMK_examples).  

> [!NOTE]  
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What s New in Remote Desktop Services in Windows Server 2012](https://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.  

## Syntax  
```  
reset session {<SessionName> | <SessionID>} [/server:<ServerName>] [/v]  
```  

## Parameters  

|Parameter|Description|  
|-------|--------|  
|\<SessionName>|Specifies the name of the session that you want to reset. To determine the name of the session, use the **query session** command.|  
|\<SessionID>|Specifies the ID of the session to reset.|  
|/server:\<ServerName>|Specifies the terminal server containing the session that you want to reset. Otherwise, the current rd Session Host server is used.|  
|/v|Displays information about the actions being performed.|  
|/?|Displays help at the command prompt.|  

## Remarks  
-   You can always reset your own sessions, but you must have Full Control access permission to reset another user's session.  
-   Be aware that resetting a user's session without warning the user can result in the loss of data at the session.  
-   You should reset a session only when it malfunctions or appears to have stopped responding.  
-   The **/server** parameter is required only if you use **reset session** from a remote server.  

## <a name="BKMK_examples"></a>Examples  
- To reset the session designated rdp-tcp#6, type:  
  ```  
  reset session rdp-tcp#6  
  ```  
- To reset the session that uses session ID 3, type:  
  ```  
  reset session 3  
  ```  

#### Additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
[Remote Desktop Services &#40;Terminal Services&#41; Command Reference](remote-desktop-services-terminal-services-command-reference.md)  
