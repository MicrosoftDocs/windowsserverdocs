---
title: Install and Configure the NPS Server
description: This topic provides detailed instructions for deploying an NPS server for Always On VPN in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 6896e85e-a05e-44c2-9437-85417bed343d
manager: brianlic
ms.author: pashort
author: shortpatti
ms.date: 2/25/2018
---
# Install and Configure the NPS Server

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

The next step in the Always On VPN deployment process is to install and configure the Network Policy Server \(NPS\). Network Policy Server (NPS) allows you to create and enforce organization-wide network access policies for connection request authentication and authorization. The connection requests that are sent by the VPN server includes performing authorization to:

- Verify that the user has permission to connect (performing authentication).
- Verify the user's identity (performing accounting).
- Log the aspects of the connection request that you chose when you configured RADIUS accounting in NPS.

NPS handles all authentication, authorization, and accounting duties for connection requests that it receives from the VPN server. 

On the NPS server, you must define a policy that allows only users in a specific group to access the Organization/Corporate network through the VPN Server - and then only when using a valid user certificate in a PEAP authentication request. 

NPS is a role service of the Network Policy and Access Services server role.

A NAS using a RADIUS infrastructure is also a RADIUS client, sending connection requests and accounting messages to a RADIUS server for authentication, authorization, and accounting. When you add the server as a RADIUS client in NPS, the NPS is aware of and can communicate with the network access server.

In the [Configure the Remote Access Server for Always On VPN](vpn-deploy-ras.md) topic, you installed and configured your VPN server. During VPN server configuration, you added a RADIUS shared secret on the VPN server. Now you need to use the same shared secret text string to configure the VPN server as a RADIUS client in NPS. You must use the same text string that you used on the VPN server, or communication between the NPS server and VPN server will fail.

> [!NOTE]
> By default, NPS listens for RADIUS traffic on ports 1812, 1813, 1645, and 1646 on all installed network adapters. If Windows Firewall with Advanced Security is enabled when you install NPS, firewall exceptions for these ports are automatically created during the installation process for both Internet Protocol version 6 \(IPv6\) and IPv4 traffic. If your network access servers are configured to send RADIUS traffic over ports other than these defaults, remove the exceptions created in Windows Firewall with Advanced Security during NPS installation, and create exceptions for the ports that you do use for RADIUS traffic.


You can use this procedure to manually refresh Group Policy on the local NPS server. When Group Policy is refreshed, if certificate autoenrollment is configured and functioning correctly, the local computer is autoenrolled a certificate by the certification authority \(CA\).  
  
> [!NOTE]  
> Group Policy is automatically refreshed when you restart the domain member computer, or when a user logs on to a domain member computer. In addition, Group Policy is periodically refreshed. By default, this periodic refresh is performed every 90 minutes with a randomized offset of up to 30 minutes.  



2. On the organization/corporate NPS server, you can configure NPS to perform as a RADIUS server that processes the connection requests that are received from the VPN server.

## Prerequisites
* Shared secret text string used to configure the VPN server.
* Membership in **Administrators**, or equivalent, is the minimum required to perform these procedures.

## STEP 1: Install Network Policy Server

>[!TIP]
>If you already have one or more NPS servers on your network, you do not need to perform NPS Server installation - instead, you can use this topic to update the configuration of an existing NPS server.

Install NPS by using either Windows PowerShell or the Server Manager Add Roles and Features Wizard.

### Windows PowerShell

1. Run Windows PowerShell as Administrator.
2. Type the following command:<br><br>`Install-WindowsFeature NPAS -IncludeManagementTools`
3. Press ENTER.

### Server Manager

1.  In Server Manager, click **Manage**, and then click **Add Roles and Features**.<br><br>The Add Roles and Features Wizard opens.

2.  In **Before You Begin**, click **Next**.

    > [!NOTE]
    > The **Before You Begin** page of the Add Roles and Features Wizard is not displayed if you have previously selected **Skip this page by default** when the Add Roles and Features Wizard was run.

3.  In **Select Installation Type**, ensure that **Role-Based or feature-based installation** is selected, and then click **Next**.

4.  In **Select destination server**, ensure that **Select a server from the server pool** is selected. 
5. In **Server Pool**, ensure that the local computer is selected. Click **Next**.

5.  In **Select Server Roles**, in **Roles**, select **Network Policy and Access Services**.<br><br>A dialog box opens asking if it should add features that are required for Network Policy and Access Services. 
6. Click **Add Features**, and then click **Next**

6.  In **Select features**, click **Next**, and in **Network Policy and Access Services**, review the information that is provided, and then click **Next**.

7.  In **Select role services**, click **Network Policy Server**.  
8. In **Add features that are required for Network Policy Server**, click **Add Features**. Click **Next**.

