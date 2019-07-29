---
title: Install and Configure the NPS Server
description: NPS server processing of connection requests that are sent by the VPN server verifies that the user has permission to connect, the user's identity, and logs the aspects of the connection request that you chose when you configured RADIUS accounting in NPS. 
ms.prod: windows-server-threshold
ms.technology: networking-ras
ms.topic: article
ms.assetid: 
ms.localizationpriority: medium 
ms.author: pashort
author: shortpatti
ms.date: 08/30/2018
---

# Step 4. Install and configure the Network Policy Server (NPS)

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

- [**Next:** Step 3. Configure the Remote Access Server for Always On VPN](vpn-deploy-ras.md)
- [**Next:** Step 5. Configure DNS and Firewall Settings](vpn-deploy-dns-firewall.md)

In this step, you'll install Network Policy Server (NPS) for processing of connection requests that are sent by the VPN server:

- Perform authorization to verify that the user has permission to connect.
- Performing authentication to verify the user's identity.
- Performing accounting to log the aspects of the connection request that you chose when you configured RADIUS accounting in NPS.

The steps in this section allow you to complete the following items:

1. On the computer or VM that planned for the NPS server, and installed on your organization or corporate network, you can install NPS.

   >[!TIP]
   >If you already have one or more NPS servers on your network, you do not need to perform NPS Server installation - instead, you can use this topic to update the configuration of an existing NPS server.

> [!NOTE]
> You can not install the Network Policy Server service on Windows Server Core.

2. On the organization/corporate NPS server, you can configure NPS to perform as a RADIUS server that processes the connection requests received from the VPN server.

## Install Network Policy Server

In this procedure, you install NPS by using either Windows PowerShell or the Server Manager Add Roles and Features Wizard. NPS is a role service of the Network Policy and Access Services server role.

>[!TIP]
>By default, NPS listens for RADIUS traffic on ports 1812, 1813, 1645, and 1646 on all installed network adapters. When you install NPS, and  you enable Windows Firewall with Advanced Security, firewall exceptions for these ports get created automatically for both IPv4 and IPv6  traffic. If your network access servers are configured to send RADIUS traffic over ports other than these defaults, remove the exceptions created in Windows Firewall with Advanced Security during NPS installation, and create exceptions for the ports that you do use for RADIUS traffic.

**Procedure for Windows PowerShell:**

To perform this procedure by using Windows PowerShell, run Windows PowerShell as Administrator, enter the following cmdlet:

```powershell
Install-WindowsFeature NPAS -IncludeManagementTools
```

**Procedure for Server Manager:**

1.  In Server Manager, select **Manage**, then select **Add Roles and Features**.
        The Add Roles and Features Wizard opens.

2.  In Before You Begin, select **Next**.

    >[!NOTE] 
    >The **Before You Begin** page of the Add Roles and Features Wizard is not displayed if you had previously selected **Skip this page by default** when the Add Roles and Features Wizard ran.

3.  In Select Installation Type, ensure that **Role-Based or feature-based installation** is selected, and select **Next**.

4.  In Select destination server, ensure that **Select a server from the server pool** is selected.

5.  In Server Pool, ensure that the local computer is selected and select **Next**.

6.  In Select Server Roles, in **Roles**, select **Network Policy and Access Services**. A dialog box opens asking if it should add features required for Network Policy and Access Services.

7.  Select **Add Features**, then select **Next**

8.  In Select features, select **Next**, and in Network Policy and Access Services, review the information provided, then select **Next**.

9.  In Select role services, select **Network Policy Server**.

10. For features required for Network Policy Server, select **Add Features**, then select **Next**.

11. In Confirm installation selections, select **Restart the destination server automatically if required**.

12. Select **Yes** to confirm the selected, and then select **Install**.
    
    The Installation progress page displays the status during the installation process. When the process completes, the message "Installation succeeded on *ComputerName*" is displayed, where *ComputerName* is the name of the computer upon which you installed Network Policy Server.

13. Select **Close**.

## Configure NPS

After installing NPS, you configure NPS to handle all authentication, authorization, and accounting duties for connection request it receives from the VPN server.

### Register the NPS Server in Active Directory

In this procedure, you register the server in Active Directory so that it has permission to access user account information while processing connection requests.

**Procedure:**

1.  In Server Manager, select **Tools**, and then select **Network Policy Server**. The NPS console opens.

2.  In the NPS console, right-click **NPS (Local)**, then select **Register server in Active Directory**.
   
     The Network Policy Server dialog box opens.

3.  In the Network Policy Server dialog box, select **OK** twice.

For alternate methods of registering NPS, see [Register an NPS Server in an Active Directory Domain](../../../../../networking/technologies/nps/nps-manage-register.md).

### Configure Network Policy Server Accounting

In this procedure, configure Network Policy Server Accounting using one of the following logging types:

- **Event logging**. Used primarily for auditing and troubleshooting connection attempts. You can configure NPS event logging by obtaining the NPS server properties in the NPS console.

- **Logging user authentication and accounting requests to a local file**. Used primarily for connection analysis and billing purposes. Also used as a security investigation tool because it provides you with a method of tracking the activity of a malicious user after an attack. You can configure local file logging using the Accounting Configuration wizard.

