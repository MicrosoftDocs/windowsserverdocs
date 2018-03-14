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
ms.date: 3/4/2018
---
# STEP 4: Install and Configure the NPS Server

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

The next step in the Always On VPN deployment process is to install and configure the Network Policy Server (NPS). The NPS allows you to create and enforce organization-wide network access policies for connection request authentication and authorization.

The connection requests that are sent by the VPN server includes performing authorization to:

-   Verify that the user has permission to connect (performing authentication).

-   Verify the user's identity (performing accounting).

-   Log the aspects of the connection request that you chose for the configured
    RADIUS accounting in NPS.

## Prerequisites

-   Shared secret text string used to configure the VPN server.

-   Membership in **Administrators**, or equivalent, is the minimum required to perform these procedures.

## STEP 4.1: Install Network Policy Server

>[!TIP] 
>If you already have one or more NPS servers on your network, you do not need to perform NPS Server installation - instead, you can update the configuration of an existing NPS server. 

Install NPS by using either Windows PowerShell or the Server Manager Add Roles and Features Wizard.

### Windows PowerShell

1.  Run Windows PowerShell as Administrator.

2.  Type the following command:<br><br>
    `Install-WindowsFeature NPAS -IncludeManagementTools`

3.  Press ENTER.

### Server Manager

1.  In Server Manager, click **Manage** and click **Add Roles and Features**.<br><br>The Add Roles and Features Wizard opens.

2.  In **Before You Begin**, click **Next**.<br><br>The **Before You Begin** page of the Add Roles and Features Wizard is not displayed if you had previously selected **Skip this page by default** when the Add Roles and Features Wizard last ran.

3.  In Select Installation Type, verify that the **Role-Based or feature-based installation** is selected and click **Next**.

4.  In Select destination server, verify that the **Select a server from the server pool** is selected.

5.  In Server Pool, verify that the local computer is selected and click **Next**.

6.  In Select Server Roles, in **Roles**, select **Network Policy and Access Services**.<br><br>A dialog box opens prompting you to add features required for Network Policy and Access Services.

    a.  Click **Add Features** and click **Next**

    b.  Click **Next** to accept the default feature selections.

    c.  Review the information and click **Next**.

7.  In Select role services, click **Network Policy Server**.

8.  Click **Add Features** and click **Next**.

9.  In Confirm installation selections, click **Restart the destination server automatically if required**.

10. Click **Yes** and **Install**.<br><br>The Installation progress page displays status during the installation process. When the process completes, the message  "Installation succeeded on _ComputerName_" is displayed, where _ComputerName_ is the name of the computer upon which you installed Network Policy Server.

11. Click **Close**.

## STEP 4.2: Configure Network Policy Server

After you install NPS, you must do basic configuration, set a friendly name, the IP address, and a shared secret with the virtual private network (VPN) client. The configuration process includes the following high-level steps:

1.  Register the NPS Server in Active Directory

2.  Configure RADIUS Accounting for your NPS Server

3.  Add the VPN Server as a RADIUS Client in NPS

4.  Configure Network Policy for VPN Connections

5.  Record NPS certificate settings

6.  Autoenroll the NPS Server certificate

### Register the NPS Server in Active Directory

Register the NPS server in AD so that the NPS server has permission to access user account information while processing connection requests.

1.  In Server Manager, click **Tools**, and click **Network Policy Server**.<br><br>The NPS console opens.

2.  Right-click **NPS (Local)** and click **Register server in Active Directory**.<br><br>The Network Policy Server dialog box opens.

3.  Click **OK** twice.

### Configure RADIUS Accounting for your NPS Server

1.  In the navigation pane of the NPS console, click **Accounting**.

2.  In Details, click **Configure Accounting**.

3.  Follow the instructions in [Configure RADIUS Accounting for your NPS  Server](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-accounting-configure) for further details.

### Add the VPN Server as a RADIUS Client in NPS

1.  In the navigation pane of the NPS Console, double-click **RADIUS Clients and Servers**.

