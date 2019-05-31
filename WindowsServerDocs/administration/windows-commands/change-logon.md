---
title: change logon
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 41466260-aee9-4333-bcb6-178112c22afd Lizap
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

# change logon
Enables or disables logons from client sessions, or displays current logon status.
This utility is useful for system maintenance.
for examples of how to use this command, see [Examples](#BKMK_examples).
> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What s New in Remote Desktop Services in Windows Server 2012](https://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.
> ## Syntax
> ```
> change logon {/query | /enable | /disable | /drain | /drainuntilrestart}
> ```
> ## Parameters
> 
> |     Parameter      |                                                       Description                                                        |
> |--------------------|--------------------------------------------------------------------------------------------------------------------------|
> |       /query       |                             Displays the current logon status, whether enabled or disabled.                              |
> |      /enable       |                              Enables logons from client sessions, but not from the console.                              |
> |      /disable      |  Disables subsequent logons from client sessions, but not from the console. Does not affect currently logged on users.   |
> |       /drain       |                 Disables logons from new client sessions, but allows reconnections to existing sessions.                 |
> | /drainuntilrestart | Disables logons from new client sessions until the computer is restarted, but allows reconnections to existing sessions. |
> |         /?         |                                           Displays help at the command prompt.                                           |
> 
> ## Remarks
> - Only administrators can use the **change logon** command.
> - Logons are re-enabled when you restart the system. If you are connected to the Remote Desktop Session Host (rd Session Host) server from a client session and disable logons, and then log off before re-enabling logons, you will not be able to reconnect to your session. To re-enable logons from client sessions, log on at the console.
>   ## <a name="BKMK_examples"></a>Examples
> - To display the current logon status, type:
>   ```
>   change logon /query
>   ```
> - To enable logons from client sessions, type:
>   ```
>   change logon /enable
>   ```
> - To disable client logons, type:
>   ```
>   change logon /disable
>   ```
>   #### additional references
>   [Command-Line Syntax Key](command-line-syntax-key.md)
>   [change](change.md)
>   [Remote Desktop Services &#40;Terminal Services&#41; Command Reference](remote-desktop-services-terminal-services-command-reference.md)
