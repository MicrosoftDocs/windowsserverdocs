---
title: "Tutorial: Deploy Always On VPN Infrastructure"
description: Learn how to deploy Always On VPN connections for Windows client computers that are working offsite, such as from home, a customer site, or a public location.
ms.topic: tutorial
ms.author: daknappe
author: dknappettmsft
ms.date: 05/07/2025
---

# Tutorial: Deploy Always On VPN infrastructure

Always On VPN is a remote access solution in Windows Server that provides seamless and secure connectivity for remote users to corporate networks. It supports advanced authentication methods and integrates with existing infrastructure, offering a modern alternative to traditional VPN solutions. This tutorial begins the series to deploy Always On VPN in a sample environment.

In this tutorial, you learn how to deploy a sample infrastructure for Always On VPN connections for remote domain-joined Windows client computers. To create a sample infrastructure, you:

> [!div class="checklist"]
>
> - Create an Active Directory domain controller.
> - Configure Group Policy for autoenrollment of certificates.
> - Create a Network Policy Server (NPS) server.
> - Create a VPN server.
> - Create a VPN user and group.
> - Configure the VPN server as a RADIUS client.
> - Configure the NPS server as a RADIUS server.

To learn more about Always On VPN, including supported integrations, security and connectivity features, see [Always On VPN Overview](overview-always-on-vpn.md).

## Prerequisites

To complete the steps in this tutorial, you need to meet the following prerequisites:

- Three servers (physical or virtual) running a supported version Windows Server. These servers are the domain controller, NPS server, and VPN server.

- The server you use for the NPS server needs two physical network adapters installed: one to connect to the internet, and one to connect to the network where the domain controller is located.

- A user account on all machines that is a member of the local **Administrators** security group, or equivalent.

> [!IMPORTANT]
> Using Remote Access in Microsoft Azure isn't supported. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).

## Create the domain controller

