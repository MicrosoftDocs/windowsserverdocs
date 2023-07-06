---
title: Install DHCP relay agent
description: Learn how to install a DHCP relay agent on a computer running the Windows Server operating system.
ms.topic: quickstart
author: robinharwood
ms.author: wscontent
ms.custom: template-quickstart, team=cloud_advocates
ms.contributors: orthomas
ms.date: 07/10/2023
---

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

# Install DHCP relay agent

This quickstart provides instructions on how to install and configure an DHCP Relay Agent on a computer running the Windows Server operating system. A DHCP relay agent works as an intermediary between DHCP clients and DHCP servers that are not on the same subnet or local network. The DHCP Relay Agent forwards DHCP messages between clients and servers, enabling clients to obtain IP addresses and other network configuration information from a DHCP server located on a different subnet.

## Prerequisites

Before you can install your DHCP relay agent, you must meet the following prerequisites:

- A computer with DHCP server successfully installed.
- A static IP.
- An account that's a member of the Administrators group, or equivalent.

## Install and configure the DHCP relay agent

To install the DHCP relay agent using PowerShell, you can follow these steps:

#### [PowerShell](#tab/powershell)

Use these steps to install and configure the DHCP relay agent using Powershell.

1. Install the Remote Access Server Role with Routing Role Service:

```powershell
Install-WindowsFeature -Name RemoteAccess -IncludeManagementTools
Install-WindowsFeature -Name DirectAccess-VPN -IncludeManagementTools
```

1. Enable Routing and Remote Access Service (RRAS):

```powershell
Install-RemoteAccess -VpnType RoutingOnly
```

1. Configure the DHCP Relay Agent:

```powershell
# Import RemoteAccess module if it isn't present on your computer.
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

To install the DHCP relay agent on Windows Server, you need to deploy the "Remote Access" server role. The DHCP relay agent is a feature of this role and isn't included in the DHCP server role. 

#### [GUI](#tab/gui)

Follow these steps to install the DHCP relay agent:

1. Open the Server Manager.
1. In the Server Manager console, select **Add roles and features**"
1. In the Add Roles and Features wizard, select **Next** until you reach the **Server Roles** page.
1. Expand the **Remote Access** role by selecting the accompanying checkbox or arrow.
1. In **Role Services**, select **Routing.**
1. Select **Next** until you reach the **Confirm installation selections** page.
1. Select **Install** to begin the installation. After the installation completes, select **Close**.

---

After you've installed the Remote Access role with the Routing role service, you can configure the DHCP relay agent.

#### [GUI](#tab/gui)

Follow these steps to configure the DHCP relay agent.

1. Open the Routing and Remote Access management console (`rrasmgmt.msc`) from the Start menu or by entering `rrasmgmt.msc` in the Run dialog box.
1. In the left pane, expand the server name, and then right-select **IPv4** or **IPv6** depending on which version you want to configure the relay agent for.
1. Select **New Interface**.
1. Choose the network interface you want to use for the DHCP relay agent. Select **OK**
1. In the properties of the newly added interface, go to the **General** tab.
1. Select **Enable broadcast name resolution** if you want to allow broadcast-based name resolution.
1. Go to the **DHCP Relay Agent** tab.
1. Select **Enable DHCP relay agent**.
1. Select **Add** to add the IP address of your DHCP server.
1. Select **OK** to save your settings.

Now the DHCP relay agent is installed and configured on your Windows Server.

## Next steps

- [DHCP Basics](../../../troubleshoot/dynamic-host-configuration-protocol-basics.md)
- [DHCP Subnet selection options](dhcp-subnet-options.md)