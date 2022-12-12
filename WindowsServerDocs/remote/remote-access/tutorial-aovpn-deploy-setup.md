---
title: Deploy Always On VPN - Setup the environment
description: Learn how to deploy Always On VPN (AOV) connections for Windows 10+ client computers that are working offsite (for example, from home, a customer site, or a public wireless access point).
ms.topic: article
ms.assetid: ad748de2-d175-47bf-b05f-707dc48692cf
ms.author: anaharris
author: anaharris-ms
ms.date: 12/02/2022
---

# Tutorial: Deploy Always On VPN - Setup the environment

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10, Windows 11

In this tutorial, you'll learn how to deploy Always On VPN connections for remote domain-joined Windows client computers. You'll create a sample infrastructure that shows you how to implement an Always On VPN connection process. The process is composed of the following steps:

1. The Windows VPN client uses a public DNS server to perform a name resolution query for the IP address of the VPN gateway.

1. The VPN client uses the IP address returned by DNS to send a connection request to the VPN gateway.

1. The VPN server is also configured as a Remote Authentication Dial-In User Service (RADIUS) Client; the VPN RADIUS Client sends the connection request to the NPS server for connection request processing.

1. The NPS server processes the connection request, including performing authorization and authentication, and determines whether to allow or deny the connection request.

1. The NPS server forwards an Access-Accept or Access-Deny response to the VPN server.

1. The connection is initiated or terminated based on the response that the VPN server received from the NPS server.

## Prerequisites

To complete the steps in this tutorial,

- You'll need access to three physical computers or virtual machines (VMs).
- Ensure that your user account on all machines is a member of **Administrators**, or equivalent.

>[!IMPORTANT]
>Using Remote Access in Microsoft Azure is not supported, including both Remote Access VPN and DirectAccess. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).

## Create the Domain Controller

1. Install Windows Server on the machine that will run the domain controller.

