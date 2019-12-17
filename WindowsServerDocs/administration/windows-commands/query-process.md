---
title: query process
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 36ce3ffc-0092-4eb1-a374-28e6616ca946
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# query process

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays information about processes that are running on a Remote Desktop Session Host (rd Session Host) server.
You can use this command to find out which programs a specific user is running, and also which users are running a specific program.
for examples of how to use this command, see [Examples](#BKMK_examples).
> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What s New in Remote Desktop Services in Windows Server 2012](https://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.
> ## Syntax
> ```
> query process [* | <ProcessID> | <UserName> | <SessionName> | /id:<nn> | <ProgramName>] [/server:<ServerName>]
> ```
> ## Parameters
> 
> |      Parameter       |                                                                 Description                                                                  |
> |----------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
> |          \*          |                                                    lists the processes for all sessions.                                                     |
> |     <ProcessID>      |                                   Specifies the numeric ID identifying the process that you want to query.                                   |
> |      <UserName>      |                                       Specifies the name of the user whose processes you want to list.                                       |
> |    <SessionName>     |                                     Specifies the name of the session whose processes you want to list.                                      |
> |       /id:<nn>       |                                      Specifies the ID of the session whose processes you want to list.                                       |
> |    <ProgramName>     |                     Specifies the name of the program whose processes you want to query. The .exe extension is required.                     |
> | /server:<ServerName> | Specifies the rd Session Host server whose processes you want to list. If unspecified, the server where you are currently logged on is used. |
> |          /?          |                                                     Displays help at the command prompt.                                                     |
> 
> ## Remarks
> - Administrators have full access to all **query process** functions.
> - if you do not specify the <*UserName*>, <*SessionName*>, **/id:**<*nn*>, <*ProgramName*>, or **\\*** parameters, **query process** displays only the processes that belong to the current user.
> - if a session is specified, it must identify an active session.
> - **query process** returns the following information:
>   -   The user who owns the process
>   -   The session that owns the process
>   -   The ID of the session
>   -   The name of the process
>   -   The ID of the process
> - When **query process** returns information, a greater than (>) symbol is displayed before each process that belongs to the current session.
>   ## <a name="BKMK_examples"></a>Examples
> - To display information about the processes being used by all sessions, type:
>   ```
>   query process *
>   ```
> - To display information about the processes being used by session ID 2, type:
>   ```
>   query process /ID:2
>   ```
>   #### additional references
>   [Command-Line Syntax Key](command-line-syntax-key.md)
>   [query](query.md)
>   [Remote Desktop Services &#40;Terminal Services&#41; Command Reference](remote-desktop-services-terminal-services-command-reference.md)