8.  In **Confirm installation selections**, click **Restart the destination server automatically if required**. 
9. When you are prompted to confirm this selection, click **Yes**, and then click **Install**.<br><br>The Installation progress page displays status during the installation process. When the process completes, the message "Installation succeeded on _ComputerName_" is displayed, where _ComputerName_ is the name of the computer upon which you installed Network Policy Server. 
10. Click **Close**.

## STEP 2: Configure Network Policy Server 

After you install NPS, you must do the following to configure NPS:

1. Register the NPS Server in Active Directory so that it has permission to access user account information while processing connection requests:
    a. In Server Manager, click **Tools**, and click **Network Policy Server**.<br><br>The NPS console opens.
    b. Right\-click **NPS \(Local\)**, and click **Register server in Active Directory**.<br><br>The Network Policy Server dialog box opens.
    c. Click **OK** twice.
2. [Configure RADIUS Accounting for your NPS Server](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-accounting-configure). <!-- what information from the Configure Network Policy Server Accounting section should go in here, even at a high level?-->
3. Add the VPN Server as a RADIUS Client in NPS:
    a. On the NPS server, in Server Manager, click **Tools**, and click **Network Policy Server**.<br><br>The NPS console opens.
    
    b. Double-click **RADIUS Clients and Servers**. 
    c. Right-click **RADIUS Clients**, and click **New**.<br><br>The New RADIUS Client dialog box opens.
    
    d. Verify that the **Enable this RADIUS client** check box is selected.
    
    e. In **Friendly name**, enter a display name for the VPN server. 
    f. In **Address \(IP or DNS\)**, enter one of the following:
        * NAS IP address 
        * Fully qualified domain name \(FQDN\)
        If you entered the FQDN, click **Verify** to verify that the name is correct and maps to a valid IP address.
    
    f. In **Shared secret**, verify that **Manual** is selected, and in **Shared secret**, enter the strong text string that you entered on the VPN server. 
    g. Retype the shared secret in **Confirm shared secret**.
    
    g. Click **OK** to close the New RADIUS Client dialog box.<br><br>The VPN Server appears in the list of RADIUS clients that are configured on the NPS server.<!-- is Server Manager still open at this point? -->
5. Configure Network Policy Server for VPN Connections
    a. In Server Manager, click **Tools**, and click **Network Policy Server**.<br><br>The NPS console opens.
    
    b.  In **Standard Configuration**, verify that **RADIUS server for Dial\-Up or VPN Connections** is selected, and click **Configure VPN or Dial-Up**.<br><br>The Configure VPN or Dial-Up wizard opens.
    
    c.  In **Select Dial-up or Virtual Private Network Connections Type** page, click **Virtual Private Network (VPN) Connections**, and click **Next**.
    
    d.  In **Specify Dial-Up or VPN Server**, in RADIUS clients, click the name of the VPN Server that you added in the previous step.<br><br>For example, if your VPN server NetBIOS name is RAS1, click **RAS1**. 
    e. Click **Next**.
    
    f.  In **Configure Authentication Methods**, clear the **Microsoft Encrypted Authentication version 2 (MS-CHAPv2)** check box.
    
       1.  Select the **Extensible Authentication Protocol** check box.
    
       2.  Click **Type \(based on method of access and network configuration\)**, and click **Microsoft: Protected EAP \(PEAP\)**.
       3.  Click **Configure**.<br><br>The Edit Protected EAP Properties dialog box opens.
    
       4.  Click **Remove** to remove the **Secured Password \(EAP-MSCHAP v2\)** EAP type.
    
       5.  Click **Add**.<br><br>The **Add EAP** dialog box opens. 
       6. In **Add EAP**, click **Smart Card or other certificate**, and click **OK**.
    
       7.  Click **OK** to close Edit Protected EAP Properties and click **Next**.
    
    g.  In **Specify User Groups**, click **Add**.<br><br>The **Select Users, Computers, Service Accounts, or Groups** dialog box opens.
    
    h.  In **Select Users, Computers, Service Accounts, or Groups**, type **VPN Users**.
    i. Click **OK** and click **Next**.
    
    h.  In **Specify IP Filters**, click **Next**.
    
    i.  In **Specify Encryption Settings**, do not make any changes.<br><br>These settings apply only to Microsoft Point-to-Point Encryption \(MPPE\) connections, which this scenario doesn’t support. 
    j. Click **Next**.
    
    j.  In **Specify a Realm Name**, click **Next**.
    
    k.  Click **Finish** to close the wizard.

6. Autoenroll the NPS Server certificate
  
    1.  On the computer where NPS is installed, open Windows PowerShell.
      
    2.  Type **gpupdate**, and then press ENTER.

## Next steps
**[Configure DNS and Firewall Settings for Always On VPN](vpn-deploy-dns-firewall.md)**. 
