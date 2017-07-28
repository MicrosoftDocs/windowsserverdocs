---
title: Configure the Remote Access Server and NPS Server for Always On VPN
description: This topic provides detailed instructions for deploying Always On VPN in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 7607a9b7-c9a4-4c4d-8a62-2d4c422e2a1f
manager: brianlic
ms.author: jamesmci
author: jamesmci
---

# Configure the Remote Access Server and NPS Server for Always On VPN

>Applies To: Windows Server 2016, Windows 10

You can use this section to install and configure the following items on two different computers that are installed on different network segments. The two computers and configuration items are listed below.

## VPN/NPS proxy server

1. On the computer or virtual machine \(VM\) that is planned as the VPN server, and that is installed on your perimeter network, you can install both Remote Access and Network Policy Server \(NPS\). 

2. On the Remote Access - NPS proxy server, you can configure Remote Access as a RAS Gateway VPN server.

3. On the Remote Access - NPS server, you can configure NPS as a Remote Authentication Dial\-In User Service \(RADIUS\) proxy server. The proxy server does not process connection requests from VPN clients; instead, the proxy forwards connection requests to the NPS server for processing. 

>[!NOTE]
>NPS server processing of connection requests includes performing authorization - to verify that the user has permission to connect; performing authentication - to verify the user's identity; and performing accounting - to log the aspects of the connection request that you chose when you configured RADIUS accounting in NPS.

## Organization/Corporate NPS server

1. On the computer or VM that is planned as the NPS server, and that is installed on your organization or corporate network, you can install NPS.

2. On the organization/corporate NPS server, you can configure NPS to perform as a RADIUS server that processes the connection requests that are received from the VPN/NPS proxy server.

>[!NOTE]
>For optimum performance, it is recommended that you install the organization/corporate NPS server on a domain controller. For more information, see [Network Policy Server Best Practices](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-best-practices).

You can perform these installations with the following instructions by using either Windows PowerShell or the Server Manager Add Roles and Features Wizard.

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

## Install Network Policy Server

You can use this section to install Network Policy Server \(NPS\) by using either Windows PowerShell or the Add Roles and Features Wizard. NPS is a role service of the Network Policy and Access Services server role.

> [!NOTE]
> By default, NPS listens for RADIUS traffic on ports 1812, 1813, 1645, and 1646 on all installed network adapters. If Windows Firewall with Advanced Security is enabled when you install NPS, firewall exceptions for these ports are automatically created during the installation process for both Internet Protocol version 6 \(IPv6\) and IPv4 traffic. If your network access servers are configured to send RADIUS traffic over ports other than these defaults, remove the exceptions created in Windows Firewall with Advanced Security during NPS installation, and create exceptions for the ports that you do use for RADIUS traffic.

**Administrative Credentials**

To complete this procedure, you must be a member of the **Domain Admins** group.

### To install NPS by using Windows PowerShell

To perform this procedure by using Windows PowerShell, run Windows PowerShell as Administrator, type the following command, and then press ENTER.

`Install-WindowsFeature NPAS -IncludeManagementTools`

### To install NPS by using Server Manager

You can use the following procedure to install NPS using Server Manager.

1.  In Server Manager, click **Manage**, and then click **Add Roles and Features**. The Add Roles and Features Wizard opens.

2.  In **Before You Begin**, click **Next**.

    > [!NOTE]
    > The **Before You Begin** page of the Add Roles and Features Wizard is not displayed if you have previously selected **Skip this page by default** when the Add Roles and Features Wizard was run.

3.  In **Select Installation Type**, ensure that **Role-Based or feature-based installation** is selected, and then click **Next**.

4.  In **Select destination server**, ensure that **Select a server from the server pool** is selected. In **Server Pool**, ensure that the local computer is selected. Click **Next**.

5.  In **Select Server Roles**, in **Roles**, select **Network Policy and Access Services**. A dialog box opens asking if it should add features that are required for Network Policy and Access Services. Click **Add Features**, and then click **Next**

