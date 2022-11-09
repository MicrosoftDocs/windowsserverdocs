---
title: Change the listening port in Remote Desktop
description: Learn how to change the listening port for Remote Desktop client.
ms.topic: article
author: lizap
ms.author: elizapo
ms.date: 07/19/2018
---
# Change the listening port for Remote Desktop on your computer

>Applies to: Windows Server 2022, Windows 10, Windows 8.1, Windows 8, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2008 R2

When you connect to a computer (either a Windows client or Windows Server) through the Remote Desktop client, the Remote Desktop feature on your computer "hears" the connection request through a defined listening port (3389 by default). You can change that listening port on Windows computers by modifying the registry.

1. Start the registry editor. (Type regedit in the Search box.)
2. Navigate to the following registry subkey:
   **HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp**
3. Find **PortNumber**
4. Click **Edit > Modify**, and then click **Decimal**.
5. Type the new port number, and then click **OK**. 
6. Close the registry editor, and restart your computer.

The next time you connect to this computer by using the Remote Desktop connection, you must type the new port. If you're using a firewall, make sure to configure your firewall to permit connections to the new port number.


You can check the current port by running the following PowerShell command:

```powershell
Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "PortNumber"
```

For example:

```powershell
PortNumber   : 3389
PSPath       : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp
PSParentPath : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations
PSChildName  : RDP-Tcp
PSDrive      : HKLM
PSProvider   : Microsoft.PowerShell.Core\Registry
```

You can also change the RDP port by running the following PowerShell command. In this command, we'll specify the new RDP port as **3390**.


To add a new RDP Port to the registry:

```powershell
$portvalue = 3390

Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "PortNumber" -Value $portvalue 

New-NetFirewallRule -DisplayName 'RDPPORTLatest-TCP-In' -Profile 'Public' -Direction Inbound -Action Allow -Protocol TCP -LocalPort $portvalue 
New-NetFirewallRule -DisplayName 'RDPPORTLatest-UDP-In' -Profile 'Public' -Direction Inbound -Action Allow -Protocol UDP -LocalPort $portvalue 
```
