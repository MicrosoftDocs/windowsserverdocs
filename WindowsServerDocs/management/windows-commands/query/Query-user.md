---
title: Query user
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a670fb78-c055-464a-b61d-3a85632c52c5
---
# Query user
Displays information about user sessions on a Remote Desktop Session Host \(RD Session Host\) server.

For examples of how to use this command, see [Examples](#BKMK_examples).

> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What’s New in Remote Desktop Services in Windows Server 2012](http://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.

## Syntax

```
query user [<UserName> | <SessionName> | <SessionID>] [/server:<ServerName>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|<UserName>|Specifies the logon name of the user that you want to query.|
|<SessionName>|Specifies the name of the session that you want to query.|
|<SessionID>|Specifies the ID of the session that you want to query.|
|\/server:<ServerName>|Specifies the RD Session Host server that you want to query. Otherwise, the current RD Session Host server is used.|
|\/?|Displays help at the command prompt.|

## Remarks

-   You can use this command to find out if a specific user is logged on to a specific RD Session Host server. **Query user** returns the following information:

    -   The name of the user

    -   The name of the session on the RD Session Host server

    -   The session ID

    -   The state of the session \(active or disconnected\)

    -   The idle time \(the number of minutes since the last keystroke or mouse movement at the session\)

    -   The date and time the user logged on

-   To use **query user**, you must have Full Control permission or Query Information special access permission.

-   If you use **query user** without specifying <*UserName*>, <*SessionName*>, or <*SessionID*>, a list of all users who are logged on to the server is returned. Alternatively, you can also use **query session** to display a list of all sessions on a server.

-   When **query user** returns information, a greater than \(>\) symbol is displayed before the current session.

-   The **\/server** parameter is required only if you use **query user** from a remote server.

## <a name="BKMK_examples"></a>Examples

-   To display information about all users logged on the system, type:

    ```
    query user
    ```

-   To display information about the user USER1 on server SERVER1, type:

    ```
    query user USER1 /server:SERVER1
    ```

#### Additional references
[Command-Line Syntax Key](../Command-Line-Syntax-Key.md)

[Query](../Query.md)

[Remote Desktop Services &#40;Terminal Services&#41; Command Reference](../commands-by-server-role/Remote-Desktop-Services--Terminal-Services--Command-Reference.md)


