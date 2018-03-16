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

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

You can use this section to install Network Policy Server \(NPS\) and perform configuration for Always On VPN.

NPS server processing of connection requests that are sent by the VPN server includes performing authorization - to verify that the user has permission to connect; performing authentication - to verify the user's identity; and performing accounting - to log the aspects of the connection request that you chose when you configured RADIUS accounting in NPS.

The steps in this section allow you to complete the following items.

1. On the computer or VM that is planned as the NPS server, and that is installed on your organization or corporate network, you can install NPS.

	>[!TIP]
	>If you already have one or more NPS servers on your network, you do not need to perform NPS Server installation - instead, you can use this topic to update the configuration of an existing NPS server.

2. On the organization/corporate NPS server, you can configure NPS to perform as a RADIUS server that processes the connection requests that are received from the VPN server.


## Install Network Policy Server

You can use this section to install Network Policy Server \(NPS\) by using either Windows PowerShell or the Server Manager Add Roles and Features Wizard.

NPS is a role service of the Network Policy and Access Services server role.

> [!NOTE]
> By default, NPS listens for RADIUS traffic on ports 1812, 1813, 1645, and 1646 on all installed network adapters. If Windows Firewall with Advanced Security is enabled when you install NPS, firewall exceptions for these ports are automatically created during the installation process for both Internet Protocol version 6 \(IPv6\) and IPv4 traffic. If your network access servers are configured to send RADIUS traffic over ports other than these defaults, remove the exceptions created in Windows Firewall with Advanced Security during NPS installation, and create exceptions for the ports that you do use for RADIUS traffic.

**Administrative Credentials**

Membership in **Administrators**, or equivalent, is the minimum required to perform these procedures.

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

To configure NPS, you must perform the following tasks.

- Register the NPS Server in Active Directory
- Configure RADIUS Accounting for your NPS Server
- Add the VPN Server as a RADIUS Client in NPS
- Configure Network Policy in NPS
- Autoenroll the NPS Server certificate

The following sections provide instructions on completing these tasks.

## Register the NPS Server in Active Directory

After you install NPS, you must register the server in Active Directory so that it has permission to access user account information while processing connection requests.

#### To register the NPS Server in Active Directory

1. In Server Manager, click **Tools**, and then click **Network Policy Server**. The NPS console opens.
2. In the NPS console, right\-click **NPS \(Local\)**, and then click **Register server in Active Directory**. The **Network Policy Server** dialog box opens.
3. In the **Network Policy Server** dialog box, click **OK** twice.

For alternate methods of registering NPS, see [Register an NPS Server in an Active Directory Domain](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-manage-register).

## Configure Network Policy Server Accounting

There are three types of logging for Network Policy Server \(NPS\):

- **Event logging**. Used primarily for auditing and troubleshooting connection attempts. You can configure NPS event logging by obtaining the NPS server properties in the NPS console.

- **Logging user authentication and accounting requests to a local file**. Used primarily for connection analysis and billing purposes. Also useful as a security investigation tool because it provides you with a method of tracking the activity of a malicious user after an attack. You can configure local file logging using the Accounting Configuration wizard.

- **Logging user authentication and accounting requests to a Microsoft SQL Server XML-compliant database**. Used to allow multiple servers running NPS to have one data source. Also provides the advantages of using a relational database. You can configure SQL Server logging by using the Accounting Configuration wizard.

To learn how to configure NPS Accounting, see [Configure Network Policy Server Accounting](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-accounting-configure).

## Add the VPN Server as a RADIUS Client

You can use this section to configure the VPN server as a RADIUS Client in NPS.

>[!NOTE]
>When you add a new network access server \(VPN server, wireless access point, authenticating switch, or dial-up server\) to your network, you must add the server as a RADIUS client in NPS so that NPS is aware of and can communicate with the network access server.

#### To add the VPN Server as a RADIUS client in NPS

You can use this procedure to configure a new RADIUS client in NPS.

>[!IMPORTANT]
>In the previous deployment step using the topic [Configure the Remote Access Server for Always On VPN](vpn-deploy-ras.md), you installed and configured your VPN server. During VPN server configuration, you added a RADIUS shared secret on the VPN server. Now you need to use the same shared secret text string to configure the VPN server as a RADIUS client in NPS. You must use the same text string that you used on the VPN server, or communication between the NPS server and VPN server will fail.

1. On the NPS server, in Server Manager, click **Tools**, and then click **Network Policy Server**. The NPS console opens.