6.  In **Select features**, click **Next**, and in **Network Policy and Access Services**, review the information that is provided, and then click **Next**.

7.  In **Select role services**, click **Network Policy Server**.  In **Add features that are required for Network Policy Server**, click **Add Features**. Click **Next**.

8.  In **Confirm installation selections**, click **Restart the destination server automatically if required**. When you are prompted to confirm this selection, click **Yes**, and then click **Install**. The Installation progress page displays status during the installation process. When the process completes, the message "Installation succeeded on *ComputerName*" is displayed, where *ComputerName* is the name of the computer upon which you installed Network Policy Server. Click **Close**.

For more information, see [Manage NPS Servers](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-manage-top).

## Configure Remote Access as a VPN Server

In this section, you configure Remote Access VPN to allow IKEv2 VPN connections, deny connections from other VPN protocols, and assign a static IP address pool for issuance of IP addresses to connecting authorized VPN clients.

### To Remote Access as a VPN Server

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

## Configure NPS

NPS handles all authentication, authorization, and accounting duties for RRAS. Essentially, when clients connect to the RRAS server, the server forwards the authentication request to NPS along with pertinent connection details.

In this design, the VPN server is on a separate system from the NPS server to improve security. In RRAS, you use the NPS role on the VPN server as a RADIUS proxy. RRAS on the VPN server forwards any authentication requests to the local NPS role; the NPS role forwards the request to the NPS server on the corporate network, which evaluates it.

The internal NPS server then steps through policies, one by one, until it finds a policy whose conditions match those of the client. After identifying this policy, the NPS server evaluates it to determine whether the client’s authentication request meets the requirements set forth in the policy’s conditions. If it does, the NPS server applies the constraints and settings defined in the policy to the connection, forwards this information to the RRAS server, and allows the connection.

## Configure Policies on NPS servers

In this scenario, you must define two NPS policies - one on the NPS server, and one on the NPS proxy server \(which is also the VPN server\).

On the NPS server, you define a policy that allows only users in a specific group to access the VPN, and then only when using a valid user certificate in a PEAP authentication request. This configuration supports a possible future move to Windows Hello for Business with minimal changes. 

Then, in the NPS proxy server policy on the VPN server, you specify that all possible authentication requests are sent directly to the NPS server for evaluation.

### NPS server configuration

You can use this procedure to configure NPS as a RADIUS server on your organization network.

**To configure the NPS network policy on the NPS server**

1.  On the NPS server, in Server Manager, click **Tools**, and then click **Network Policy Server**.

2.  Under **Standard Configuration**, click **Configure VPN or Dial-Up** to start the Configure VPN or Dial-Up Wizard.

3.  On the Select Dial-up or Virtual Private Network Connections Type page, click **Virtual Private Network (VPN) Connections**, and click **Next**.

4.  In **Specify Dial-Up or VPN Server**, complete the following steps:

    a.  Click **Add**. The **New RADIUS Client** dialog box opens.

    b.  In **New RADIUS Client**, in **Friendly name**, type the name of your VPN/NPS proxy server.

    c.  In **Address \(IP or DNS\)**, type the VPN/NPS proxy server’s IP address.

    d.  In **Shared Secret**, click **Generate**, and then click **Generate**.

    e.  Copy the generated string, and paste it into a text file that you save in a secure location. This string will be used to secure communication between the VPN/NPS proxy server and the NPS server. You will use the shared secret during VPN/NPS proxy server configuration in a later step.

5.  Click **OK** to close the **New RADIUS Client** dialog box.

6.  Click **Next**.

