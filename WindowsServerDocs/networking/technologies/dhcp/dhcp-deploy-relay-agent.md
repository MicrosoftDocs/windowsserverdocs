---
title: Deploy DHCP Relay Agent
description: You can use this topic to deploy a DHCP relay agent on a computer running the Windows Server operating system.
ms.topic: article
author: robinharwood
ms.author: wscontent
ms.custom: template-concept, team=cloud_advocates
ms.contributors: orthomas
ms.date: 07/10/2023
---

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This guide provides instructions on how to deploy an DHCP Relay Agent on a computer running the Windows Server operating system. A DHCP relay agent works as an intermediary between DHCP clients and DHCP servers that are not on the same subnet or local network. The DHCP Relay Agent forwards DHCP messages between clients and servers, enabling clients to obtain IP addresses and other network configuration information from a DHCP server located on a different subnet. 

# Deploy DHCP Relay Agent using Server Manager

To install the DHCP relay agent on a Windows Server, you need to deploy the "Remote Access" server role. The DHCP relay agent is a feature of this role and is not included in the DHCP server role. Follow these steps to install the DHCP relay agent:

1. Open the Server Manager on your Windows Server.
2. In the Server Manager console, click on "Add roles and features."
3. In the "Add Roles and Features Wizard," click "Next" until you reach the "Server Roles" page.
4. Expand the "Remote Access" role by clicking on the checkbox or the arrow next to it.
5. In the "Role Services" section, select "Routing."
6. Click "Next" until you reach the "Confirm installation selections" page.
7. Click "Install" to begin the installation process. Once the installation is completed, click "Close."

After you've installed the Remote Access role with the Routing role service, you can configure the DHCP relay agent:

1. Open the Routing and Remote Access management console (rrasmgmt.msc) from the Start menu or by typing "rrasmgmt.msc" in the Run dialog box.
2. In the left pane, expand the server name, and then right-click "IPv4" or "IPv6," depending on which version you want to configure the relay agent for.
3. Select "New Interface."
4. Choose the network interface you want to use for the DHCP relay agent, and click "OK."
5. In the properties of the newly added interface, go to the "General" tab.
6. Check the "Enable broadcast name resolution" box if you want to allow broadcast-based name resolution.
7. Go to the "DHCP Relay Agent" tab.
8. Check the "Enable DHCP relay agent" box.
9. Click the "Add" button to add the IP address of your DHCP server.
10. Click "OK" to save the settings.

Now the DHCP relay agent is installed and configured on your Windows Server.

# Deploy DHCP Relay Agent Using PowerShell

To configure the DHCP Relay Agent using PowerShell, you can follow these steps:

1. Install the Remote Access Server Role with Routing Role Service:

```powershell
Install-WindowsFeature -Name RemoteAccess -IncludeManagementTools
Install-WindowsFeature -Name DirectAccess-VPN -IncludeManagementTools
```

2. Enable Routing and Remote Access Service (RRAS):

```powershell
Install-RemoteAccess -VpnType RoutingOnly
```

3. Configure the DHCP Relay Agent:

```powershell
# Import RemoteAccess module if it is not present on your computer.
Import-Module RemoteAccess

# Replace 'Ethernet' with the name of the network interface you want to use for the DHCP relay agent
$interfaceName = 'Ethernet'

# Retrieve the interface index for the specified interface
$interfaceIndex = (Get-NetAdapter -Name $interfaceName).ifIndex

# Add the DHCP relay agent for the specified interface
Add-DhcpRelayAgent -InterfaceIndex $interfaceIndex

# Replace '192.168.10.20' with the IP address of your DHCP server
$dhcpServerIpAddress = '192.168.10.20'

# Configure the DHCP relay agent with the DHCP server IP address
Set-DhcpRelayAgent -InterfaceIndex $interfaceIndex -ServerAddress $dhcpServerIpAddress
```
After executing these PowerShell commands, the DHCP Relay Agent will be installed and configured on your Windows Server. 