2. In the NPS console, double-click **RADIUS Clients and Servers**. Right-click **RADIUS Clients**, and then click **New**. The **New RADIUS Client** dialog box opens.

3. In **New RADIUS Client**, verify that the **Enable this RADIUS client** check box is selected.

4. In **New RADIUS Client**, in **Friendly name**, type a display name for the VPN server. In **Address \(IP or DNS\)**, type the NAS IP address or fully qualified domain name \(FQDN\). If you enter the FQDN, click **Verify** if you want to verify that the name is correct and maps to a valid IP address.

5. In **New RADIUS Client**, in **Shared secret**, do the following:
	- Ensure that **Manual** is selected, and then in **Shared secret**, type the strong text string that you also entered on the VPN server. Retype the shared secret in **Confirm shared secret**.

6. Click **OK**. The VPN Server appears in the list of RADIUS clients that are configured on the NPS server.

## Configure Network Policy for VPN Connections

You can use this procedure to configure NPS as a RADIUS server on your organization network.

On the NPS server, you must define a policy that allows only users in a specific group to access the Organization/Corporate network through the VPN Server - and then only when using a valid user certificate in a PEAP authentication request. 

**To configure the NPS Network Policy on the NPS server**

1.  On the NPS server, in Server Manager, click **Tools**, and then click **Network Policy Server**.

2.  In **Standard Configuration**, ensure that **RADIUS server for Dial\-Up or VPN Connections** is selected, and then click **Configure VPN or Dial-Up**. The **Configure VPN or Dial-Up** wizard opens.

3.  In the **Configure VPN or Dial-Up** wizard, in **Select Dial-up or Virtual Private Network Connections Type** page, click **Virtual Private Network (VPN) Connections**, and then click **Next**.

4.  In **Specify Dial-Up or VPN Server**, in RADIUS clients, click the name of the VPN Server that you added in the previous step. For example, if your VPN server NetBIOS name is RAS1, click **RAS1**. Click **Next**.

5.  In **Configure Authentication Methods**, complete the following steps:

    a.  Deselect the **Microsoft Encrypted Authentication version 2 (MS-CHAPv2)** check box.

    b.  Select the **Extensible Authentication Protocol** check box.

    c.  Click **Type \(based on method of access and network configuration\)**, and then click **Microsoft: Protected EAP \(PEAP\)**.
	d.  Click **Configure**. The **Edit Protected EAP Properties** dialog box opens.

    e.  In **Edit Protected EAP Properties**, click **Remove** to remove the **Secured Password \(EAP-MSCHAP v2\)** EAP type.

    f.  Click **Add**.  The **Add EAP** dialog box opens. In **Add EAP**, click **Smart Card or other certificate**, and then click **OK**.

    g.  Click **OK** to close **Edit Protected EAP Properties**.

8.  Click **Next**.

9.  In **Specify User Groups**, complete the following steps:

    a.  Click **Add**. The **Select Users, Computers, Service Accounts, or Groups** dialog box opens.

    b.  In **Select Users, Computers, Service Accounts, or Groups**, type **VPN Users**, and then click **OK**.

    c.  Click **Next**.

10.  In **Specify IP Filters**, click **Next**.

11.  In **Specify Encryption Settings**, do not make any changes. These settings apply only to Microsoft Point-to-Point Encryption \(MPPE\) connections, which this scenario doesn’t support. Click **Next**.

12.  In **Specify a Realm Name**, click **Next**.

13.  Click **Finish** to close the wizard.

## Autoenroll the NPS Server Certificate

You can use this procedure to manually refresh Group Policy on the local NPS server. When Group Policy is refreshed, if certificate autoenrollment is configured and functioning correctly, the local computer is autoenrolled a certificate by the certification authority \(CA\).  
  
> [!NOTE]  
> Group Policy is automatically refreshed when you restart the domain member computer, or when a user logs on to a domain member computer. In addition, Group Policy is periodically refreshed. By default, this periodic refresh is performed every 90 minutes with a randomized offset of up to 30 minutes.  
  
Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure.  
  
### To refresh Group Policy on the NPS server
  
1.  On the computer where NPS is installed, open Windows PowerShell.
  
2.  At the Windows PowerShell prompt, type **gpupdate**, and then press ENTER.

For the next Always On VPN deployment steps, see [Configure DNS and Firewall Settings for Always On VPN](vpn-deploy-dns-firewall.md).
