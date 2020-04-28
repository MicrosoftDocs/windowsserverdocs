---
title: change
description: Reference topic for change, which changes Remote Desktop Session Host server settings for logons, COM port mappings, and install mode. 
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 90012116-0fb3-4f34-a819-cf4d4b4f8981
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# change

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Changes Remote Desktop Session Host server settings for logons, COM port mappings, and install mode.

> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What s New in Remote Desktop Services in Windows Server 2012](https://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.

## Syntax

 ```
 change logon
 change port
 change user
 ```
 
 ### Parameters
 
 |            Parameter            |                                                   Description                                                   |
 |---------------------------------|-----------------------------------------------------------------------------------------------------------------|
 | [change logon](change-logon.md) | Enables or disables logons from client sessions on an rd Session Host server, or displays current logon status. |
 |  [change port](change-port.md)  |                lists or changes the COM port mappings to be compatible with MS-DOS applications.                |
 |  [change user](change-user.md)  |                            changes the install mode for the rd Session Host server.                             |
 
 ## Additional References
 - [Command-Line Syntax Key](command-line-syntax-key.md)
 [Remote Desktop Services (Terminal Services) Command Reference](remote-desktop-services-terminal-services-command-reference.md)
