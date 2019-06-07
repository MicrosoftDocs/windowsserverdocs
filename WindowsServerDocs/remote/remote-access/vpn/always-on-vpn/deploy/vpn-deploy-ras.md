---
title: Configure the Remote Access Server for Always On VPN
description: RRAS is designed to perform well as both a router and a remote access server; therefore, it supports a wide array of features. 
ms.prod: windows-server-threshold
ms.technology: networking-ras
ms.topic: article
ms.assetid: 
ms.localizationpriority: medium 
ms.author: pashort
author: shortpatti
ms.date: 08/30/2018
ms.reviewer: deverette
---

# Step 3. Configure the Remote Access Server for Always On VPN

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

- [**Previous:** Step 2. Configure the Server Infrastructure](vpn-deploy-server-infrastructure.md)
- [**Previous:** Step 4. Install and configure the Network Policy Server (NPS)](vpn-deploy-nps.md)

RRAS is designed to perform well as both a router and a remote access server because it supports a wide array of features. For the purposes of this deployment, you require only a small subset of these features: support for IKEv2 VPN connections and LAN routing.

IKEv2 is a VPN tunneling protocol described in Internet Engineering Task Force Request for Comments 7296. The primary advantage of IKEv2 is that it tolerates interruptions in the underlying network connection. For example, if the connection is temporarily lost or if a user moves a client computer from one network to another, IKEv2 automatically restores the VPN connection when the network connection is reestablished—all without user intervention.

Configure the RRAS server to support IKEv2 connections while disabling unused protocols, which reduces the server’s security footprint. Additionally, configure the server to assign addresses to VPN clients from a static address pool. You can feasibly assign addresses from either a pool or a DHCP server; however, using a DHCP server adds complexity to the design and delivers minimal benefits.

>[!IMPORTANT]
>It is important to:
>- Install two Ethernet network adapters in the physical server. If you are installing the VPN server on a VM, you must create two External virtual switches, one for each physical network adapter; and then create two virtual network adapters for the VM, with each network adapter connected to one virtual switch.
>
>- Install the server on your perimeter network between your edge and internal firewalls, with one network adapter connected to the External Perimeter Network, and one network adapter connected to the Internal Perimeter Network.

>[!WARNING]
>Before you get started, make sure to enable IPv6 on the VPN server. Otherwise, a connection cannot be established and an error message displays.

## Install Remote Access as a RAS Gateway VPN Server

In this procedure, you install the Remote Access role as a single tenant RAS Gateway VPN server. For more information, see [Remote Access](../../../Remote-Access.md).

### Install the Remote Access role by using Windows PowerShell

1. Open Windows PowerShell as **Administrator**.

2. Enter and run the following cmdlet:

   ```powershell
   Install-WindowsFeature DirectAccess-VPN -IncludeManagementTools
   ```

   After installation completes, the following message appears in Windows PowerShell.

   ```powershell
   | Success | Restart Needed | Exit Code |               Feature Result               |
   |---------|----------------|-----------|--------------------------------------------|
   |  True   |       No       |  Success  | {RAS Connection Manager Administration Kit |
   ```

### Install the Remote Access role by using Server Manager

You can use the following procedure to install the Remote Access role using Server Manager.

1. On the VPN server, in Server Manager, select **Manage** and select **Add Roles and Features**.
   
   The Add Roles and Features Wizard opens.

2. On the Before you begin page, select **Next**.

3. On the Select Installation Type page, select the **Role-Based or feature-based installation** option and select **Next**.

4. On the Select destination server page, select the **Select a server from the server pool** option.

5. Under Server Pool, select the local computer and select **Next**.

6. On the Select server roles page, in **Roles**, select **Remote Access**, then **Next**.

7. On the Select features page, select **Next**.

8. On the Remote Access page, select **Next**.

9.  On the Select role service page, in **Role services**, select **DirectAccess and VPN (RAS)**.

   The **Add Roles and Features Wizard** dialog box opens.

11. On the Add Roles and Features dialog, select **Add Features** then select **Next**.

12. On the Web Server Role (IIS) page, select **Next**.

13. On the Select role services page, select **Next**.

14. On the Confirm installation selections page, review your choices, then select **Install**.

15. When the installation is complete, select **Close**.

## Configure Remote Access as a VPN Server

In this section, you can configure Remote Access VPN to allow IKEv2 VPN connections, deny connections from other VPN protocols, and assign a static IP address pool for the issuance of IP addresses to connecting authorized VPN clients.

1. On the VPN server, in Server Manager, select the **Notifications** flag.

2. In the **Tasks** menu, select **Open the Getting Started Wizard**

   The Configure Remote Access wizard opens.

   >[!NOTE]
   >The Configure Remote Access wizard might open behind Server Manager. If you think the wizard is taking too long to open, move or minimize Server Manager to find out whether the wizard is behind it. If not, wait for the wizard to initialize.

3. Select **Deploy VPN only**.

    The Routing and Remote Access Microsoft Management Console (MMC) opens.

4. Right-click the VPN server, then select **Configure and Enable Routing and Remote Access**.

   The Routing and Remote Access Server Setup Wizard opens.

5. In the Welcome to the Routing and Remote Access Server Setup Wizard, select **Next**.

6. In **Configuration**, select **Custom Configuration**, and then select **Next**.

