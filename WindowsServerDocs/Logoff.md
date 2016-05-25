---
title: Logoff
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 939f09cc-de8c-436c-a05d-aca5f2a06371
author: jaimeo
---
# Logoff
Logs off a user from a session on a Remote Desktop Session Host \(RD Session Host\) server and deletes the session from the server.  
  
For examples of how to use this command, see [Examples](#BKMK_examples).  
  
> [!NOTE]  
> [!INCLUDE[rd_note-cmd-line-ref](includes/rd_note-cmd-line-ref_md.md)]  
  
## Syntax  
  
```  
logoff [<SessionName> | <SessionID>] [/server:<ServerName>] [/v]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<SessionName>|Specifies the name of the session.|  
|<SessionID>|Specifies the numeric ID which identifies the session to the server.|  
|\/server:<ServerName>|Specifies the RD Session Host server that contains the session whose user you want to log off. If unspecified, the server on which you are currently active is used.|  
|\/v|Displays information about the actions being performed.|  
|\/?|Displays help at the command prompt.|  
  
## Remarks  
  
-   You can always log off from the session to which you are currently logged on. You must, however, have Full Control permission to log off users from other sessions.  
  
-   Logging off a user from a session without warning can result in loss of data at the user's session. You should send a message to the user by using the **msg** command to warn the user before taking this action.  
  
-   If <*SessionID*> or <*SessionName*> is not specified, **logoff** logs off the user from the current session. If you specify <*SessionName*>, it must be an active one.  
  
-   When you log off a user, all processes end and the session is deleted from the server.  
  
-   You cannot log off a user from the console session.  
  
## <a name="BKMK_examples"></a>Examples  
  
-   To log off a user from the current session, type:  
  
    ```  
    logoff  
    ```  
  
-   To log off a user from a session by using the session's ID, for example session 12, type:  
  
    ```  
    logoff 12  
    ```  
  
-   To log off a user from a session by using the name of the session and server, for example session TERM04 on Server1, type:  
  
    ```  
    logoff TERM04 /server:Server1  
    ```  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
[Remote Desktop Services &#40;Terminal Services&#41; Command Reference](Remote-Desktop-Services--Terminal-Services--Command-Reference.md)  
  

