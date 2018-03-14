---
title: Configure the Remote Access Server for Always On VPN
description: This topic provides detailed instructions for deploying Always On VPN in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 7607a9b7-c9a4-4c4d-8a62-2d4c422e2a1f
manager: brianlic
ms.author: pashort
author: shortpatti
ms.date: 3/4/2018
---
# STEP 4: Configure the Remote Access Server for Always On VPN

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

The next step in the Always On VPN deployment process is to install and configure the Remote Access server role on the VPN server.

The Remote Access server role includes:

-   Remote Access Service (RAS)

-   Local area network (LAN) Routing

-   Web Application Proxy

RAS allows you to provide network connectivity to remote employees, site-to-site VPN to connect remote office locations over the Internet, and the RAS Gateway,
which has multitenant and Border Gateway Protocol (BGP) capabilities for Enterprises and Cloud Service Providers (CSPs).

When you install the Remote Access server role service, you are deploying the Remote Access Service Gateway (**RAS Gateway**). You can deploy RAS Gateway as a
single tenant RAS Gateway virtual private network (VPN) server that provides many advanced features and enhanced functionality.

>[!NOTE] 
>You can also deploy RAS Gateway as a Multitenant VPN server for use with Software Defined Networking (SDN), or as a DirectAccess server. For more information, see [RAS Gateway](https://docs.microsoft.com/windows-server/remote/remote-access/ras-gateway/ras-gateway), [Software Defined Networking (SDN)](https://docs.microsoft.com/windows-server/networking/sdn/software-defined-networking), and [DirectAccess](https://docs.microsoft.com/windows-server/remote/remote-access/directaccess/directaccess).

## Prerequisites

Membership in **Administrators**, or equivalent, is the minimum required to perform these procedures.

## STEP 4.1: Install Remote Access as a RAS Gateway VPN Server

Install the Remote Access role as a single tenant RAS Gateway VPN server. For more information, see [Remote Access](https://docs.microsoft.com/windows-server/remote/remote-access/remote-access).

### Windows PowerShell

1.  Run Windows PowerShell as Administrator.

2.  Type the following command:  
      
    `Install-WindowsFeature DirectAccess-VPN -IncludeManagementTools`

3.  Press ENTER.

After the installation completes, the following message appears in Windows
PowerShell.

| Success | Restart Needed | Exit Code | Feature Result                             |
|---------|----------------|-----------|--------------------------------------------|
| True    | No             | Success   | {RAS Connection Manager Administration Kit |

### Server Manager

1.  On the VPN server, in Server Manager, click **Manage**, and then click **Add  Roles and Features**.<br><br>The Add Roles and Features Wizard opens.

2.  In **Before you begin**, click **Next**.

3.  In **Select Installation Type**, ensure that **Role-Based or feature-based installation** is selected, and click **Next**.

4.  In **Select destination server**, ensure that **Select a server from the server pool** is selected.

5.  In **Server Pool**, ensure that the local computer is selected, and click **Next**.

6.  In **Select server roles**, in **Roles**, click **Remote Access**, and click **Next**.

7.  In **Select features**, click **Next**.

8.  In **Remote Access**, click **Next**.

9.  In **Select role service**, in **Role services**, click **DirectAccess and  VPN (RAS)**.<br><br>The Add Roles and Features Wizard dialog box opens.

10. Click **Add Features** to close the dialog box, and then click **Next**.

11. In **Web Server Role (IIS)**, click **Next**.

12. In **Select role services**, click **Next**.

13. In **Confirm installation selections**, review the choices you've made, and then click **Install**.

14. When the installation is complete, click **Close**.

## STEP 4.2: Configure Remote Access as a VPN Server

Configure the Remote Access VPN to allow IKEv2 VPN connections, deny connections from other VPN protocols, and assign a static IP address pool for issuance of IP addresses to connecting authorized VPN clients.

**Procedure:**

1.  On the VPN server, in Server Manager, click the **Notifications** flag.

2.  In the **Tasks** menu, click **Open the Getting Started Wizard**.<br><br>The Configure Remote Access wizard opens.
    >[!NOTE] 
    >The Configure Remote Access wizard might open behind Server Manager. If you think the wizard is taking too long to open, move or minimize Server Manager to find out whether the wizard is behind it. If not, wait for the wizard to initialize.

3.  Click **Deploy VPN only**.<br><br>The Routing and Remote Access Microsoft Management Console (MMC) opens.

2.  Right-click the VPN server, and click **Configure and Enable Routing and Remote Access**.<br><br>The Routing and Remote Access Server Setup Wizard opens.

3.  Click **Next**.

4.  In **Configuration**, click **Custom Configuration**, and then click **Next**.

5.  In **Custom Configuration**, click **VPN access**, and then click **Next**.<br><br>The Completing the Routing and Remote Access Server Setup Wizard opens.

6.  Click **Finish** to close the wizard, and click **OK** to close the Routing and Remote Access dialog box.

7.  Click **Start service** to start Remote Access.

8.  In the Remote Access MMC, right-click the VPN server, and click  **Properties**.

9.  Click the **IPv4** tab and do the following:

    a.  Click **Static address pool**.

    b.  Click **Add** to configure an IP address pool.<br><br>The static address pool should contain addresses from the internal perimeter network. These addresses are on the internal-facing network connection on the VPN server, not the corporate network.

    c.  In **Start IP address**, type the starting IP address in the range you want to assign to VPN clients.

    d.  In **End IP address**, type the ending IP address in the range you want to assign to VPN clients, or in **Number of addresses**, type the number of the address you want to make available.

    >[!NOTE] 
    >If you’re using DHCP for this subnet, ensure that you configure a corresponding address exclusion on your DHCP servers.

10. Click **Adapter**.<br><br>The resulting list displays the network adapters installed.

11. Click the Ethernet adapter connected to your internal perimeter network.

12. In Properties, click the **Security** tab and do the following:

    a.  Click **Authentication provider** and click **RADIUS Authentication**.

    b.  Click **Configure**.<br><br>The RADIUS Authentication dialog box opens.

    c.  Click **Add**.<br><br>The Add RADIUS Server dialog box opens.

    d.  In **Server name**, type the Fully Qualified Domain Name (FQDN) of the NPS server on your Organization/Corporate network.<br><br>For example, if the NetBIOS name of your NPS server is NPS1 and your domain name is corp.contoso.com, type **NPS1.corp.contoso.com**.

    e.  In **Shared secret**, click **Change**.<br><br>The Change Secret dialog box opens.

    f.  In **New secret**, type a text string.

    g.  In **Confirm new secret**, type the same text string, and click **OK**.

    >[!IMPORTANT] 
    >Save this text string. When you configure the NPS Server on your Organization/Corporate network, you will add this VPN Server as a RADIUS Client. During that configuration, you will use this same shared secret so that the NPS and VPN Servers can communicate.

13. In **Add RADIUS Server**, review the default settings for:

    -   **Time-out**

    -   **Initial score**

    -   **Port** If necessary, change the values to match the requirements for your environment<br><br>A NAS is a device that provides some level of access to a larger network. A NAS using a RADIUS infrastructure is also a RADIUS client, sending connection requests and accounting messages to a RADIUS server for authentication, authorization, and accounting.

14. Click **OK**.

15. Review the setting for **Accounting provider**.

    | If you want the...          | Then…            |
    |-------------------|------|
    | Remote Access activity logged on the Remote Access server | Make sure that **Windows Accounting** is selected.                                                             |
    | NPS to perform accounting services for VPN                | Change **Accounting provider** to **RADIUS Accounting** and then configure the NPS as the accounting provider. |

16. In the Routing and Remote Access MMC, right-click **Ports,** and then click **Properties**.<br><br>The Ports Properties dialog box opens.

17. Click **WAN Miniport (SSTP)** and click **Configure**.<br><br>The Configure Device - WAN Miniport (SSTP) dialog box opens.

    a.  Clear the **Remote access connections (inbound only)** and **Demand-dial routing connections (inbound and outbound)** check boxes.

    b.  Click **OK**.

18. Click **WAN Miniport (L2TP)** and click **Configure**.<br><br>The Configure Device - WAN Miniport (IKEv2) dialog box opens.

    a.  In **Maximum ports**, type the number of ports to match the maximum
        number of simultaneous VPN connections that you want to support.

    b.  Click **OK**.

19. Click **WAN Miniport (PPTP)** and click **Configure**.<br><br>The Configure Device - WAN Miniport (IKEv2) dialog box opens.

    a.  In **Maximum ports**, type the number of ports to match the maximum number of simultaneous VPN connections that you want to support.

    b.  Click **OK**.

    c.  In **Maximum ports**, type the number of ports to match the maximum number of simultaneous VPN connections that you want to support.

    d.  Click **OK**.

20. If prompted, click **Yes** to confirm restarting the server and click **Close** to restart the server.

## Next steps

[STEP 5: Install and Configure the NPS Server](vpn-deploy-nps.md). Install Network Policy Server (NPS) and perform configuration for Always On VPN.