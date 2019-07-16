---
title: mstsc
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 59801227-1e7e-4dbd-96e6-f54102a3ce92
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# mstsc

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

creates connections to Remote Desktop Session Host (rd Session Host) servers or other remote computers, edits an existing Remote Desktop Connection (.rdp) configuration file, and migrates legacy connection files that were created with Client Connection Manager to new .rdp connection files.
for examples of how to use this command, see [Examples](#BKMK_examples).
> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What s New in Remote Desktop Services in Windows Server 2012](https://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.

## Syntax
```
mstsc.exe [<Connection File>] [/v:<Server>[:<Port>]] [/admin] [/f] [/w:<Width> /h:<Height>] [/public] [/span]
mstsc.exe /edit <Connection File>
mstsc.exe /migrate
```

## Parameters

|        Parameter        |                                                         Description                                                         |
|-------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|    <Connection File>    |                                   Specifies the name of an .rdp file for the connection.                                    |
|   /v:<Server[:<Port>]   |                Specifies the remote computer and, optionally, the port number to which you want to connect.                 |
|         /admin          |                                   Connects you to a session for administering the server.                                   |
|           /f            |                                    starts Remote Desktop Connection in full-screen mode.                                    |
|       /w:<Width>        |                                      Specifies the width of the Remote Desktop window.                                      |
|       /h:<Height>       |                                     Specifies the height of the Remote Desktop window.                                      |
|         /public         |                  Runs Remote Desktop in public mode. In public mode, passwords and bitmaps are not cached.                  |
|          /span          | Matches the Remote Desktop width and height with the local virtual desktop, spanning across multiple monitors if necessary. |
| /edit <Connection File> |                                         Opens the specified .rdp file for editing.                                          |
|        /migrate         |       Migrates legacy connection files that were created with Client Connection Manager to new .rdp connection files.       |
|           /?            |                                            Displays help at the command prompt.                                             |

## Remarks
-   Default.rdp is stored for each user as a hidden file in the user's Documents folder. User created .rdp files are saved by default in the user's Documents folder but can be saved anywhere.
-   To span across monitors, the monitors must use the same resolution and must be aligned horizontally (that is, side by side). There is currently no support for spanning multiple monitors vertically on the client system.

## <a name="BKMK_examples"></a>Examples
-   To connect to a session in full-screen mode, type:
    ```
    mstsc /f
    ```
-   To open a file called filename.rdp for editing, type:
    ```
    mstsc /edit filename.rdp
    ```

#### additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Remote Desktop Services &#40;Terminal Services&#41; Command Reference](remote-desktop-services-terminal-services-command-reference.md)
