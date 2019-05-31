---
title: Remote Desktop Services (Terminal Services) Command Reference
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2f371848-5c48-470c-908c-afbc95d3a805

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Remote Desktop Services (Terminal Services) Command Reference

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The following is a list of Remote Desktop Services command-line tools.
> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What s New in Remote Desktop Services in Windows Server 2012](https://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.
> 
> |                 Command                 |                                                      Description                                                       |
> |-----------------------------------------|------------------------------------------------------------------------------------------------------------------------|
> |           [change](change.md)           | changes Remote Desktop Session Host (rd Session Host) server settings for logons, COM port mappings, and install mode. |
> |     [change logon](change-logon.md)     |    Enables or disables logons from client sessions on an rd Session Host server, or displays current logon status.     |
> |      [change port](change-port.md)      |                   lists or changes the COM port mappings to be compatible with MS-DOS applications.                    |
> |      [change user](change-user.md)      |                                changes the install mode for the rd Session Host server.                                |
> |         [chglogon](chglogon.md)         |    Enables or disables logons from client sessions on an rd Session Host server, or displays current logon status.     |
> |          [chgport](chgport.md)          |                   lists or changes the COM port mappings to be compatible with MS-DOS applications.                    |
> |           [chgusr](chgusr.md)           |                                changes the install mode for the rd Session Host server.                                |
> |         [flattemp](flattemp.md)         |                                      Enables or disables flat temporary folders.                                       |
> |           [logoff](logoff.md)           |          Logs off a user from a session on an rd Session Host server and deletes the session from the server.          |
> |              [msg](msg.md)              |                                Sends a message to a user on an rd Session Host server.                                 |
> |            [mstsc](mstsc.md)            |                       creates connections to rd Session Host servers or other remote computers.                        |
> |          [qappsrv](qappsrv.md)          |                             Displays a list of all rd Session Host servers on the network.                             |
> |         [qprocess](qprocess.md)         |                  Displays information about processes that are running on an rd Session Host server.                   |
> |            [query](query.md)            |                      Displays information about processes, sessions, and rd Session Host servers.                      |
> |    [query process](query-process.md)    |                  Displays information about processes that are running on an rd Session Host server.                   |
> |    [query session](query-session.md)    |                           Displays information about sessions on an rd Session Host server.                            |
> | [query termserver](query-termserver.md) |                             Displays a list of all rd Session Host servers on the network.                             |
> |       [query user](query-user.md)       |                         Displays information about user sessions on an rd Session Host server.                         |
> |            [quser](quser.md)            |                         Displays information about user sessions on an rd Session Host server.                         |
> |          [qwinsta](qwinsta.md)          |                           Displays information about sessions on an rd Session Host server.                            |
> |          [rdpsign](rdpsign.md)          |                          Enables you to digitally sign a Remote Desktop Protocol (.rdp) file.                          |
> |    [reset session](reset-session.md)    |                         Enables you to reset (delete) a session on an rd Session Host server.                          |
> |          [rwinsta](rwinsta.md)          |                         Enables you to reset (delete) a session on an rd Session Host server.                          |
> |           [shadow](shadow.md)           |            Enables you to remotely control an active session of another user on an rd Session Host server.             |
> |            [tscon](tscon.md)            |                               Connects to another session on an rd Session Host server.                                |
> |         [tsdiscon](tsdiscon.md)         |                                 Disconnects a session from an rd Session Host server.                                  |
> |           [tskill](tskill.md)           |                           Ends a process running in a session on an rd Session Host server.                            |
> |           [tsprof](tsprof.md)           |              Copies the Remote Desktop Services user configuration information from one user to another.               |
