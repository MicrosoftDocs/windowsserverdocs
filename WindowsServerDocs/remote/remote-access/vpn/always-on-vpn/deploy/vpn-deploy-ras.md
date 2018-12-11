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

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

&#171;  [**Previous:** Step 2. Configure the Server Infrastructure](vpn-deploy-server-infrastructure.md)<br>
&#187;  [**Previous:** Step 4. Install and configure the Network Policy Server (NPS)](vpn-deploy-nps.md)


RRAS is designed to perform well as both a router and a remote access server because it supports a wide array of features. For the purposes of this deployment, you require only a small subset of these features: support for IKEv2 VPN connections and LAN routing.

IKEv2 is a VPN tunneling protocol described in Internet Engineering Task Force Request for Comments 7296. The primary advantage of IKEv2 is that it tolerates interruptions in the underlying network connection. For example, if the connection is temporarily lost or if a user moves a client computer from one network to another, IKEv2 automatically restores the VPN connection when the network connection is reestablished—all without user intervention.

Configure the RRAS server to support IKEv2 connections while disabling unused protocols, which reduces the server’s security footprint. Additionally, configure the server to assign addresses to VPN clients from a static address pool. You can feasibly assign addresses from either a pool or a DHCP server; however, using a DHCP server adds complexity to the design and delivers minimal benefits.


>[!Important]
>It is important to:
>- Install two Ethernet network adapters in the physical server. If you are installing the VPN server on a VM, you must create two External virtual switches, one for each physical network adapter; and then create two virtual network adapters for the VM, with each network adapter connected to one virtual switch.
>
>- Install the server on your perimeter network between your edge and internal firewalls, with one network adapter connected to the External Perimeter Network, and one network adapter connected to the Internal Perimeter Network.


>[!Warning]
>Before you get started, make sure to enable IPv6 on the VPN server. Otherwise, a connection cannot be established and an error message displays.

## Install Remote Access as a RAS Gateway VPN Server

In this procedure, you install the Remote Access role as a single tenant RAS Gateway VPN server. For more information, see [Remote Access](../../../Remote-Access.md).


### Install the Remote Access role by using Windows PowerShell

1. Open Windows PowerShell as **Administrator**.

