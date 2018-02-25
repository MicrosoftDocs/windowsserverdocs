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

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

The next step in the deployment process is installing and configuring the Remote Access server role on the VPN server. In Windows Server 2016, the Remote Access server role is a logical grouping of the following related network access technologies:

- Remote Access Service (RAS)
- Routing
- Web Application Proxy

These technologies are the role services of the Remote Access server role so you can install one or more of these role services. 

When you install the **DirectAccess and VPN \(RAS\)** role service, you are deploying the Remote Access Service Gateway \(**RAS Gateway**\). You can deploy RAS Gateway as a single tenant RAS Gateway virtual private network \(VPN\) server that provides many advanced features and enhanced functionality.

>[!NOTE]
>You can also deploy RAS Gateway as a Multitenant VPN server for use with Software Defined Networking \(SDN\), or as a DirectAccess server. For more information, see [RAS Gateway](https://docs.microsoft.com/windows-server/remote/remote-access/ras-gateway/ras-gateway), [Software Defined Networking (SDN)](https://docs.microsoft.com/windows-server/networking/sdn/software-defined-networking), and [DirectAccess](https://docs.microsoft.com/windows-server/remote/remote-access/directaccess/directaccess).


## STEP 1: Install Remote Access as a RAS Gateway VPN Server

Install the Remote Access role as a single tenant RAS Gateway VPN server.<!-- why is this installation for single tenant?  after reading this, and if I want multi tenant, then Always On VPN is not the solution I'm looking for.  Can you install RRAS Gateway VPN Server on a multitentant vpn server? --> For more information, see [Remote Access](https://docs.microsoft.com/windows-server/remote/remote-access/remote-access).

>![IMPORTANT]
>Membership in **Administrators**, or equivalent, is the minimum required to perform these procedures.

### Use Windows PowerShell to install Remote Access

1. Run Windows PowerShell as Administrator.
2. Type the following command:<br><br>`Install-WindowsFeature DirectAccess-VPN -IncludeManagementTools`
3. Press ENTER.

After installation successfully completes, the following message appears in Windows PowerShell.

|Success| Restart Needed| Exit Code|  Feature Result|
|------- |--------------| ---------|  --------------|
|True|No |Success|{RAS Connection Manager Administration Kit|

### Use Server Manager to install Remote Access

1.  On the VPN server, in **Server Manager**, click **Manage**, and then click **Add Roles and Features**.<br><br>The Add Roles and Features Wizard opens.

2.  In **Before you begin**, click **Next**.

3.  In **Select Installation Type**, ensure that **Role-Based or feature-based installation** is selected, and then click **Next**.

4.  In **Select destination server**, ensure that **Select a server from the server pool** is selected. 
5. In **Server Pool**, ensure that the local computer is selected. Click **Next**.

5.  In **Select server roles**, in **Roles**, click **Remote Access**, and then click **Next**.

6.  In **Select features**, click **Next**.

7.  In **Remote Access**, click **Next**.

8.  In **Select role service**, in **Role services**, click **DirectAccess and VPN \(RAS\)**. <br><br>The Add Roles and Features Wizard dialog box opens.

9.  Click **Add Features** to close the dialog box, and then click **Next**.

10. In **Web Server Role (IIS)**, click **Next**.

11. In **Select role services**, click **Next**.

12. In **Confirm installation selections**, review the choices you've made, and then click **Install**.

13. When the installation is complete, click **Close**.

## STEP 2: Configure Remote Access as a VPN Server

Configure the Remote Access VPN to allow IKEv2 VPN connections, deny connections from other VPN protocols, and assign a static IP address pool for issuance of IP addresses to connecting authorized VPN clients.

1. On the VPN server, in Server Manager, click the **Notifications** flag.
2. In the **Tasks** menu, click **Open the Getting Started Wizard**.<br><br>The Configure Remote Access wizard opens.

	>[!NOTE]
	>The Configure Remote Access wizard might open behind Server Manager. If you think the wizard is taking too long to open, move or minimize Server Manager to find out whether the wizard is behind it. If not, wait for the wizard to initialize.

3.  In **Configure Remote Access**, click **Deploy VPN only**.<br><br>The Routing and Remote Access Microsoft Management Console \(MMC\) opens.

4.  Right-click the VPN server, and click **Configure and Enable Routing and Remote Access**.<br><br>The Routing and Remote Access Server Setup Wizard opens. 
5.  In the Routing and Remote Access Server Setup Wizard, click **Next**.

6.  In **Configuration**, click **Custom Configuration**, and then click **Next**.

7.  In **Custom Configuration**, click **VPN access**, and then click **Next**.<br><br>The Completing the Routing and Remote Access Server Setup Wizard opens.

8.  Click **Finish** to close the wizard, and click **OK** to close the Routing and Remote Access dialog box.

9.  Click **Start service** to start Remote Access.

10.  In the Remote Access MMC, right\-click the VPN server, and click **Properties**.

11.  In **Properties**, click the **IPv4** tab and do the following:
    a. click **Static address pool**.

    b.  Click **Add** to configure an IP address pool.<br><br>The static address pool should contain addresses from the internal perimeter network. These addresses are on the internal-facing network connection on the VPN server, not the corporate network.

    c.  In **Start IP address**, type the starting IP address in the range you want to assign to VPN clients.

    d.  In **End IP address**, type the ending IP address in the range you want to assign to VPN clients, or in **Number of addresses**, type the number of address you want to make available.

	>[!NOTE]
	>If you’re using DHCP for this subnet, ensure that you configure a corresponding address exclusion on your DHCP servers.

    e.  Click **Adapter**.<br><br>The resulting list displays the network adapters that are installed. 
    f. Click the Ethernet adapter that is connected to your internal perimeter network.

12. In **Properties**, click the **Security** tab and do the following:
    a. Click **Authentication provider** and click **RADIUS Authentication**. 
    b. Click **Configure**.<br><br>The RADIUS Authentication dialog box opens.
    c. Click **Add**.<br><br>The Add RADIUS Server dialog box opens.
    d. In **Server name**, type the Fully Qualified Domain Name (FQDN) of the NPS server on your Organization/Corporate network.<br><br>For example, if the NetBIOS name of your NPS server is NPS1 and your domain name is corp.contoso.com, type **NPS1.corp.contoso.com**.
    e. In **Shared secret**, click **Change**.<br><br>The Change Secret dialog box opens.
    f. In **New secret**, type a text string. 
    g. In **Confirm new secret**, type the same text string, and then click **OK**. 

    >![IMPORTANT]
    >Save this text string. When you configure the NPS Server on your Organization/Corporate network, you will add this VPN Server as a RADIUS Client. During that configuration, you will use this same shared secret so that the NPS and VPN Servers can communicate.

    h. In **Add RADIUS Server**, review the default settings for **Time-out**, **Initial score**, and **Port**. If necessary, change the values to match the requirements for your environment, and then click **OK**.

13. In **Properties**, click the **Security** tab, review the setting for **Accounting provider**.<br><br>If you want Remote Access activity logged on the Remote Access server, ensure that **Windows Accounting** is selected. If you want your NPS server to perform accounting services for VPN, change **Accounting provider** to **RADIUS Accounting**, and then configure the NPS server as the accounting provider.

14.  Click **OK** to close the **Properties** dialog box.

15.  In the Routing and Remote Access MMC, right-click **Ports,** and then click **Properties**.<br><br>The Ports Properties dialog box opens.

16.  Click **WAN Miniport \(SSTP\)** and do the following:
    a. Click **Configure**.<br><br>The Configure Device - WAN Miniport \(SSTP\) dialog box opens.
    b. Clear the **Remote access connections \(inbound only\)** and **Demand-dial routing connections \(inbound and outbound\)** check boxes.
    c. Click **OK**.
17. Click **WAN Miniport \(L2TP\)** and do the following:
    a. Click **Configure**.<br><br>The Configure Device - WAN Miniport \(IKEv2\) dialog box opens.
    b. In **Maximum ports**, type the number of ports to match the maximum number of simultaneous VPN connections that you want to support.
    c. Click **OK**.
18. Click **WAN Miniport \(PPTP\)** and do the following:
    a. Click **Configure**.<br><br>The Configure Device - WAN Miniport \(IKEv2\) dialog box opens.
    b. In **Maximum ports**, type the number of ports to match the maximum number of simultaneous VPN connections that you want to support.
    c. Click **OK**.
    d. In **Maximum ports**, type the number of ports to match the maximum number of simultaneous VPN connections that you want to support.
    e. Click **OK**.

19. If prompted, click **Yes** to confirm restarting the server.

20. If prompted, click **Close** to restart the server.

## Next steps
**[Install and Configure the NPS Server](vpn-deploy-nps.md)**. Install Network Policy Server \(NPS\) and perform configuration for Always On VPN.