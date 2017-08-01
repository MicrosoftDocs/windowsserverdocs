---
title: Configure the Remote Access Server for Always On VPN
description: This topic provides detailed instructions for deploying Always On VPN in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 7607a9b7-c9a4-4c4d-8a62-2d4c422e2a1f
manager: brianlic
ms.author: jamesmci
author: jamesmci
---

# Configure the Remote Access Server for Always On VPN

>Applies To: Windows Server 2016, Windows 10

You can use this section to install and configure the Remote Access server role on the computer or virtual machine \(VM\) that you want to use as your VPN server. 

## VPN server Deployment Overview

The steps in this section allow you to complete the following items.

1. On the computer or VM that is planned as the VPN server, and that is installed on your perimeter network, you can install Remote Access.

2. On the Remote Access server, you can configure Remote Access as a RAS Gateway VPN server.

## Install Remote Access as a RAS Gateway VPN Server

You can use this section to install the Remote Access role as a single tenant RAS Gateway VPN server.

For more information, see [Remote Access](https://docs.microsoft.com/windows-server/remote/remote-access/remote-access).

**Administrative Credentials**

To complete this procedure, you must be a member of the **Domain Admins** group.

### To install Remote Access using Windows PowerShell

To perform this procedure by using Windows PowerShell, run Windows PowerShell as Administrator, type the following command, and then press ENTER.

`Install-WindowsFeature DirectAccess-VPN -IncludeManagementTools`

After installation successfully completes, the following message appears in Windows PowerShell.

|Success| Restart Needed| Exit Code|  Feature Result|
|------- |--------------| ---------|  --------------|
|True|No |Success|{RAS Connection Manager Administration Kit|

### To install Remote Access using Server Manager

You can use the following procedure to install Remote Access using Server Manager.

1.  On the VPN server, in **Server Manager**, click **Manage**, and then click **Add Roles and Features**. The Add Roles and Features Wizard opens.

2.  In **Before you begin**, click **Next**.

3.  In **Select Installation Type**, ensure that **Role-Based or feature-based installation** is selected, and then click **Next**.

4.  In **Select destination server**, ensure that **Select a server from the server pool** is selected. In **Server Pool**, ensure that the local computer is selected. Click **Next**.

5.  In **Select server roles**, in **Roles**, click **Remote Access**, and then click **Next**.

6.  In **Select features**, click **Next**.

7.  In **Remote Access**, click **Next**.

8.  In **Select role service**, in **Role services**, click **DirectAccess and VPN \(RAS\)**.

9.  On the Add Roles and Features dialog box, click **Add Features**, and click
    **Next**.

10. On the Web Server Role (IIS) page, click **Next**.

11. On the Select role services page, click **Next**.

12. On the Confirm installation selections page, click **Install**.

13. When the installation is complete, click **Close**.

## Configure Remote Access as a VPN Server

In this section, you configure Remote Access VPN to allow IKEv2 VPN connections, deny connections from other VPN protocols, and assign a static IP address pool for issuance of IP addresses to connecting authorized VPN clients.

### To Configure Remote Access as a VPN Server

1.  On the VPN server, in Server Manager, click the **Notifications** flag; then, in the **Tasks** menu, click **Open the Getting Started Wizard**. The Configure Remote Access wizard opens.

>[!NOTE]
>The Configure Remote Access wizard might open behind Server Manager. If you think the wizard is taking too long to open, move or minimize Server Manager to find out whether the wizard is behind it.

1.  In **Configure Remote Access**, click **Deploy VPN only**. The Routing and Remote Access Microsoft Management Console \(MMC\) opens.

2.  In Routing and Remote Access, right-click the VPN server, and click **Configure and Enable Routing and Remote Access**. The Routing and Remote Access Server Setup Wizard opens. Complete the following steps:

    a.  In the Routing and Remote Access Server Setup Wizard, click **Next**.

    b.  In **Configuration**, click **Custom Configuration**, and then click **Next**.

    c.  In **Custom Configuration**, click **VPN access**, and then click **Next**.

    d.  In **Completing the Routing and Remote Access Server Setup Wizard**, click **Finish** to close the wizard, and click **OK** to close the Routing and Remote Access dialog box.

    e.  Click **Start service** to start Remote Access.

3.  In the Remote Access MMC, right\-click the VPN server, and click **Properties**.

4.  In **Properties**, click the **IPv4** tab. Click **Static address pool**, and complete the following steps to configure an IP address pool. The static address pool should contain addresses from the internal perimeter network. These addresses are on the internal-facing network connection on the VPN server, not the corporate network.

    a.  Click **Add**.

    b.  In **Start IP address**, type the starting IP address in the range you want to assign to VPN clients.

    c.  In **End IP address**, type the ending IP address in the range you want to assign to VPN clients, or in **Number of addresses**, type the number of address you want to make available.

>[!NOTE]
>If you’re using DHCP for this subnet, ensure that you configure a corresponding address exclusion on your DHCP servers.

5.  Click **OK**.

6.  In **Adapter**, click the Ethernet adapter that is connected to your internal perimeter network.

7.  Click **OK** to close the **Properties** dialog box.

8.  Under the VPN server, right-click **Ports,** and click **Properties**.

9.  On the Ports Properties dialog box, select **WAN Miniport \(SSTP\)**, and click **Configure**.

10.  Clear the **Remote access connections \(inbound only\)** and **Demand-dial routing connections \(inbound and outbound\)** check boxes, and click **OK**.

7.  Repeat the previous step for WAN Miniport \(Layer 2 Tunneling Protocol [L2TP]\) and WAN Miniport \(Point-to-Point Tunneling Protocol [PPTP]\).

8.  Click **WAN Miniport \(IKEv2\)**, and click **Configure**.

9.  In **Maximum ports**, type the number of ports to match the maximum number of simultaneous VPN connections you want to support, and click **OK**.

10. If prompted, click **Yes** to confirm restarting the server.

11. If prompted, click **Close** to restart the server.



For the next Always On VPN deployment steps, see [Install and Configure the NPS Server](vpn-deploy-nps.md).