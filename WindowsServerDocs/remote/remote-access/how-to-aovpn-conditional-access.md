---
title: Configure Conditional Access for VPN connectivity using Microsoft Entra ID
description: Learn how to configure Conditional Access for VPN connectivity using Microsoft Entra ID.
ms.topic: how-to
ms.date: 04/28/2026
ms.author: roharwoo
ms.reviewer: reshb05
author: robinharwood
ms.custom:
 - sfi-image-nochange
 - sfi-ga-nochange
 - msecd-doc-authoring-1012
---

# Configure Conditional Access for VPN connectivity using Microsoft Entra ID

This guide shows how to grant VPN users access to your resources by using [Microsoft Entra Conditional Access](/azure/active-directory/active-directory-conditional-access-azure-portal). By using Microsoft Entra Conditional Access for virtual private network (VPN) connectivity, you can help protect the VPN connections. Conditional Access is a policy-based evaluation engine that you can use to create access rules for any Microsoft Entra connected application.

## Prerequisites

Before you start configuring Conditional Access for your VPN, complete the following prerequisites:

- Review [Conditional Access in Microsoft Entra ID](/azure/active-directory/active-directory-conditional-access-azure-portal).
  - Administrators who interact with Conditional Access must have one of the following role assignments depending on the tasks they're performing. To follow the [Zero Trust principle of least privilege](/security/zero-trust/), consider using [Privileged Identity Management (PIM)](/entra/id-governance/privileged-identity-management/pim-configure) to just-in-time activate privileged role assignments.
    - [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader) access to read Conditional Access policies and configurations.
    - [Conditional Access Administrator](/entra/identity/role-based-access-control/permissions-reference#conditional-access-administrator) access to create or modify Conditional Access policies.
- Configure [VPN and Conditional Access](/windows/access-protection/vpn/vpn-conditional-access).
- Set up the Always On VPN infrastructure in your environment, or complete [Tutorial: Deploy Always On VPN - Setup infrastructure for Always On VPN](tutorial-aovpn-deploy-setup.md).
- Configure your Windows client computer with a VPN connection by using Intune. For details, see [Deploy Always On VPN profile to Windows clients with Microsoft Intune](how-to-aovpn-client-intune.md).

## Configure EAP-TLS to ignore Certificate Revocation List (CRL) checking

An EAP-TLS client can't connect unless the Network Policy Server (NPS) completes a revocation check of the certificate chain (including the root certificate). Cloud certificates issued to the user by Microsoft Entra ID don't have a CRL because they're short-lived certificates with a lifetime of one hour. You need to configure EAP on NPS to ignore the absence of a CRL. Since the authentication method is EAP-TLS, you only need to add this registry value under EAP\13. If you use other EAP authentication methods, add the registry value under those methods as well.

In this section, you add `IgnoreNoRevocationCheck` and `NoRevocationCheck`. By default, `IgnoreNoRevocationCheck` and `NoRevocationCheck` are set to 0 (disabled).

To learn more about NPS CRL registry settings, see [Configure Network Policy Server Certificate Revocation List check registry settings](../../networking/technologies/nps/network-policy-server-certificate-revocation-list-check-registry-settings.md).

> [!IMPORTANT]
> If a Windows Routing and Remote Access Server (RRAS) uses NPS to proxy RADIUS calls to a second NPS, then you must set `IgnoreNoRevocationCheck=1` on both servers.
>
> If you don't implement this registry change, IKEv2 connections using cloud certificates with PEAP fail, but IKEv2 connections using Client Auth certificates issued from the on-premises CA continue to work.

1. Open **regedit.exe** on the NPS.

1. Go to **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13**.

1. Select **Edit > New** and select **DWORD (32-bit) Value**. Enter **IgnoreNoRevocationCheck**.

1. Double-click **IgnoreNoRevocationCheck** and set the Value data to **1**.

1. Select **Edit > New** and select **DWORD (32-bit) Value**. Enter **NoRevocationCheck**.

1. Double-click **NoRevocationCheck** and set the Value data to **1**.

1. Select **OK** and reboot the server. Restarting the RRAS and NPS services isn't enough.

|Registry Path  |EAP Extension  |
|---------|---------|
|HKLM\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13     |EAP-TLS         |
|HKLM\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\25     |PEAP         |

<a name='create-root-certificates-for-vpn-authentication-with-azure-ad'></a>

## Create root certificates for VPN authentication with Microsoft Entra ID

In this section, you configure conditional access root certificates for VPN authentication with Microsoft Entra ID. When you create the first certificate, Microsoft Entra ID automatically creates a cloud app called **VPN Server** in the tenant. An administrator must grant admin consent for this application once before VPN connectivity is fully operational. To configure conditional access for VPN connectivity, complete the following steps:

1. Create a VPN certificate in the Azure portal.

1. Download the VPN certificate.

1. Deploy the certificate to your VPN and NPS servers.

> [!IMPORTANT]
> When you create a VPN certificate in the Azure portal, Microsoft Entra ID immediately starts using it to issue short-lived certificates to the VPN client. To avoid any problems with credential validation for the VPN client, it's critical to immediately deploy the VPN certificate to the VPN server.

When a user attempts a VPN connection, the VPN client makes a call into the Web Account Manager (WAM) on the Windows client. WAM makes a call to the VPN Server cloud app. When the Conditions and Controls in the Conditional Access policy are satisfied, Microsoft Entra ID issues a token in the form of a short-lived (one-hour) certificate to the WAM. The WAM places the certificate in the user's certificate store and passes control to the VPN client.

The VPN client then sends the certificate issued by Microsoft Entra ID to the VPN for credential validation. 

> [!NOTE]
> Microsoft Entra ID uses the most recently created certificate in the VPN connectivity pane as the Issuer. Microsoft Entra Conditional Access VPN connection leaf certificates now support strong certificate mappings, a certificate-based authentication requirement introduced by [KB5014754](https://support.microsoft.com/kb/5014754). VPN connection leaf certificates now include a [SID extension](/openspecs/windows_protocols/ms-wcce/e563cff8-1af6-4e6f-a655-7571ca482e71) of (1.3.6.1.4.1.311.25.2), which contains an encoded version of the user's SID obtained from the onPremisesSecurityIdentifier attribute.

### Create root certificates

1. Sign in to your [Azure portal](https://portal.azure.com) as a [Global Administrator](/entra/identity/role-based-access-control/permissions-reference#global-administrator).

1. On the left menu, select **Microsoft Entra ID**.

1. On the **Microsoft Entra ID** page, in the **Manage** section, select **Security**.

1. On the **Security** page, in the **Protect** section, select **Conditional Access**.

1. On the **Conditional Access | Policies** page, in the **Manage** section, select **VPN Connectivity**.

1. On the **VPN connectivity** page, select **New certificate**.

1. On the **New** page:
    1. For **Select duration**, select 1, 2, or 3 years.
    1. Select **Create**.

1. For the first VPN certificate you create in your tenant, a warning banner appears requesting admin consent for the **VPN Server** application. Select **Grant admin consent** (requires the [Global Administrator](/entra/identity/role-based-access-control/permissions-reference#global-administrator) role) and accept the requested permissions. You must take this action only once per tenant. Subsequent certificate operations don't require consent again.

> [!NOTE]
> If you don't see the consent banner, the VPN Server application has the required permissions.

## Configure the Conditional Access policy

In this section, you configure the conditional access policy for VPN connectivity. When you create the first root certificate in the **VPN connectivity** pane, you automatically create a **VPN Server** cloud application in the tenant.

Create a Conditional Access policy to assign to the VPN users group and scope the **Cloud app** to **VPN Server**:

- **Users**: **VPN Users**
- **Cloud App**: **VPN Server**
- **Grant (access control)**: **Require multifactor authentication**. You can use other controls if desired.

**Procedure:**
This step covers creation of the most basic Conditional Access policy. If desired, you can add more Conditions and Controls.

1. On the **Conditional Access** page, on the toolbar at the top, select **Add**.

    :::image type="content" source="../media/Always-On-Vpn/conditional-access-add.png" alt-text="Screenshot of Conditional Access page with Add button highlighted on the toolbar.":::

1. On the **New** page, in the **Name** box, enter a name for your policy. For example, enter **VPN policy**.

    :::image type="content" source="../media/Always-On-Vpn/policy-name-field.png" alt-text="Screenshot of Conditional Access New policy screen showing the Name field ready for input, before assignments are configured.":::

1. In the **Assignment** section, select **Users and groups**.

    :::image type="content" source="../media/Always-On-Vpn/assignments-users-groups.png" alt-text="Screenshot of the Users and groups option.":::

1. On the **Users and groups** page:

    :::image type="content" source="../media/Always-On-Vpn/select-users-groups.png" alt-text="Screenshot of the Users and groups page with Select users and groups option highlighted.":::

    1. Select **Select users and groups**.

    1. Select **Select**.

    1. On the **Select** page, select the **VPN users** group, and then select **Select**.

    1. On the **Users and groups** page, select **Done**.

1. On the **New** page:

    :::image type="content" source="../media/Always-On-Vpn/select-cloud-apps.png" alt-text="Screenshot of the Assignments interface after selecting Cloud apps, highlighting selectable app options.":::

    1. In the **Assignments** section, select **Cloud apps**.

    1. On the **Cloud apps** page, select **Select apps**.

    1. Select **Select**.

    1. On the **Select** page, select **VPN Server**.

1. On the **New** page, to open the **Grant** page, in the **Controls** section, select **Grant**.

    :::image type="content" source="../media/Always-On-Vpn/select-grant.png" alt-text="Screenshot of the Grant option.":::

1. On the **Grant** page:

    :::image type="content" source="../media/Always-On-Vpn/grant-controls.png" alt-text="Screenshot of Grant controls showing Require multi-factor authentication highlighted as part of policy setup.":::

    1. Select **Require multi-factor authentication**.

    1. Select **Select**.

1. On the **New** page, set **Enable policy** to **On**.

    :::image type="content" source="../media/Always-On-Vpn/enable-policy.png" alt-text="Screenshot of the New page with Enable policy set to On.":::

1. On the **New** page, select **Create**.

## Deploy Conditional Access root certificates to on-premises AD

In this section, you deploy a trusted root certificate for VPN authentication to your on-premises AD.

1. On the **VPN connectivity** page, select **Download certificate**.

   > [!NOTE]
   > The **Download base64 certificate** option is available for some configurations that require base64 certificates for deployment.

1. Sign in to a domain-joined computer with Enterprise Admin rights and run these commands from an Administrator command prompt to add the cloud root certificates into the *Enterprise NTauth* store:

   > [!NOTE]
   > For environments where the VPN server isn't joined to the Active Directory domain, you must add the cloud root certificates to the _Trusted Root Certification Authorities_ store manually.

   | Command | Description |
   | --- | --- |
   | `certutil -dspublish -f VpnCert.cer RootCA` | Creates two **Microsoft VPN root CA gen 1** containers under the **CN=AIA** and **CN=Certification Authorities** containers, and publishes each root certificate as a value on the _cACertificate_ attribute of both **Microsoft VPN root CA gen 1** containers. |
   | `certutil -dspublish -f VpnCert.cer NTAuthCA` | Creates one **CN=NTAuthCertificates** container under the **CN=AIA** and **CN=Certification Authorities** containers, and publishes each root certificate as a value on the _cACertificate_ attribute of the **CN=NTAuthCertificates** container. |
   | `gpupdate /force` | Expedites adding the root certificates to the Windows server and client computers. |

1. Verify that the root certificates are present in the Enterprise NTauth store and show as trusted:

   1. Sign in to a server with Enterprise Admin rights that has the **Certificate Authority Management Tools** installed.

       > [!NOTE]
       > By default, the **Certificate Authority Management Tools** are installed on Certificate Authority servers. You can install them on other members' servers as part of the **Role Administration Tools** in Server Manager.

   1. From the **Start** menu, enter **pkiview.msc** to open the **Enterprise PKI** dialog box.

   1. Right-click **Enterprise PKI** and select **Manage AD Containers**.

   1. Verify that each Microsoft VPN root CA gen 1 certificate is present under:
      - NTAuthCertificates
      - AIA Container
      - Certificate Authorities Container

## Create OMA-DM based VPNv2 profiles for Windows 10 devices

In this section, you create OMA-DM based VPNv2 profiles by using Intune to deploy a VPN Device Configuration policy.

1. In the Azure portal, select **Intune** > **Device Configuration** > **Profiles** and select the VPN profile you created in [Configure the VPN client by using Intune](how-to-aovpn-client-intune.md).

1. In the policy editor, select **Properties** > **Settings** > **Base VPN**. Extend the existing **EAP Xml** to include a filter that gives the VPN client the logic it needs to retrieve the Microsoft Entra Conditional Access certificate from the user's certificate store instead of using the first certificate discovered.

    > [!NOTE]
    > Without this filter, the VPN client might retrieve the user certificate issued from the on-premises certificate authority, resulting in a failed VPN connection.

    :::image type="content" source="../media/Always-On-Vpn/intune-eap-xml.png" alt-text="Screenshot of the Intune VPN profile settings displaying the EAP XML editor with added TLSExtensions and EKUMapping for certificate filtering." lightbox="../media/Always-On-Vpn/intune-eap-xml.png":::

1. Locate the section that ends with **\</AcceptServerName>\</EapType>** and insert the following string between these two values to provide the VPN client with the logic to select the Microsoft Entra Conditional Access Certificate:

    ```XML
    <TLSExtensions xmlns="http://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV2"><FilteringInfo xmlns="http://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV3"><EKUMapping><EKUMap><EKUName>AAD Conditional Access</EKUName><EKUOID>1.3.6.1.4.1.311.87</EKUOID></EKUMap></EKUMapping><ClientAuthEKUList Enabled="true"><EKUMapInList><EKUName>AAD Conditional Access</EKUName></EKUMapInList></ClientAuthEKUList></FilteringInfo></TLSExtensions>
    ```

1. In the **Conditional Access** pane, set **Conditional access for this VPN connection** to **Enable**.

   Enabling this setting changes the **\<DeviceCompliance>\<Enabled>true\</Enabled>** setting in the VPNv2 Profile XML.

    :::image type="content" source="../media/Always-On-Vpn/conditional-access-enable.png" alt-text="Screenshot of Azure portal Conditional Access pane with Conditional access for this VPN connection set to Enable." lightbox="../media/Always-On-Vpn/conditional-access-enable.png":::

1. Select **OK**.

1. Select **Assignments**. On the **Include** tab, select **Select groups to include**.

1. Select the correct group that receives this policy and select **Save**.

    :::image type="content" source="../media/Always-On-Vpn/user-assignments.png" alt-text="Screenshot of Assignments section in Conditional Access policy showing Include tab and group selection options.":::

## Force MDM policy sync on the client

If the VPN profile doesn't show up on the client device, under **Settings** > **Network & internet** > **VPN**, you can force MDM policy to sync.

1. Sign in to a domain-joined client computer as a member of the **VPN Users** group.

1. On the **Start** menu, enter **account**, and press **Enter**.

1. In the left navigation pane, select **Access work or school**.

1. Under Access work or school, select **Connected to <\domain> MDM**, and then select **Info**.

1. Select **Sync** and verify the VPN profile appears under **Settings** > **Network & internet** > **VPN**.

## Related content

- To learn more about how conditional access works with VPNs, see [VPN and conditional access](/windows/access-protection/vpn/vpn-conditional-access).

- To learn more about the advanced VPN features, see [Advanced VPN Features](vpn/always-on-vpn/deploy/always-on-vpn-adv-options.md#advanced-vpn-features).

- To see an overview of VPNv2 CSP, see [VPNv2 CSP](/windows/client-management/mdm/vpnv2-csp).
