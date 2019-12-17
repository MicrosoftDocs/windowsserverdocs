---
title: Change the listening port in Remote Desktop
description: Learn how to change the listening port for Remote Desktop client.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
author: lizap
ms.author: elizapo
ms.date: 07/19/2018
ms.localizationpriority: medium
---
# Change the listening port for Remote Desktop on your computer

>Applies to: Windows 10, Windows 8.1, Windows 8, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2008 R2

When you connect to a computer (either a Windows client or Windows Server) through the Remote Desktop client, the Remote Desktop feature on your computer "hears" the connection request through a defined listening port (3389 by default). You can change that listening port on Windows computers by modifying the registry.

1. Start the registry editor. (Type regedit in the Search box.)
2. Navigate to the following registry subkey:
HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\PortNumber
3. Click **Edit > Modify**, and then click **Decimal**.
4. Type the new port number, and then click **OK**. 
5. Close the registry editor, and restart your computer.

The next time you connect to this computer by using the Remote Desktop connection, you must type the new port. If you're using a firewall, make sure to configure your firewall to permit connections to the new port number.