7. In **Custom Configuration**, select **VPN access**, and then select **Next**.

   The Completing the Routing and Remote Access Server Setup Wizard opens.

8. Select **Finish** to close the wizard, then select **OK** to close the Routing and Remote Access dialog box.

9. Select **Start service** to start Remote Access.

10. In the Remote Access MMC, right-click the VPN server, then select **Properties**.

11. In Properties, select the **Security** tab and do:

    a. Select **Authentication provider** and select **RADIUS Authentication**.

    b. Select **Configure**.

       The RADIUS Authentication dialog box opens.

    c. Select **Add**.

       The Add RADIUS Server dialog box opens.

    d. In **Server name**, enter the Fully Qualified Domain Name (FQDN) of the NPS server on your Organization/Corporate network.
    
       For example, if the NetBIOS name of your NPS server is NPS1 and your domain name is corp.contoso.com, enter **NPS1.corp.contoso.com**.

    e. In **Shared secret**, select **Change**.

       The Change Secret dialog box opens.

    f. In **New secret**, enter a text string.

    g. In **Confirm new secret**, enter the same text string, then select **OK**.

    >[!IMPORTANT]
    >Save this text string. When you configure the NPS Server on your Organization/Corporate network, you will add this VPN Server as a RADIUS Client. During that configuration, you will use this same shared secret so that the NPS and VPN Servers can communicate.

12. In **Add RADIUS Server**, review the default settings for:

    - **Time-out**

    - **Initial score**

    - **Port**

13. If necessary, change the values to match the requirements for your environment and select **OK**.

    A NAS is a device that provides some level of access to a larger network. A NAS using a RADIUS infrastructure is also a RADIUS client, sending connection requests and accounting messages to a RADIUS server for authentication, authorization, and accounting.

14. Review the setting for **Accounting provider**:

    |                    If you want the...                     |                                                     Then…                                                      |
    |-----------------------------------------------------------|----------------------------------------------------------------------------------------------------------------|
    | Remote Access activity logged on the Remote Access server |                               Make sure that **Windows Accounting** is selected.                               |
    |        NPS to perform accounting services for VPN         | Change **Accounting provider** to **RADIUS Accounting** and then configure the NPS as the accounting provider. |

15. Select the **IPv4** tab and do:

    a. Select **Static address pool**.

    b. Select **Add** to configure an IP address pool.

       The static address pool should contain addresses from the internal perimeter network. These addresses are on the internal-facing network connection on the VPN server, not the corporate network.

    c. In **Start IP address**, enter the starting IP address in the range you want to assign to VPN clients.

    d. In **End IP address**, enter the ending IP address in the range you want to assign to VPN clients, or in **Number of addresses**, enter the number of the address you want to make available. If you’re using DHCP for this subnet, ensure that you configure a corresponding address exclusion on your DHCP servers.

    e. (Optional) If you are using DHCP, select **Adapter**, and in the list of results, select the Ethernet adapter connected to your internal perimeter network.

16. (Optional) *If you are configuring conditional access for VPN connectivity*, from the **Certificate** drop-down list, under **SSL Certificate Binding**, select the VPN server authentication.

17. (Optional) *If you are configuring conditional access for VPN connectivity*, in the NPS MMC, expand **Policies\\Network Policies** and do: 

    a. Right-the **Connections to Microsoft Routing and Remote Access Server** network policy and select **Properties**.

    b. Select the **Grant access. Grant access if the connection request matches this policy** option.

    c. Under Type of network access server, select **Remote Access Server (VPN-Dial up)** from the drop-down.

18. In the Routing and Remote Access MMC, right-click **Ports,** and then select **Properties**. 
    
    The Ports Properties dialog box opens.

19. Select **WAN Miniport (SSTP)** and select **Configure**. The Configure Device - WAN Miniport (SSTP) dialog box opens.

    a. Clear the **Remote access connections (inbound only)** and **Demand-dial routing connections (inbound and outbound)** check boxes.

    b. Select **OK**.

20. Select **WAN Miniport (L2TP)** and select **Configure**. The Configure Device - WAN Miniport (L2TP) dialog box opens.

    a. In **Maximum ports**, enter the number of ports to match the maximum number of simultaneous VPN connections that you want to support.

    b. Select **OK**.

21. Select **WAN Miniport (PPTP)** and select **Configure**. The Configure Device - WAN Miniport (PPTP) dialog box opens.

    a. In **Maximum ports**, enter the number of ports to match the maximum number of simultaneous VPN connections that you want to support.

    b. Select **OK**.

22. Select **WAN Miniport (IKEv2)** and select **Configure**. The Configure Device - WAN Miniport (IKEv2) dialog box opens.

     a. In **Maximum ports**, enter the number of ports to match the maximum number of simultaneous VPN connections that you want to support.

     b. Select **OK**.

23. If prompted, select **Yes** to confirm restarting the server and select **Close** to restart the server.

## Next step

[Step 4. Install and configure the Network Policy Server (NPS)](vpn-deploy-nps.md): In this step, you install Network Policy Server (NPS) by using either Windows PowerShell or the Server Manager Add Roles and Features Wizard. You also configure NPS to handle all authentication, authorization, and accounting duties for connection requests that it receives from the VPN server.