7.  In **Configure Authentication Methods**, complete the following steps:

    a.  Clear the **Microsoft Encrypted Authentication version 2 (MS-CHAPv2)** check box.

    b.  Select the **Extensible Authentication Protocol** check box.

    c.  In **Type**, click **Microsoft: Protected EAP \(PEAP\)**, and click **Configure**. The **Edit Protected EAP Properties** dialog box opens.

    d.  In **Edit Protected EAP Properties**, click **Remove** to remove the **Secured Password \(EAP-MSCHAP v2\)** EAP type.

    e.  Click **Add**.  The **Add EAP** dialog box opens. In **Add EAP**, click **Smart Card or other certificate**, and then click **OK**.

    f.  Click **OK** to close t**Edit Protected EAP Properties**.

8.  Click **Next**.

9.  In **Specify User Groups**, complete the following steps:

    a.  Click **Add**. The **Select Users, Computers, Service Accounts, or Groups** dialog box opens.

    b.  In **Select Users, Computers, Service Accounts, or Groups**, type **VPN Users**, and then click **OK**.

    c.  Click **Next**.

10.  In **Specify IP Filters**, click **Next**.

11.  In **Specify Encryption Settings**, do not make any changes. These settings apply only to Microsoft Point-to-Point Encryption (MPPE) connections, which this scenario doesn’t support. Click **Next**.

12.  In **Specify a Realm Name**, click **Next**.

13.  Click **Finish** to close the wizard.

### NPS proxy server configuration

You can use this procedure to configure NPS as a RADIUS proxy on your VPN server.

**To configure the VPN server as an NPS RADIUS proxy server**

1.  On your VPN server, in Server Manager, click **Tools**, and then click **Network Policy Server**.

2.  In **RADIUS Clients and Servers**, right-click **Remote RADIUS Server Groups**, and then click **New**. The **New Remote RADIUS Server Group** dialog box opens. Complete the following steps:

    a.  In **New Remote RADIUS Server Group**, click **Add**. The **Add RADIUS Server** dialog box opens.

    b.  On the **Address** tab, in **Server**, type the IP address of the NPS server that is installed on your organization or corporate network.

    c.  On the **Authentication/Accounting** tab, in both **Shared Secret** and **Confirm Shared Secret**, paste the shared secret that you previously generated on the NPS server. The shared secret that you configure on this NPS proxy server and on the NPS server must match, or RADIUS communication between the proxy and the server will fail.

    d.  Click **OK**.

    e.  In **New Remote RADIUS Server Group**, in **Group name**, type **Internal NPS**, and then click **OK**.

3.  In **Policies**, right-click **Connection Request Policies**, and then click **New**. The **New Connection Request Policy Wizard** opens.

4.  In **Specify Connection Request Policy Name and Connection Type**, complete the following steps:

    a.  In **Policy Name**, type **Forward all requests**.

    b.  In **Type of network access server**, click **Remote Access Server \(VPN-Dial up\)**.

    c.  Click **Next**.

5.  In **Specify Conditions**, complete the following steps:

    a.  Click **Add**. The **Select condition** dialog box opens.

    b.  In **Select condition**, click **Day and time restrictions**, and then click **Add**. The **Day and time restrictions** dialog box opens.

    c.  In **Day and time restrictions**, click **All**, click **Permitted**, and then click **OK**.

    d.  In **Specify Conditions**, confirm that the day and time restrictions are correct, and click **Next**.

6.  In **Specify Connection Request Forwarding**, complete the following steps:

    a.  Click **Forward requests to the following remote RADIUS server group for authentication**.

    b.  Click **Accounting**, and click **Forward accounting requests to this remote RADIUS server group**.

    c.  Click **Next**.

7.  In **Configure Settings**, click **Next**.

8.  Click **Finish**. All configured policies appear under **Connection Request Policies** in the details pane.

9.  Disable all policies except **Forward all requests** by right-clicking each policy, and then clicking **Disable**.

10. Close the NPS console.

For more information about NPS as a RADIUS server and RADIUS proxy server, see [Network Policy Server (NPS)](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-top).

For the next Always On VPN deployment steps, see [Configure DNS and Firewall Settings for Always On VPN](vpn-deploy-dns-firewall.md).