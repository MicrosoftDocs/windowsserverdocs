---
title: Change the listening port for Remote Desktop on Windows and Windows Server
description: Learn how to change the listening port for Remote Desktop client using the registry on Windows and Windows Server.
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
ms.date: 02/14/2025
---
# Change the listening port for Remote Desktop on your computer

When you connect to a computer (either a Windows client or Windows Server) through the Remote Desktop client, the Remote Desktop feature on your computer "hears" the connection request through a defined listening port (3389 by default). In this article, you learn how to change the listening port for Remote Desktop client using the registry.

## Prerequisites

Before you begin, make sure you have the following items:

- Administrator access, or equivalent, to the computer you want to connect to.

- A computer with Remote Desktop enabled.

- A client to test the changes from, such as Remote Desktop Connect (`mstsc.exe`).

## Configure the listening port for Remote Desktop

To change the listening port, you can use the Registry Editor or PowerShell. Select the method you prefer.

### [Registry Editor](#tab/regedit)

To change the listening port using the Registry Editor, follow these steps:

1. Select the **Start** button, type **Registry Editor**, open **Registry Editor** from the best match list.

1. Using the navigation pane, expand the key **HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp**

1. In the main pane, select **PortNumber**

1. From the menu bar, select **Edit > Modify**, then select **Decimal**.

1. Type the new port number, and then select **OK**.

1. Close the registry editor, and restart your computer.

The next time you connect to this computer by using the Remote Desktop Connection, enter the hostname along with the new port. For example, if you changed the port to use 3390, the address would be `PC1.contoso.com:3390` If you're using a firewall, make sure to configure your firewall to permit connections to the new port number.

### [PowerShell](#tab/powershell)

To change the listening port using PowerShell, follow these steps:

1. Open PowerShell as an administrator.

1. Check the current port by running the following PowerShell command:

   ```powershell
   Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "PortNumber"
   ```

   The following shows an example output:

   ```powershell
   PortNumber   : 3389
   PSPath       : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp
   PSParentPath : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations
   PSChildName  : RDP-Tcp
   PSDrive      : HKLM
   PSProvider   : Microsoft.PowerShell.Core\Registry
   ```

1. Change the port by running the following PowerShell command, replacing `<port number>` with the new port number:

   ```powershell
   $portvalue = <port number>

   Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "PortNumber" -Value $portvalue
   ```

1. Create new firewall rules to allow the new port using the following PowerShell command, replacing `<port number>` with the new port number:

   ```powershell
   New-NetFirewallRule -DisplayName 'RDPPORTLatest-TCP-In' -Profile 'Public' -Direction Inbound -Action Allow -Protocol TCP -LocalPort <port number> 
   New-NetFirewallRule -DisplayName 'RDPPORTLatest-UDP-In' -Profile 'Public' -Direction Inbound -Action Allow -Protocol UDP -LocalPort <port number> 
   ```

---
