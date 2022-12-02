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

In this tutorial, you'll learn how to deploy Always On VPN (AOV) connections for Windows 10+ client computers that are working offsite (for example, from home, a customer site, or a public wireless access point). The scenario as presented in this tutorial is only for learning purposes and should not be used in in a production environment.

## Prerequisites

- For this tutorial, you'll need three Windows machines:
    - The first Windows Server machine will be the Domain Controller and will also function as a Certificate Authority and Network Policy server.
    - The second Windows machine will be the VPN Server. Ensure that the VPN server has one physical Ethernet network adapter that faces the internet. 
    - The third machine be should be running either Windows Server or Windows 10+. This machine will be a client test machine.
- Ensure that your user account is a member of **Administrators**, or equivalent.

## Setup the environment

1. On the one of the Windows Server machines, install [Active Directory Domain Services (AD DS)](/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview) to create the Domain Controller. For detailed information on how to install AD DS, see [Install Active Directory Domain Services](/windows-server/identity/ad-ds/deploy/install-active-directory-domain-services--level-100-).

1. On the Domain Controller, install the following two Server Roles:

    - [Active Directory Certificate Services (AD CS)](/windows-server/identity/ad-cs/index).  For detailed information on how to install AD CS, see [Install the Certificate Authority](/windows-server/networking/core-network-guide/cncg/server-certs/install-the-certification-authority).

    - [Network Policy and Access Services (NPS)](/windows-server//networking/technologies/nps/nps-top). For detailed information on how to install NSP, see [Install Network Policy Server](/windows-server/networking/technologies/nps/nps-manage-install).

1. On the second Windows Server machine, install the DirectAccess and VPN(RAS) role service to create the VPN server. For instruction on how to setup and configure RAS as a VPN server, see [Install Remote Access as a VPN server](getting-started-install-ras-as-vpn.md).

1. Join the VPN server to your domain.

1. Register the NPS Server in Active Directory. For detailed information on how to register NPS Server in Active Directory, see [Register an NPS in an Active Directory Domain](/windows-server/networking/technologies/nps/nps-manage-register).

1. Add the VPN Server as a RADIUS Client in NPS.

    1. On the NPS server, in the NPS console, double-click **RADIUS Clients and Servers**.

    2. Right-click **RADIUS Clients** and select **New** to open the New RADIUS Client dialog box.

    3. Verify that the **Enable this RADIUS client** check box is selected.

    4. In **Friendly name**, enter a display name for the VPN server.

    5. In **Address (IP or DNS)**, enter the NAS IP address or FQDN.

         If you enter the FQDN, select **Verify** if you want to verify that the name is correct and maps to a valid IP address.

    6. In **Shared secret**, do:

        1. Ensure that **Manual** is selected.

        2. Enter the strong text string that you also entered on the VPN server.

        3. Reenter the shared secret in Confirm shared secret.

    7. Select **OK**. The VPN Server appears in the list of RADIUS clients configured on the NPS server.

1. Configure NPS as a RADIUS for VPN Connections

    1. In the NPS console, in Standard Configuration, ensure that **RADIUS server for Dial-Up or VPN Connections** is selected.

    2. Select **Configure VPN or Dial-Up** to open the Configure VPN or Dial-Up wizard.

    3. Select **Virtual Private Network (VPN) Connections**, and select **Next**.

    4. In Specify Dial-Up or VPN Server, in RADIUS clients, select the name of the VPN Server that you added in the previous step. For example, if your VPN server NetBIOS name is RAS1, select **RAS1**.

    5. Select **Next**.

    6. In Configure Authentication Methods, complete the following steps:

        1. Clear the **Microsoft Encrypted Authentication version 2 (MS-CHAPv2)** check box.

        2. Select the **Extensible Authentication Protocol** check box to select it.

        3. For **Type** (based on the method of access and network configuration), select **Microsoft: Protected EAP (PEAP)**. Then select **Configure** to open the Edit Protected EAP Properties dialog box.

        4. Select **Remove** to remove the Secured Password (EAP-MSCHAP v2) EAP type.

        5. Select **Add**. The Add EAP dialog box opens.

        6. Select **Smart Card or other certificate**, then select **OK**.

        7. Select **OK** to close Edit Protected EAP Properties.

    7. Select **Next**.

    8. In Specify User Groups, complete the following steps:

        1. Select **Add**. The Select Users, Computers, Service Accounts, or Groups dialog box opens.

        2. Enter **VPN Users**, then select **OK**.

        3. Select **Next**.

    9. For **Specify IP Filters**, select **Next**.

    10. For **Specify Encryption Settings**, select **Next**. Do not make any changes.

        These settings apply only to Microsoft Point-to-Point Encryption (MPPE) connections, which this scenario doesn't support.

    11. For **Specify a Realm Name**, select **Next**.

    12. Select **Finish** to close the wizard.

    13. On the NPS server, open Windows PowerShell.

    14. At the Windows PowerShell prompt, type **gpupdate**, and then press ENTER.

1. Configure your firewalls. Make sure that your firewalls allow the traffic that is necessary for both VPN and RADIUS communications to function correctly.For more information, see [Configure Firewalls for RADIUS Traffic](../../../../networking/technologies/nps/nps-firewalls-configure.md).

<!-- Editorial note: Is this still true? -->
>[!IMPORTANT]
>Don't attempt to deploy Remote Access on a virtual machine (VM) in Microsoft Azure. Using Remote Access in Microsoft Azure is not supported, including both Remote Access VPN and DirectAccess. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).

## Next steps

[Deploy Always On VPN Tutorial: Setup Active Directory authentication](tutorial-aovpn-deploy-active-directory.md)