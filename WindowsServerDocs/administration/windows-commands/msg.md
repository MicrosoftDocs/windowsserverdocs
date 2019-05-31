---
title: msg
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9501cf3e-568e-4982-9987-8daecc6c17ff
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# msg

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sends a message to a user on a Remote Desktop Session Host (rd Session Host) server.
for examples of how to use this command, see [Examples](#BKMK_examples).
> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What s New in Remote Desktop Services in Windows Server 2012](https://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.

## Syntax
```
msg {<UserName> | <SessionName> | <SessionID>| @<FileName> | *} [/server:<ServerName>] [/time:<Seconds>] [/v] [/w] [<Message>]
```

## Parameters

|      Parameter       |                                                                                                                               Description                                                                                                                               |
|----------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|      <UserName>      |                                                                                                  Specifies the name of the user that you want to receive the message.                                                                                                   |
|    <SessionName>     |                                                                                                 Specifies the name of the session that you want to receive the message.                                                                                                 |
|     <SessionID>      |                                                                                            Specifies the numeric ID of the session whose user you want to receive a message.                                                                                            |
|     @<FileName>      |                                                                         Identifies a file containing a list of user names, session names, and session IDs that you want to receive the message.                                                                         |
|          \*          |                                                                                                           Sends the message to all user names on the system.                                                                                                            |
| /server:<ServerName> |                                              Specifies the rd Session Host server whose session or user you want to receive the message. If unspecified, **/server** uses the server to which you are currently logged on.                                              |
|   /time:<Seconds>    | Specifies the amount of time that the message you sent is displayed on the user's screen. After the time limit is reached, the message disappears. If no time limit is set, the message remains on the user's screen until the user sees the message and clicks **OK**. |
|          /v          |                                                                                                         Displays information about the actions being performed.                                                                                                         |
|          /w          |         Waits for an acknowledgment from the user that the message has been received. Use this parameter with **/time:**<*Seconds*> to avoid a possible long delay if the user does not immediately respond. Using this parameter with **/v** is also helpful.          |
|      <Message>       |                  Specifies the text of the message that you want to send. If no message is specified, you will be prompted to enter a message. To send a message that is contained in a file, type the less than (<) symbol followed by the file name.                  |
|          /?          |                                                                                                                  Displays help at the command prompt.                                                                                                                   |

## Remarks
-   if you do not specify a user or a session, **msg** displays an error message. When specifying a session, it must be an active one.
-   The user must have Message special access permission to send a message.

## <a name="BKMK_examples"></a>Examples
-   To send the message entitled "Let's meet at 1PM today" to all sessions for User1, type:
    ```
    msg User1 Let's meet at 1PM today
    ```
-   To send the same message to session modeM02, type:
    ```
    msg modem02 Let's meet at 1PM today
    ```
-   To send the message to session 12, type:
    ```
    msg 12 Let's meet at 1PM today
    ```
-   To send the message to all sessions contained in the file USERlist, type:
    ```
    msg @userlist Let's meet at 1PM today
    ```
-   To send the message to all users who are logged on, type:
    ```
    msg * Let's meet at 1PM today
    ```
-   To send the message to all users, with an acknowledgment time-out (for example, 10 seconds), type:
    ```
    msg * /time:10 Let's meet at 1PM today
    ```

#### additional references
-  [Command-Line Syntax Key](command-line-syntax-key.md)
-  [Remote Desktop Services &#40;Terminal Services&#41; Command Reference](remote-desktop-services-terminal-services-command-reference.md)