1. Install [Active Directory Domain Services (AD DS)](/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview) on the Windows Server. For detailed information on how to install AD DS, see [Install Active Directory Domain Services](/windows-server/identity/ad-ds/deploy/install-active-directory-domain-services--level-100-#to-install-ad-ds-by-using-server-manager).

1. Promote the Windows Server to domain controller. For information on how to install the domain controller, see [AD DS Installation](/windows-server/identity/ad-ds/deploy/ad-ds-installation-and-removal-wizard-page-descriptions#BKMK_DNSOptionsPage)

## Create the NPS server

1. On the domain controller, install the [Network Policy and Access Services (NPS) role](/windows-server//networking/technologies/nps/nps-top). For detailed information on how to install NSP, see [Install Network Policy Server](/windows-server/networking/technologies/nps/nps-manage-install).

1. Register the NPS Server in Active Directory. For detailed information on how to register NPS Server in Active Directory, see [Register an NPS in an Active Directory Domain](/windows-server/networking/technologies/nps/nps-manage-register).

1. Make sure that your firewalls allow the traffic that is necessary for both VPN and RADIUS communications to function correctly. For more information, see [Configure Firewalls for RADIUS Traffic](../../networking/technologies/nps/nps-firewalls-configure.md).

## Create the VPN server

1. Install Windows Server on the machine that will run the VPN Server. Ensure that the machine has one physical Ethernet network adapter that faces the internet.

1. Join the VPN server to your domain. For information on how to join a server to a domain, see [To join a server to a domain](/windows-server/identity/ad-fs/deployment/join-a-computer-to-a-domain#to-join-a-server-to-a-domain).

1. Follow the steps in [Install Remote Access as a VPN server](getting-started-install-ras-as-vpn.md) to install the VPN server.

>[!IMPORTANT]
> Copy and save the shared secret for NPS and VPN server communications, as you'll need it for later use in this tutorial.

1. Open your firewall rules to allow UDP ports 500 and 4500 inbound to the external IP address applied to the public interface on the VPN server.

## Create the test client

1. Install Windows 10+ or Windows Server on the machine that will be your test client.

1. Join the test client to your domain. For information on how to join a computer to a domain, see [To join a computer to a domain](/windows-server/identity/ad-fs/deployment/join-a-computer-to-a-domain#to-join-a-server-to-a-domain).

## Configure Active Directory

### Create an Active Directory Group Policy

In this section, you'll create a Group Policy on the domain controller so that domain members automatically request user and computer certificates. This configuration lets VPN users request and retrieve user certificates that automatically authenticate VPN connections. This policy also allows the NPS server to request server authentication certificates automatically.

1. On the domain controller, open Group Policy Management.

2. In the left pane, right-click your domain (for example, corp.contoso.com). Select **Create a GPO in this domain, and Link it here**.

3. On the New GPO dialog box, for **Name**, enter *Autoenrollment Policy*. Select **OK**.

4. In the left pane, right-click **Autoenrollment Policy**. Select **Edit** to open the **Group Policy Management Editor**.

5. In the **Group Policy Management Editor**, complete the following steps to configure computer certificate autoenrollment:

    1. In the left pane, go to **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Public Key Policies**.

    2. In the details pane, right-click **Certificate Services Client – Auto-Enrollment**. Select **Properties**.

    3. On the **Certificate Services Client – Auto-Enrollment Properties** dialog box, for **Configuration Model**, select *Enabled*.

    4. Select **Renew expired certificates, update pending certificates, and remove revoked certificates** and **Update certificates that use certificate templates**.

    5. Select **OK**.

6. In the **Group Policy Management Editor**, complete the following steps to Configure user certificate autoenrollment:

    1. In the left pane, go to **User Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Public Key Policies**.

    2. In the details pane, right-click **Certificate Services Client – Auto-Enrollment** and select **Properties**.

    3. On the **Certificate Services Client – Auto-Enrollment Properties** dialog box, in **Configuration Model**, select *Enabled*.

    4. Select **Renew expired certificates, update pending certificates, and remove revoked certificates** and **Update certificates that use certificate templates**.

    5. Select **OK**.

    6. Close the Group Policy Management Editor.

7. Close Group Policy Management.

### Create Active Directory test user

In this section, you'll add a test user who will be able to logon to the domain using Always On VPN.

1. On the domain controller, open Active Directory Users and Computers.

1. Under your domain, right-click **Users**. Select **New**.  For **User logon name**, enter any logon name. Select **Next**.

1. Choose a password for the user.

1. Deselect **User must change password at next logon**. Select **Password never expires**.

1. Select **Finish**.

### Create Active Directory groups

In this section, you'll add three new Active Directory (AD) groups: the VPN Users group, the VPN Servers group, and the NPS Servers group.

**Create the VPN Users group:**

1. On the domain controller, open Active Directory Users and Computers.

2. Under your domain, right-click **Users**. Select **New**, then select **Group**.

3. In **Group name**, enter **VPN Users**, then select **OK**.

4. Right-click **VPN Users** and select **Properties**.

5. On the **Members** tab of the VPN Users Properties dialog box, select **Add**.

6. On the Select Users dialog box, add the test user who you created in [Create Active Directory test user](#create-active-directory-test-user) and select **OK**.

7. Close Active Directory Users and Computers.

**Create the VPN Servers and NPS Servers groups:**

1. On a domain controller, open Active Directory Users and Computers.

2. Under your domain, right-click **Computers**. Select **New**, then select **Group**.

3. In **Group name**, enter **VPN Servers**, then select **OK**.

4. Right-click **VPN Servers** and select **Properties**.

5. On the **Members** tab of the VPN Servers Properties dialog box, select **Add**.

6. select **Object Types**, select the **Computers** check box, then select **OK**.

7. In **Enter the object names to select**, enter the computer name of the VPN server you created in [Create the VPN server](#create-the-vpn-server). Select **OK**.

8. Repeat the previous steps for the NPS Servers group.

9. Close Active Directory Users and Computers.

## Configure NPS RADIUS server and client

### Configure VPN server as a RADIUS client

1. On the NPS server, in the NPS console, double-click **RADIUS Clients and Servers**.

1. Right-click **RADIUS Clients** and select **New** to open the New RADIUS Client dialog box.

1. Verify that the **Enable this RADIUS client** check box is selected.

1. In **Friendly name**, enter a display name for the VPN server.

1. In **Address (IP or DNS)**, enter the NAS IP address or FQDN.

    If you enter the FQDN, select **Verify** if you want to verify that the name is correct and maps to a valid IP address.

1. In **Shared secret**:

    1. Ensure that **Manual** is selected.

    2. Enter the secret that you created in the [Create the VPN server section](#create-the-vpn-server).

    3. For **Confirm shared secret**, re-enter the shared secret.

1. Select **OK**. The VPN Server should appear in the list of RADIUS clients configured on the NPS server.

>[!IMPORTANT]

>If you use the default RADIUS port configuration on the VPN Server and the NPS Server, make sure that you open the following ports:
>
>- Ports UDP1812, UDP1813, UDP1645, and UDP1646
>
>If you're not using the default RADIUS ports in your NPS deployment, you must allow RADIUS traffic on the ports that you are using. For more information, see [Configure Firewalls for RADIUS Traffic](../../networking/technologies/nps/nps-firewalls-configure.md).

### Configure NPS server as a RADIUS server

1. In the NPS console, select **NPS(Local)**.

1. In Standard Configuration, ensure that **RADIUS server for Dial-Up or VPN Connections** is selected.

1. Select **Configure VPN or Dial-Up** to open the Configure VPN or Dial-Up wizard.

1. Select **Virtual Private Network (VPN) Connections**, and select **Next**.

1. In Specify Dial-Up or VPN Server, in RADIUS clients, select the name of the VPN Server that you added in [Configure VPN server as a RADIUS client](#configure-vpn-server-as-a-radius-client).

1. Select **Next**.

1. In Configure Authentication Methods, complete the following steps:

    1. Clear the **Microsoft Encrypted Authentication version 2 (MS-CHAPv2)** check box.

    2. Select the **Extensible Authentication Protocol** check box to select it.

    3. For **Type** (based on the method of access and network configuration), select **Microsoft: Protected EAP (PEAP)**. Then select **Configure** to open the Edit Protected EAP Properties dialog box.

    4. Select **Remove** to remove the Secured Password (EAP-MSCHAP v2) EAP type.

    5. Select **Add**. The Add EAP dialog box opens.

    6. Select **Smart Card or other certificate**, then select **OK**.

    7. Select **OK** to close Edit Protected EAP Properties.

1. Select **Next**.

1. In Specify User Groups, complete the following steps:

    1. Select **Add**. The Select Users, Computers, Service Accounts, or Groups dialog box opens.

    2. Enter **VPN Users**, then select **OK**.

    3. Select **Next**.

1. For **Specify IP Filters**, select **Next**.

1. For **Specify Encryption Settings**, select **Next**. Do not make any changes.

1. For **Specify a Realm Name**, select **Next**.

1. Select **Finish** to close the wizard.

## Next steps

- [Deploy Always On VPN Tutorial: Configure Certification Authority templates](tutorial-aovpn-deploy-create-certificates.md)