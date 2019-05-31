---
title: tsdiscon
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 13139674-7dee-4965-8cac-32f4928e8b9a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# tsdiscon

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Disconnects a session from a Remote Desktop Session Host (rd Session Host) server.
for examples of how to use this command, see [Examples](#BKMK_examples).

> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What s New in Remote Desktop Services in Windows Server 2012](https://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.

## Syntax
```
tsdiscon [<SessionID> | <SessionName>] [/server:<ServerName>] [/v]
```

## Parameters

|Parameter|Description|
|-------|--------|
|\<SessionId>|Specifies the ID of the session to disconnect.|
|\<SessionName>|Specifies the name of the session to disconnect.|
|/server:\<ServerName>|Specifies the terminal server that contains the session that you want to disconnect. Otherwise, the current rd Session Host server is used.|
|/v|Displays information about the actions being performed.|
|/?|Displays help at the command prompt.|

## Remarks
-   You must have Full Control permission or Disconnect special access permission to disconnect another user from a session.
-   if no session ID or session name is specified, **tsdiscon** disconnects the current session.
-   Any applications that were running when you disconnected the session are automatically running when you reconnect to that session with no loss of data. Use **reset session** to end the running applications of the disconnected session, but be aware that this might result in loss of data at the session.
-   The **/server** parameter is required only if you use **tsdiscon** from a remote server.
-   The console session cannot be disconnected.

## <a name="BKMK_examples"></a>Examples
- To disconnect the current session, type:
  ```
  tsdiscon
  ```
- To disconnect session 10, type:
  ```
  tsdiscon 10
  ```
- To disconnect the session named TERM04, type:
  ```
  tsdiscon TERM04
  ```
  #### Additional references
  [Command-Line Syntax Key](command-line-syntax-key.md)
  [Remote Desktop Services &#40;Terminal Services&#41; Command Reference](remote-desktop-services-terminal-services-command-reference.md)
