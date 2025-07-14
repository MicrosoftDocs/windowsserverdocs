---
title: Change Remote Desktop listening port on Windows and Windows Server
description: Learn to change the Remote Desktop listening port on Windows and Windows Server for enhanced security or configuration.
ms.topic: how-to
ai-usage: ai-assisted
author: dknappettmsft
ms.author: daknappe
ms.date: 06/30/2025
---

# Change the Remote Desktop listening port on your computer

Remote Desktop allows remote connections to computers running Windows or Windows Server over the Remote Desktop Protocol (RDP), listening on port 3389 by default. For security or configuration purposes, you might want to change this listening port. This article provides step-by-step instructions to modify the listening port using either PowerShell or the Registry Editor.

## Prerequisites

Before you begin, make sure you have the following items:

- Administrator access, or equivalent, to the computer you want to connect to.

- A computer with Remote Desktop enabled. For more information, see [Enable Remote Desktop](remote-desktop-allow-access.md).

- A client to test the changes from, such as Remote Desktop Connect (`mstsc.exe`) or [Windows App](/windows-app/get-started-connect-devices-desktops-apps).

## Configure the Remote Desktop listening port

The listening port for Remote Desktop is specified in the registry. To change the registry value, here's how to change it using PowerShell or the Registry Editor. Select the relevant tab for the method you prefer.

### [PowerShell](#tab/powershell)

To change the listening port using PowerShell, follow these steps:

1. Open PowerShell as an administrator.

1. Check the current port by running the following PowerShell command:

   ```powershell
   Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name 'PortNumber'
   ```

   The output is similar to the following example:

   ```powershell
   PortNumber   : 3389
   PSPath       : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp
   PSParentPath : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations
   PSChildName  : RDP-Tcp
   PSDrive      : HKLM
   PSProvider   : Microsoft.PowerShell.Core\Registry
   ```

1. Change the port by running the following PowerShell command. Be sure to replace `<Port Number>` with the new port number.

   ```powershell
   $portValue = '<Port Number>'

   Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name 'PortNumber' -Value $portValue
   ```

### [Registry Editor](#tab/regedit)

To change the listening port using the Registry Editor, follow these steps:

1. Select the **Start** button, type **Registry Editor**, open **Registry Editor** from the best match list.

1. Using the navigation pane, expand the key `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp`**`

1. In the main pane, select `PortNumber`

1. From the menu bar, select **Edit > Modify**, then select **Decimal**.

1. Type the new port number, and then select **OK**.

1. Close the Registry Editor, and restart your computer.

---

## Add the new port to the Windows Firewall

If you use the Windows Firewall, you need to add a new inbound rule to allow traffic on the new port. For more information about the different methods you can use to configure the Windows Firewall, see [Windows Firewall tools](/windows/security/operating-system-security/network-security/windows-firewall/tools).

> [!IMPORTANT]
> If you use any other firewall make sure you or your administrator permit connections to the new port number.

To create new Windows Firewall rules to allow the new port by running the following PowerShell command as an administrator. Be sure to replace `<Port Number>` with the new port number.

```powershell
$portValue = '<Port Number>'

New-NetFirewallRule -DisplayName 'RDPPORTLatest-TCP-In' -Profile Public -Direction Inbound -Action Allow -Protocol TCP -LocalPort $portValue
New-NetFirewallRule -DisplayName 'RDPPORTLatest-UDP-In' -Profile Public -Direction Inbound -Action Allow -Protocol UDP -LocalPort $portValue
```

## Test the new Remote Desktop listening port

The next time you connect to this computer by using the Remote Desktop Connection or other client, enter the hostname along with the new port. For example, if you changed the port to use 3390 on computer `pc1.contoso.com`, the address is `pc1.contoso.com:3390`.

## Related content

- [Enable Remote Desktop on your PC](remote-desktop-allow-access.md)
- [Allow access to your PC from outside your PC's network](remote-desktop-allow-outside-access.md)
- [Frequently asked questions about Remote PC connections](remote-pc-connections-faq.yml)