- **Logging user authentication and accounting requests to a Microsoft SQL Server XML-compliant database**. Used to allow multiple servers running NPS to have one data source. Also provides the advantages of using a relational database. You can configure SQL Server logging by using the Accounting Configuration wizard.

To configure Network Policy Server Accounting, see [Configure Network Policy Server Accounting](../../../../../networking/technologies/nps/nps-accounting-configure.md).

### Add the VPN Server as a RADIUS Client

In the [Configure the Remote Access Server for Always On VPN](vpn-deploy-ras.md) section, you installed and configured your VPN server. During VPN server configuration, you added a RADIUS shared secret on the VPN server.

In this procedure, you use the same shared secret text string to configure the VPN server as a RADIUS client in NPS. Use the same text string that you used on the VPN server, or communication between the NPS server and VPN server fails.

>[!IMPORTANT] 
>When you add a new network access server (VPN server, wireless access point, authenticating switch, or dial-up server) to your network, you must add the server as a RADIUS client in NPS so that NPS is aware of and can communicate with the network access server.

**Procedure:**

1. On the NPS server, in the NPS console, double-click **RADIUS Clients and Servers**.

2. Right-click **RADIUS Clients** and select **New**. The New RADIUS Client dialog box opens.

3. Verify that the **Enable this RADIUS client** check box is selected.

4. In **Friendly name**, enter a display name for the VPN server.

5. In **Address (IP or DNS)**, enter the NAS IP address or FQDN.
     
     If you enter the FQDN, select **Verify** if you want to verify that the name is correct and maps to a valid IP address.

6. In **Shared secret**, do:

    1. Ensure that **Manual** is selected.

    2. Enter the strong text string that you also entered on the VPN server.

    3. Reenter the shared secret in Confirm shared secret.

7. Select **OK**. The VPN Server appears in the list of RADIUS clients configured on the NPS server.

## Configure NPS as a RADIUS for VPN Connections

In this procedure, you configure NPS as a RADIUS server on your organization network. On the NPS, you must define a policy that allows only users in a specific group to access the Organization/Corporate network through the VPN Server - and then only when using a valid user certificate in a PEAP authentication request.

**Procedure:**

1. In the NPS console, in Standard Configuration, ensure that **RADIUS server for Dial-Up or VPN Connections** is selected.

2. Select **Configure VPN or Dial-Up**.
        
    The Configure VPN or Dial-Up wizard opens.

3. Select **Virtual Private Network (VPN) Connections**, and select **Next**.

4. In Specify Dial-Up or VPN Server, in RADIUS clients, select the name of the VPN Server that you added in the previous step. For example, if your VPN server NetBIOS name is RAS1, select **RAS1**.

5. Select **Next**.

6. In Configure Authentication Methods, complete the following steps:

    1. Clear the **Microsoft Encrypted Authentication version 2 (MS-CHAPv2)** check box.

    2. Select the **Extensible Authentication Protocol** check box to select it.

    3. In Type (based on the method of access and network configuration), select **Microsoft: Protected EAP (PEAP)**, then select **Configure**.
      
        The Edit Protected EAP Properties dialog box opens.

    4. Select **Remove** to remove the Secured Password (EAP-MSCHAP v2) EAP type.

    5. Select **Add**. The Add EAP dialog box opens.

    6. Select **Smart Card or other certificate**, then select **OK**.

    7. Select **OK** to close Edit Protected EAP Properties.

7. Select **Next**.

8. In Specify User Groups, complete the following steps:

    1. Select **Add**. The Select Users, Computers, Service Accounts, or Groups dialog box opens.

    2. Enter **VPN Users**, then select **OK**.

    3. Select **Next**.

9. In Specify IP Filters, select **Next**.

10. In Specify Encryption Settings, select **Next**. Do not make any changes.

    These settings apply only to Microsoft Point-to-Point Encryption (MPPE) connections, which this scenario doesn’t support.

11. In Specify a Realm Name, select **Next**.

12. Select **Finish** to close the wizard.

## Autoenroll the NPS Server Certificate

In this procedure, you refresh Group Policy on the local NPS server manually. When Group Policy refreshes, if certificate autoenrollment is configured and functioning correctly, the local computer is auto-enrolled a certificate by the certification authority (CA).

>[!NOTE]  
>Group Policy refreshed automatically when you restart the domain member computer, or when a user logs on to a domain member computer. Also, Group Policy periodically refreshes. By default, this periodic refresh happens every 90 minutes with a randomized offset of up to 30 minutes.

Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure.

**Procedure:**

1. On the NPS, open Windows PowerShell.

2. At the Windows PowerShell prompt, type **gpupdate**, and then press ENTER.

## Next steps

[Step 5. Configure DNS and firewall settings for Always On VPN](vpn-deploy-dns-firewall.md): In this step, you install Network Policy Server (NPS) by using either Windows PowerShell or the Server Manager Add Roles and Features Wizard. You also configure NPS to handle all authentication, authorization, and accounting duties for connection requests that it receives from the VPN server.