---
title: Reset session
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4f029ecc-874e-415a-95a8-8b731bae35f9
---
# Reset session
Enables you to reset \(delete\) a session on a Remote Desktop Session Host \(RD Session Host\) server.

For examples of how to use this command, see [Examples](#BKMK_examples).

> [!NOTE]
> [!INCLUDE[rd_note-cmd-line-ref](includes/rd_note-cmd-line-ref_md.md)]

## Syntax

```
reset session {<SessionName> | <SessionID>} [/server:<ServerName>] [/v]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|<SessionName>|Specifies the name of the session that you want to reset. To determine the name of the session, use the **query session** command.|
|<SessionID>|Specifies the ID of the session to reset.|
|\/server:<ServerName>|Specifies the terminal server containing the session that you want to reset. Otherwise, the current RD Session Host server is used.|
|\/v|Displays information about the actions being performed.|
|\/?|Displays help at the command prompt.|

## Remarks

-   You can always reset your own sessions, but you must have Full Control access permission to reset another user's session.

-   Be aware that resetting a user's session without warning the user can result in the loss of data at the session.

-   You should reset a session only when it malfunctions or appears to have stopped responding.

-   The **\/server** parameter is required only if you use **reset session** from a remote server.

## <a name="BKMK_examples"></a>Examples

-   To reset the session designated rdp\-tcp\#6, type:

    ```
    reset session rdp-tcp#6
    ```

-   To reset the session that uses session ID 3, type:

    ```
    reset session 3
    ```

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Remote Desktop Services &#40;Terminal Services&#41; Command Reference](Remote-Desktop-Services--Terminal-Services--Command-Reference.md)