2. Type the following command and press **ENTER**:

   `Install-WindowsFeature DirectAccess-VPN -IncludeManagementTools`

   After installation completes, the following message appears in Windows PowerShell.
    
   | Success | Restart Needed | Exit Code | Feature Result                             |
   |---------|----------------|-----------|--------------------------------------------|
   | True    | No             | Success   | {RAS Connection Manager Administration Kit |
   ---

### Install the Remote Access role by using Server Manager

You can use the following procedure to install the Remote Access role using Server Manager.

1.  On the VPN server, in Server Manager, click **Manage** and click **Add Roles and Features**. <p>The Add Roles and Features Wizard opens.

2.  On the Before you begin page, click **Next**.

3.  On the Select Installation Type page, select the **Role-Based or feature-based installation** option and click **Next**.

4.  On the Select destination server page, select the **Select a server from the server pool** option.

5.  Under Server Pool, select the local computer and click **Next**.

6.  On the Select server roles page, in **Roles**, click **Remote Access**, and
    then **Next**.

7.  On the Select features page, click **Next**.

8.  On the Remote Access page, click **Next**.

9.  On the Select role service page, in **Role services**, click **DirectAccess and VPN (RAS)**.<p>The **Add Roles and Features Wizard** dialog box opens.

10. On the Add Roles and Features dialog, click **Add Features** and click **Next**.

11. On the Web Server Role (IIS) page, click **Next**.

12. On the Select role services page, click **Next**.

13. On the Confirm installation selections page, review your choices, and click **Install**.

14. When the installation is complete, click **Close**.

## Configure Remote Access as a VPN Server

In this section, you can configure Remote Access VPN to allow IKEv2 VPN connections, deny connections from other VPN protocols, and assign a static IP address pool for the issuance of IP addresses to connecting authorized VPN clients.

1.  On the VPN server, in Server Manager, click the **Notifications** flag.

2.  In the **Tasks** menu, click **Open the Getting Started Wizard**.<p>The Configure Remote Access wizard opens. 

    >[!NOTE] 
    >The Configure Remote Access wizard might open behind Server Manager. If you think the wizard is taking too long to open, move or minimize Server Manager to find out whether the wizard is behind it. If not, wait for the wizard to initialize.

3.  Click **Deploy VPN only**.<p>The Routing and Remote Access Microsoft Management Console (MMC) opens.

4.  Right-click the VPN server, and click **Configure and Enable Routing and Remote Access**.<p>The Routing and Remote Access Server Setup Wizard opens.

5.  In the Welcome to the Routing and Remote Access Server Setup Wizard, click **Next**.

6.  In **Configuration**, click **Custom Configuration**, and then click **Next**.

7.  In **Custom Configuration**, click **VPN access**, and then click **Next**.<p>The Completing the Routing and Remote Access Server Setup Wizard opens.

8.  Click **Finish** to close the wizard, and click **OK** to close the Routing and Remote Access dialog box.

9.  Click **Start service** to start Remote Access.

10. In the Remote Access MMC, right-click the VPN server, and click **Properties**.

11. In Properties, click the **Security** tab and do:

    a. Click **Authentication provider** and click **RADIUS Authentication**.
    
    b. Click **Configure**.<p>The RADIUS Authentication dialog box opens.
    
    c. Click **Add**.<p>The Add RADIUS Server dialog box opens.
    
    d. In **Server name**, type the Fully Qualified Domain Name (FQDN) of the NPS server on your Organization/Corporate network.<p>For example, if the NetBIOS name of your NPS server is NPS1 and your domain name is corp.contoso.com, type **NPS1.corp.contoso.com**.
    
    e. In **Shared secret**, click **Change**.<p>The Change Secret dialog box opens.
    
    f. In **New secret**, type a text string.
    
    g. In **Confirm new secret**, type the same text string, and click **OK**.

    >[!IMPORTANT] 
    >Save this text string. When you configure the NPS Server on your Organization/Corporate network, you will add this VPN Server as a RADIUS Client. During that configuration, you will use this same shared secret so that the NPS and VPN Servers can communicate.

12. In **Add RADIUS Server**, review the default settings for:

    - **Time-out**
    
    - **Initial score**
    
    - **Port**

13. If necessary, change the values to match the requirements for your environment and click **OK**.<p>A NAS is a device that provides some level of access to a larger network. A NAS using a RADIUS infrastructure is also a RADIUS client, sending connection requests and accounting messages to a RADIUS server for authentication, authorization, and accounting.

14. Review the setting for **Accounting provider**:

    | If you want the...  | Then…             |
    |---------------------|-------------------|
    | Remote Access activity logged on the Remote Access server | Make sure that **Windows Accounting** is selected.      |
    | NPS to perform accounting services for VPN   | Change **Accounting provider** to **RADIUS Accounting** and then configure the NPS as the accounting provider. |
    ---

15. Click the **IPv4** tab and do:

    a. Click **Static address pool**.
    
    b. Click **Add** to configure an IP address pool.<p>The static address pool should contain addresses from the internal perimeter network. These addresses are on the internal-facing network connection on the VPN server, not the corporate network.
    
    c. In **Start IP address**, type the starting IP address in the range you want to assign to VPN clients.
    
    d. In **End IP address**, type the ending IP address in the range you want to assign to VPN clients, or in **Number of addresses**, type the number of the address you want to make available. If you’re using DHCP for this subnet, ensure that you configure a corresponding address exclusion on your DHCP servers.
    
    e. (Optional) If you are using DHCP, click **Adapter**, and in the list of results, click the Ethernet adapter connected to your internal perimeter network.

16. (Optional) *If you are configuring conditional access for VPN connectivity*, from the **Certificate** drop-down list, under **SSL Certificate Binding**, select the VPN server authentication.

17. (Optional) *If you are configuring conditional access for VPN connectivity*, in the NPS MMC, expand **Policies\\Network Policies** and do: 

    a. Right-the **Connections to Microsoft Routing and Remote Access Server** network policy and select **Properties**.
    
    b. Select the **Grant access. Grant access if the connection request matches this policy** option.
    
    c. Under Type of network access server, select **Remote Access Server (VPN-Dial up)** from the drop-down.

3.  In the Routing and Remote Access MMC, right-click **Ports,** and then click **Properties**. <p>The Ports Properties dialog box opens.

4.  Click **WAN Miniport (SSTP)** and click **Configure**. The Configure Device - WAN Miniport (SSTP) dialog box opens.

    a. Clear the **Remote access connections (inbound only)** and **Demand-dial routing connections (inbound and outbound)** check boxes.
    
    b. Click **OK**.

5.  Click **WAN Miniport (L2TP)** and click **Configure**. The Configure Device - WAN Miniport (L2TP) dialog box opens.

    a. In **Maximum ports**, type the number of ports to match the maximum number of simultaneous VPN connections that you want to support.
    
    b. Click **OK**.

6.  Click **WAN Miniport (PPTP)** and click **Configure**. The Configure Device - WAN Miniport (PPTP) dialog box opens.

    a. In **Maximum ports**, type the number of ports to match the maximum number of simultaneous VPN connections that you want to support.
    
    b. Click **OK**.
    
7. Click **WAN Miniport (IKEv2)** and click **Configure**. The Configure Device - WAN Miniport (IKEv2) dialog box opens.

    a. In **Maximum ports**, type the number of ports to match the maximum number of simultaneous VPN connections that you want to support.
    
    b. Click **OK**.

7.  If prompted, click **Yes** to confirm restarting the server and click **Close** to restart the server.

## Next step
[Step 4. Install and configure the Network Policy Server (NPS)](vpn-deploy-nps.md): In this step, you install Network Policy Server (NPS) by using either Windows PowerShell or the Server Manager Add Roles and Features Wizard. You also configure NPS to handle all authentication, authorization, and accounting duties for connection requests that it receives from the VPN server.





---
