---
title: Install and Configure the NPS Server
description: This topic provides detailed instructions for deploying an NPS server for Always On VPN in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 6896e85e-a05e-44c2-9437-85417bed343d
manager: brianlic
ms.author: jamesmci
author: jamesmci
---

# Install and Configure the NPS Server

You can use this section to install Network Policy Server \(NPS\) and perform configuration for Always On VPN.

## Organization/Corporate NPS Server Deployment Overview

The steps in this section allow you to complete the following items.

1. On the computer or VM that is planned as the NPS server, and that is installed on your organization or corporate network, you can install NPS.

>[!TIP]
>If you already have one or more NPS servers on your network, you do not need to perform the steps in this section - unless you want to add an NPS server to your configuration.

2. On the organization/corporate NPS server, you can configure NPS to perform as a RADIUS server that processes the connection requests that are received from the VPN server.

You can perform this installation with the following instructions by using either Windows PowerShell or the Server Manager Add Roles and Features Wizard.

### Install Network Policy Server \(Optional\)

You can use this section to install Network Policy Server \(NPS\) by using either Windows PowerShell or the Add Roles and Features Wizard.

NPS is a role service of the Network Policy and Access Services server role.

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

## Configure NPS

NPS handles all authentication, authorization, and accounting duties for connection requests that it receives from the VPN server.

On the NPS server, you define a policy that allows only users in a specific group to access the VPN, and then only when using a valid user certificate in a PEAP authentication request. This configuration supports a possible future move to Windows Hello for Business with minimal changes. 

### Register the NPS Server in Active Directory

After you install NPS, you must register the server in Active Directory so that it has permission to access user account information while processing connection requests.

#### To register the NPS Server in Active Directory

1. In Server Manager, click **Tools**, and then click **Network Policy Server**. The NPS console opens.
2. In the NPS console, right\-click **NPS \(Local\)**, and then click **Register server in Active Directory**. The **Network Policy Server** dialog box opens.
3. In the **Network Policy Server** dialog box, click **OK** twice.

### Add the VPN Server as a RADIUS Client

You can use this section to configure the VPN server as a RADIUS Client in NPS.

>[!NOTE]
>When you add a new network access server \(VPN server, wireless access point, authenticating switch, or dial-up server\) to your network, you must add the server as a RADIUS client in NPS, and then configure the RADIUS client to communicate with the NPS server.

#### To add the VPN Server as a RADIUS client in NPS

1. On the NPS server, in Server Manager, click **Tools**, and then click **Network Policy Server**. The NPS console opens.
2. In the NPS console, double-click **RADIUS Clients and Servers**. Right-click **RADIUS Clients**, and then click **New**. The **New RADIUS Client** dialog box opens.
3. In **New RADIUS Client**, verify that the **Enable this RADIUS client** check box is selected.
4. In **New RADIUS Client**, in **Friendly name**, type a display name for the NAS. In **Address (IP or DNS)**, type the NAS IP address or fully qualified domain name (FQDN). If you enter the FQDN, click **Verify** if you want to verify that the name is correct and maps to a valid IP address. 
6. In **New RADIUS Client**, in **Shared secret**, do one of the following:
	- Ensure that **Manual** is selected, and then in **Shared secret**, type the strong password that is also entered on the VPN Server. Retype the shared secret in **Confirm shared secret**.
	- Select **Generate**, and then click **Generate** to automatically generate a shared secret. Save the generated shared secret for configuration on the NAS so that it can communicate with the NPS server.
8. Click **OK**. The VPN Server appears in the list of RADIUS clients that are configured on the NPS server.

### Configure NPS Server Network Policy

You can use this procedure to configure NPS as a RADIUS server on your organization network.

**To configure the NPS Network Policy on the NPS server**

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

>[!NOTE]
>NPS server processing of connection requests includes performing authorization - to verify that the user has permission to connect; performing authentication - to verify the user's identity; and performing accounting - to log the aspects of the connection request that you chose when you configured RADIUS accounting in NPS.

For more information, see [Manage NPS Servers](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-manage-top).


For the next Always On VPN deployment steps, see [Configure DNS and Firewall Settings for Always On VPN](vpn-deploy-dns-firewall.md).

