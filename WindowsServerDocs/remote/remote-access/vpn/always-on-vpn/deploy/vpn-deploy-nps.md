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
ms.date: 2/26/2018
---
# Install and Configure the NPS Server

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

The next step in the Always On VPN deployment process is to install and configure the Network Policy Server \(NPS\). The NPS allows you to create and enforce organization-wide network access policies for connection request authentication and authorization. The connection requests that are sent by the VPN server includes performing authorization to:

- Verify that the user has permission to connect (performing authentication).
- Verify the user's identity (performing accounting).
- Log the aspects of the connection request that you chose for the configured RADIUS accounting in NPS.

## Prerequisites
* Shared secret text string used to configure the VPN server.
* Membership in **Administrators**, or equivalent, is the minimum required to perform these procedures.

## STEP 1: Install Network Policy Server

>[!TIP]
>If you already have one or more NPS servers on your network, you do not need to perform NPS Server installation - instead, you can use this topic to update the configuration of an existing NPS server.

Install NPS by using either Windows PowerShell or the Server Manager Add Roles and Features Wizard.

### Windows PowerShell

1. Run Windows PowerShell as Administrator.
2. Type the following command:<br>`Install-WindowsFeature NPAS -IncludeManagementTools`
3. Press ENTER.

### Server Manager
1. In Server Manager, click **Manage** and click **Add Roles and Features**.<br>The Add Roles and Features Wizard opens.
2. In **Before You Begin**, click **Next**.<br>The **Before You Begin** page of the Add Roles and Features Wizard is not displayed if you have previously selected **Skip this page by default** when the Add Roles and Features Wizard was run.
3. In **Select Installation Type**, verify that the **Role-Based or feature-based installation** is selected and click **Next**.
4. In **Select destination server**, verify that the **Select a server from the server pool** is selected. 
5. In **Server Pool**, verify that the the local computer is selected and click **Next**.
7. In **Select Server Roles**, in **Roles**, select **Network Policy and Access Services**.<br>A dialog box opens asking if it should add features that are required for Network Policy and Access Services.<br>
    a. Click **Add Features** and click **Next**
    b. Click **Next** to accept the default feature selections.
    c. Review the information and click **Next**.
8. In **Select role services**, click **Network Policy Server**.
9. Click **Add Features** and click **Next**.
10. In **Confirm installation selections**, click **Restart the destination server automatically if required**. 
11. Click **Yes** and **Install**.<br>The Installation progress page displays status during the installation process. When the process completes, the message "Installation succeeded on _ComputerName_" is displayed, where _ComputerName_ is the name of the computer upon which you installed Network Policy Server. 
12. Click **Close**.

## STEP 2: Configure Network Policy Server
After you install NPS, you have to do basic configuration, set a friendly name, the IP address and a shared secret with the virtual private network (VPN) client. The configuration process includes the following high-level steps:

- Register the NPS Server in Active Directory
- Configure RADIUS Accounting for your NPS Server
- Add the VPN Server as a RADIUS Client in NPS
- Configure Network Policy for VPN Connections
- Autoenroll the NPS Server certificate

<!-- What are the configuration steps for configuring NPS with powershell? -->

1. In Server Manager, click **Tools**, and click **Network Policy Server**.<br>The NPS console opens.
2. Register the NPS Server in Active Directory o that it has permission to access user account information while processing connection requests:
   a. Right\-click **NPS \(Local\)** and click **Register server in Active Directory**.<br>The Network Policy Server dialog box opens.
   b. Click **OK** twice.
3. Configure RADIUS Accounting for your NPS Server:
    a. In the navigation pane, click **Accounting**.
    b. In Details, click **Configure Accounting**.<br>For more details, see [Configure RADIUS Accounting for your NPS Server](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-accounting-configure). <!-- what information from the Configure Network Policy Server Accounting section should go in here, even at a high level? -->
4. Add the VPN Server as a RADIUS Client in NPS:
    a. In the navigation pane, double-click **RADIUS Clients and Servers**. 
    b. Right-click **RADIUS Clients** and click **New**.<br>The New RADIUS Client dialog box opens.<br>
    c. Verify that the **Enable this RADIUS client** check box is selected.
    d. In **Friendly name**, enter a display name for the VPN server. 
    e. In **Address \(IP or DNS\)**, enter one of the following:<br>
        * NAS IP address 
        * Fully qualified domain name \(FQDN\)
        If you entered the FQDN, click **Verify** to verify that the name is correct and maps to a valid IP address.
    f. In **Shared secret**, verify that **Manual** is selected, and in **Shared secret**, enter the strong text string that you entered on the VPN server. 
    g. Retype the shared secret in **Confirm shared secret**.
    h. Click **OK** to close the New RADIUS Client dialog box.<br>The VPN Server appears in the list of RADIUS clients that are configured on the NPS server.<!-- is Server Manager still open at this point? -->
5. Configure Network Policy for VPN Connections:
    a. In the navigation pane, click **NPS (Local)**.
    b. In Standard Configuration, verify that the **RADIUS server for Dial\-Up or VPN Connections** is selected and click **Configure VPN or Dial-Up**.<br>The Configure VPN or Dial-Up wizard opens.
    c.  Click **Virtual Private Network (VPN) Connections** and click **Next**.
    d.  Under RADIUS Clients, select the name of the VPN Server and click **Next**.
    e. Clear the **Microsoft Encrypted Authentication version 2 (MS-CHAPv2)** check box.
    f.  Select the **Extensible Authentication Protocol** check box, select **Microsoft: Protected EAP \(PEAP\)**, and click **Configure**.<br>The Edit Protected EAP Properties dialog box opens.
    g.  Click **Remove** to remove the Secured Password \(EAP-MSCHAP v2\) EAP type and click **Add**.<br>The Add EAP dialog box opens. 
    h. Click **Smart Card or other certificate** and click **OK**.
    i.  Click **OK** to close Edit Protected EAP Properties and click **Next**.
    j.  In Specify User Groups, click **Add**.<br>The Select Users, Computers, Service Accounts, or Groups dialog box opens.
    k.  Type **VPN Users**, click **OK**, and click **Next**.
    l.  Click **Next** in Specify IP Filters to accept the default selections.
    m.  Click **Next** in Specify Encryption Settings to accept the default selections.<br>Do not make any changes. These settings apply only to Microsoft Point-to-Point Encryption \(MPPE\) connections, which this scenario doesn’t support.
    n.  Click **Next** in Specify a Realm Name to accept the default selections and click **Finish** to close the wizard.
6. Autoenrool the NPS Server certificate:
    a.  On the computer where NPS is installed, open Windows PowerShell.
    b.  Type **gpupdate**, and then press ENTER.

## Next steps
**[Configure DNS and Firewall Settings for Always On VPN](vpn-deploy-dns-firewall.md)**. 