2.  Right-click **RADIUS Clients** and click **New**.<br><br>The New RADIUS Client dialog box opens.

3.  Verify that the **Enable this RADIUS client** check box is selected.

4.  In **Friendly name**, enter a display name for the VPN server.

5.  In **Address (IP or DNS)**, enter one of the following:

    -   NAS IP address

    -   Fully qualified domain name (FQDN) If you entered the FQDN, click **Verify** to verify that the name is correct and maps to a valid IP address.

6.  In **Shared secret**, verify that **Manual** is selected, and enter the strong text string that you entered on the VPN server.

8.  Retype the shared secret in **Confirm shared secret**.

9.  Click **OK** to close the New RADIUS Client dialog box.<br><br>The VPN Server appears in the list of RADIUS clients that are configured on the NPS server.

### Configure Network Policy for VPN Connections

1.  In the navigation pane of the NPS console, click **NPS (Local)**.

2.  In Standard Configuration, verify that the **RADIUS server for Dial-Up or VPN Connections** is selected and click **Configure VPN or Dial-Up**.<br><br>The Configure VPN or Dial-Up wizard opens.

3.  Click **Virtual Private Network (VPN) Connections** and click **Next**.

4.  Under RADIUS Clients, select the name of the VPN Server and click **Next**.

5.  Clear the **Microsoft Encrypted Authentication version 2 (MS-CHAPv2)** check box.

6.  Select the **Extensible Authentication Protocol** check box, select **Microsoft: Protected EAP (PEAP)**, and click **Configure**.<br><br>The Edit Protected EAP Properties dialog box opens.

7.  Click **Remove** to remove the Secured Password (EAP-MSCHAP v2) EAP type and click **Add**.<br><br>The Add EAP dialog box opens.

8.  Click **Smart Card or other certificate** and click **OK**.

9.  Click **OK** to close Edit Protected EAP Properties and click **Next**.

10. In Specify User Groups, click **Add**<br><br>The Select Users, Computers, Service Accounts, or Groups dialog box opens.

11. Type **VPN Users**, click **OK**, and click **Next**.

12. Click **Next** in Specify IP Filters to accept the default selections.

13. Click **Next** in Specify Encryption Settings to accept the default selections.<br><br>Do not make any changes. These settings apply only to Microsoft     Point-to-Point Encryption (MPPE) connections, which this scenario does not support.

14. Click **Next** in Specify a Realm Name to accept the default selections and click **Finish** to close the wizard.

### Record NPS certificate settings

Before you can configure the Windows 10 client Always On VPN connections and create the ProfileXML template, you first need to note a few NPS server settings:

-   Host name or FQDN of the NPS server from the server’s certificate

-   Name of the CA that issued the certificate.

**Procedure:**

1.  In the navigation pane of the NPS console, under Policies, click **Network Policies**.

2.  Right-click **Virtual Private Network (VPN) Connections** and click **Properties**.<br><br>The Virtual Private Network (VPN) Connection Properties dialog box opens.

3.  Click the **Constraints** tab and click **Authentication Methods**.

4.  In **EAP Types**, click **Microsoft: Protected EAP (PEAP)**, click **Edit**, and record the values for:

    -   **Certificate issued to**

    -   **Issuer**<br><br>You use these values in the upcoming VPN template configuration. For example, if the server’s FQDN is nps01.corp.contoso.com and the host     name is NPS01, the certificate name is based upon the FQDN or DNS name of the server - for example, nps01.corp.contoso.com.

5.  Cancel the Edit Protected EAP Properties dialog box.

6.  Cancel the Virtual Private network (VPN) Connections Properties dialog box.

7.  Close Network Policy Server.

>[!NOTE] 
>If you have multiple NPS servers, complete these steps on each one so that the VPN profile can verify each of them should they be used.

### Autoenroll the NPS Server certificate

1.  Open Windows PowerShell as Administrator.

2.  Type **gpupdate**.

3.  Press ENTER.

4.  Restart the NPS Server.

## Next steps
[STEP 3: Configure authentication templates and enroll certificates](vpn-deploy-auth-certs.md). 