1. On the server you want to be the domain controller, install [Active Directory Domain Services (AD DS)](/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview). For detailed information on how to install AD DS, see [Install Active Directory Domain Services](/windows-server/identity/ad-ds/deploy/install-active-directory-domain-services--level-100-#to-install-ad-ds-by-using-server-manager).

1. Promote the Windows Server to domain controller. For this tutorial, you create a new forest and the domain to that new forest. For detailed information on how to install the domain controller, see [AD DS Installation](/windows-server/identity/ad-ds/deploy/ad-ds-installation-and-removal-wizard-page-descriptions#dns-options).

1. Install and configure the Certificate Authority (CA) on the domain controller. For detailed information on how to install the CA, see [Install the Certification Authority](/windows-server/networking/core-network-guide/cncg/server-certs/install-the-certification-authority).

## Configure Group Policy for autoenrollment of certificates

In this section, you create a Group Policy on the domain controller so that domain members automatically request user and computer certificates. This configuration enables VPN users to request and retrieve user certificates that automatically authenticate VPN connections. This policy also allows the NPS server to request server authentication certificates automatically.

1. On the domain controller, open the Group Policy Management console.

1. In the left pane, right-click your domain (for example, `corp.contoso.com`). Select **Create a GPO in this domain, and Link it here**.

1. On the **New GPO** dialog box, for **Name**, enter *Autoenrollment Policy*. Select **OK**.

1. In the left pane, right-click **Autoenrollment Policy**. Select **Edit** to open the **Group Policy Management Editor**.

1. In **Group Policy Management Editor**, complete the following steps to configure computer certificate autoenrollment:

   1. Navigate to **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Public Key Policies**.

   1. In the details pane, right-click **Certificate Services Client – Auto-Enrollment**. Select **Properties**.

   1. On the **Certificate Services Client – Auto-Enrollment Properties** dialog box, for **Configuration Model**, select **Enabled**.

   1. Select **Renew expired certificates, update pending certificates, and remove revoked certificates** and **Update certificates that use certificate templates**.

   1. Select **OK**.

1. In **Group Policy Management Editor**, complete the following steps to configure user certificate autoenrollment:

   1. Navigate to **User Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Public Key Policies**.

   1. In the details pane, right-click **Certificate Services Client – Auto-Enrollment** and select **Properties**.

   1. On the **Certificate Services Client – Auto-Enrollment Properties** dialog box, in **Configuration Model**, select **Enabled**.

   1. Select **Renew expired certificates, update pending certificates, and remove revoked certificates** and **Update certificates that use certificate templates**.

   1. Select **OK**.

   1. Close Group Policy Management Editor.

1. Apply the Group Policy to users and computers in the domain.

1. Close the Group Policy Management console.

## Create the NPS server

1. On the server you want to be the NPS server, install the [Network Policy and Access Services (NPS) role](/windows-server/networking/technologies/nps/nps-top). For detailed information on how to install NPS, see [Install Network Policy Server](/windows-server/networking/technologies/nps/nps-manage-install).

1. Register the NPS Server in Active Directory. For information on how to register NPS Server in Active Directory, see [Register an NPS in an Active Directory Domain](/windows-server/networking/technologies/nps/nps-manage-register).

1. Make sure that your firewalls allow the traffic that is necessary for both VPN and RADIUS communications to function correctly. For more information, see [Configure Firewalls for RADIUS Traffic](../../networking/technologies/nps/nps-firewalls-configure.md).

1. Create the NPS Servers group:

   1. On the domain controller, open Active Directory Users and Computers.

   1. Under your domain, right-click **Computers**. Select **New**, then select **Group**.

   1. In **Group name**, enter **NPS Servers**, then select **OK**.

   1. Right-click **NPS Servers** and select **Properties**.

   1. On the **Members** tab of the NPS Servers Properties dialog box, select **Add**.

   1. Select **Object Types**, select the **Computers** check box, then select **OK**.

   1. In **Enter the object names to select**, enter the hostname of the NPS server. Select **OK**.

   1. Close Active Directory Users and Computers.

## Create the VPN server

1. For the server that runs the VPN server, ensure that the machine has two physical network adapters installed: one to connect to the internet, and one to connect to the network where the domain controller is located.

1. Identify which network adapter connects to the internet and which network adapter connects to the domain. Configure the network adapter facing the internet with a public IP address, while the adapter facing the intranet can use an IP address from the local network.

1. For the network adapter connecting to the domain, set the DNS preferred IP address to the IP address of the domain controller.

1. Join the VPN server to the domain. For information on how to join a server to a domain, see [To join a server to a domain](/windows-server/identity/ad-fs/deployment/join-a-computer-to-a-domain#to-join-a-server-to-a-domain).

1. Open your firewall rules to allow UDP ports 500 and 4500 inbound to the external IP address applied to the public interface on the VPN server. For the network adapter connecting to the domain, allow the following UDP ports: 1812, 1813, 1645, and 1646.

1. Create the VPN Servers group:

    1. On the domain controller, open **Active Directory Users and Computers**.

    1. Under your domain, right-click **Computers**. Select **New**, then select **Group**.

    1. In **Group name**, enter **VPN Servers**, then select **OK**.

    1. Right-click **VPN Servers** and select **Properties**.

    1. On the **Members** tab of the VPN Servers Properties dialog box, select **Add**.

    1. Select **Object Types**, select the **Computers** check box, then select **OK**.

    1. In **Enter the object names to select**, enter the hostname of the VPN server. Select **OK**.

    1. Close Active Directory Users and Computers.

1. Follow the steps in [Install Remote Access as a VPN server](get-started-install-ras-as-vpn.md) to install the VPN server.

1. Open **Routing and Remote Access** from Server Manager.

1. Right-click the name of the VPN server, and then select **Properties**.

1. In **Properties**, select the **Security** tab and then:

    1. Select **Authentication provider** and select **RADIUS Authentication**.

    1. Select **Configure** to open the RADIUS Authentication dialog.

    1. Select **Add** to open the Add RADIUS Server dialog.

        1. In **Server name**, enter the Fully Qualified Domain Name (FQDN) of the NPS server, which is also a RADIUS server. For example, if the NetBIOS name of your NPS and domain controller server is `nps1` and your domain name is `corp.contoso.com`, enter `nps1.corp.contoso.com`.

        1. In **Shared secret**, select **Change** to open the Change Secret dialog box.

        1. In **New secret**, enter a text string.

        1. In **Confirm new secret**, enter the same text string, then select **OK**.

        1. Save this secret. You need it when you add this VPN server as a RADIUS client later in this tutorial.

    1. Select **OK** to close the **Add RADIUS Server** dialog.

    1. Select **OK** to close the **RADIUS Authentication** dialog.

1. On the VPN server Properties dialog, select **Authentication Methods...**.

1. Select **Allow machine certificate authentication for IKEv2**.

1. Select **OK**.

1. For **Accounting provider**, select **Windows Accounting**.

1. Select **OK** to close the Properties dialog.

1. A dialog prompts you to restart the server. Select **Yes**.

## Create VPN user and group

1. Create a VPN user by taking the following steps:

   1. On the domain controller, open the **Active Directory Users and Computers** console.
   1. Under your domain, right-click **Users**. Select **New**. For **User logon name**, enter any name. Select **Next**.  
   1. Choose a password for the user.  
   1. Deselect **User must change password at next logon**. Select **Password never expires**.  
   1. Select **Finish**. Keep Active Directory Users and Computers open.

1. Create a VPN user group by taking the following steps:

   1. Under your domain, right-click **Users**. Select **New**, then select **Group**.  
   1. In **Group name**, enter **VPN Users**, then select **OK**.  
   1. Right-click **VPN Users** and select **Properties**.  
   1. On the **Members** tab of the VPN Users Properties dialog box, select **Add**.  
   1. On the Select Users dialog box, add the VPN user that you created and select **OK**.  

## Configure VPN server as a RADIUS client

1. On the NPS server, open your firewall rules to allow UDP ports 1812, 1813, 1645, and 1646 inbound, including the Windows Firewall.

1. Open the **Network Policy Server** console.

1. In the NPS console, double-click **RADIUS Clients and Servers**.

1. Right-click **RADIUS Clients** and select **New** to open the **New RADIUS Client** dialog box.

1. Verify that the **Enable this RADIUS client** check box is selected.

1. In **Friendly name**, enter a display name for the VPN server.

1. In **Address (IP or DNS)**, enter the IP address or the FQDN of the VPN server.

   If you enter the FQDN, select **Verify** if you want to verify that the name is correct and maps to a valid IP address.

1. In **Shared secret**:

   1. Ensure that **Manual** is selected.
   1. Enter the secret that you created in the [Create the VPN server section](#create-the-vpn-server).
   1. For **Confirm shared secret**, reenter the shared secret.

1. Select **OK**. The VPN Server should appear in the list of RADIUS clients configured on the NPS server.

## Configure NPS server as a RADIUS server

1. Register a server certificate for the NPS server, with a certificate that meets the requirements in [Configure Certificate Templates for PEAP and EAP requirements](../../networking/technologies/nps/nps-manage-cert-requirements.md). To verify that your Network Policy Server (NPS) servers are enrolled with a server certificate from the certification authority (CA), see [Verify Server Enrollment of a Server Certificate](../../networking/core-network-guide/cncg/server-certs/Verify-Server-Enrollment-of-a-Server-Certificate.md).

1. In the NPS console, select **NPS (Local)**.

1. In **Standard Configuration**, ensure that **RADIUS server for Dial-Up or VPN Connections** is selected.

1. Select **Configure VPN or Dial-Up** to open the **Configure VPN or Dial-Up** wizard.

1. Select **Virtual Private Network (VPN) Connections**, then select **Next**.

1. In **Specify Dial-Up or VPN Server**, in **RADIUS clients**, select the name of the VPN server.

1. Select **Next**.

1. In **Configure Authentication Methods**, complete the following steps:

    1. Clear **Microsoft Encrypted Authentication version 2 (MS-CHAPv2)**.

    1. Select **Extensible Authentication Protocol**.

    1. For **Type**, select **Microsoft: Protected EAP (PEAP)**. Then select **Configure** to open the **Edit Protected EAP Properties** dialog box.

    1. Select **Remove** to remove the Secured Password (EAP-MSCHAP v2) EAP type.

    1. Select **Add**. The Add EAP dialog box opens.

    1. Select **Smart Card or other certificate**, then select **OK**.

    1. Select **OK** to close Edit Protected EAP Properties.

1. Select **Next**.

1. In **Specify User Groups**, complete the following steps:

    1. Select **Add**. The **Select Users, Computers, Service Accounts, or Groups** dialog box opens.

    1. Enter **VPN Users**, then select **OK**.

    1. Select **Next**.

1. On **Specify IP Filters**, select **Next**.

1. On **Specify Encryption Settings**, select **Next**. Don't make any changes.

1. On **Specify a Realm Name**, select **Next**.

1. Select **Finish** to close the wizard.

## Next step

Now you created your sample infrastructure, you're ready to begin configuring your Certificate Authority.

> [!div class="nextstepaction"]
> [Tutorial: Configure Certificate Authority templates for Always On VPN](tutorial-aovpn-deploy-create-certificates.md)
