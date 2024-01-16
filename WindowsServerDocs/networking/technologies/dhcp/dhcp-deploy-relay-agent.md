---
title: Install DHCP relay agent for Windows Server
description: Learn how to install a DHCP relay agent on a computer running the Windows Server operating system.
ms.topic: quickstart
author: robinharwood
ms.author: wscontent
ms.custom: template-quickstart, team=cloud_advocates
ms.contributors: orthomas
ms.date: 01/12/2024
---

# Install a DHCP relay agent

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This article shows you how to install and configure a Dynamic Host Configuration Protocol (DHCP) Relay Agent on a computer running Windows Server. A DHCP relay agent works as an intermediary between DHCP clients and DHCP servers that aren't on the same subnet or local network. The DHCP Relay Agent forwards DHCP broadcast messages from clients to remote server, letting clients obtain IP addresses and other network configuration information from a DHCP server located on a different subnet.

To install the DHCP relay agent on Windows Server, you need to deploy the *Remote Access* server role. The DHCP relay agent is a feature of Remote Access and isn't included in the DHCP server role.

## Prerequisites

Before you can install your DHCP relay agent, you must have the following prerequisites:

- A computer running Windows Server in the remote subnet where you want to install the DHCP relay agent.
- A DHCP server with a DHCP scope configured for the remote subnet.

## Install and configure the server role

Here's how to install and configure LAN routing as part of the Remote Access server role from the Windows desktop.

1. Sign into the computer where you want to install the DHCP relay agent, then open the **Server Manager**.

1. In the Server Manager console, select **Add roles and features**.

1. In the **Add Roles and Features** menu, select **Next** until you reach the **Server Roles** page.

1. Expand the **Remote Access** role by selecting the accompanying checkbox or arrow.

1. In **Role Services**, select **Routing**, then **Add Features** when prompted.

1. Select **Next** until you reach the **Confirm installation selections** page.

1. Select **Install** to begin the installation. After the installation completes, select **Open the Getting Started Wizard**.

1. In the Routing and Remote Access Microsoft Management Console (MMC), right-click the server, then select *Configure and Enable Routing and Remote Access* to open the Routing and Remote Access Server Setup Wizard.

1. In the Welcome to the Routing and Remote Access Server Setup Wizard, select **Next**.

1. In **Configuration**, select *LAN routing*, and then select **Next**.

1. In **Custom Configuration**, select *VPN access*, and then select **Next** to open the Completing the Routing and Remote Access Server Setup Wizard.

1. Select **Finish** to close the wizard, then **Start service** when prompted.

## Configure DHCP Relay Agent

Here's how to install the DHCP Relay Agent role from the Routing and Remote Access MMC.

1. In the left pane, expand the server name, then right-click **General** under **IPv4** or **IPv6**, then select **New Routing Protocol**.

1. In the left pane, then right-click **DHCP Relay Agent** under **IPv4** or **IPv6**, then select **New Interface**.

1. Select the network interface you want to use for the DHCP relay agent. Select **OK**.

1. In the left pane, then right-click **DHCP Relay Agent** under **IPv4** or **IPv6**, then select **Properties**.

1. Enter the IP address of the DHCP server you want to relay DHCP requests to, then select **Add**.

1. Select **OK** to save your settings.

Now the DHCP Relay Agent is installed and configured on your Windows Server.

## Next steps

- [DHCP Basics](../../../troubleshoot/dynamic-host-configuration-protocol-basics.md)
- [DHCP Subnet selection options](dhcp-subnet-options.md)
