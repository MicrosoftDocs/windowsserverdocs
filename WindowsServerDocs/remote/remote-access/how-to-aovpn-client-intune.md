---
title: Deploy Always On VPN profile to Windows clients with Microsoft Intune
description:  Learn how to deploy Always On VPN profile to Windows clients with Microsoft Intune.
ms.topic: article
ms.date:  03/14/2023
ms.author: anaharris
author: anaharris-ms
---

# Deploy Always On VPN profile to Windows 10 or newer clients with Microsoft Intune

In this how-to article, we show you how to use Intune to create and deploy Always On VPN profiles.
 
However, if you want to create a custom VPN profileXML, follow the guidance in [Apply ProfileXML using Intune](/windows/security/identity-protection/vpn/vpn-profile-options#apply-profilexml-using-intune).

## Prerequisites

Intune uses Microsoft Entra user groups, so you need to:

- Ensure that you have a Private Key Infrastructure (PKI) capable of issuing user and device certificates for authentication. For more information on certificates for Intune, see [Use certificates for authentication in Microsoft Intune](/mem/intune/protect/certificates-configure).

- Create a Microsoft Entra user group that's associated with VPN users and assign new users to the group as needed.

- Make sure that the VPN users have VPN server connection permissions.

## Create the Extensible Authentication Protocol (EAP) configuration XML

In this section, you'll create an Extensible Authentication Protocol (EAP) configuration XML.

1. Copy the following XML string to a text editor:

    [!INCLUDE [important-lower-case-true-include](includes/important-lower-case-true-include.md)]

    ```XML
    <EapHostConfig xmlns="http://www.microsoft.com/provisioning/EapHostConfig"><EapMethod><Type xmlns="http://www.microsoft.com/provisioning/EapCommon">25</Type><VendorId xmlns="http://www.microsoft.com/provisioning/EapCommon">0</VendorId><VendorType xmlns="http://www.microsoft.com/provisioning/EapCommon">0</VendorType><AuthorId xmlns="http://www.microsoft.com/provisioning/EapCommon">0</AuthorId></EapMethod><Config xmlns="http://www.microsoft.com/provisioning/EapHostConfig"><Eap xmlns="http://www.microsoft.com/provisioning/BaseEapConnectionPropertiesV1"><Type>25</Type><EapType xmlns="http://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV1"><ServerValidation><DisableUserPromptForServerValidation>true</DisableUserPromptForServerValidation><ServerNames>NPS.contoso.com</ServerNames><TrustedRootCA>5a 89 fe cb 5b 49 a7 0b 1a 52 63 b7 35 ee d7 1c c2 68 be 4b </TrustedRootCA></ServerValidation><FastReconnect>true</FastReconnect><InnerEapOptional>false</InnerEapOptional><Eap xmlns="http://www.microsoft.com/provisioning/BaseEapConnectionPropertiesV1"><Type>13</Type><EapType xmlns="http://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV1"><CredentialsSource><CertificateStore><SimpleCertSelection>true</SimpleCertSelection></CertificateStore></CredentialsSource><ServerValidation><DisableUserPromptForServerValidation>true</DisableUserPromptForServerValidation><ServerNames>NPS.contoso.com</ServerNames><TrustedRootCA>5a 89 fe cb 5b 49 a7 0b 1a 52 63 b7 35 ee d7 1c c2 68 be 4b </TrustedRootCA></ServerValidation><DifferentUsername>false</DifferentUsername><PerformServerValidation xmlns="http://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV2">true</PerformServerValidation><AcceptServerName xmlns="http://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV2">true</AcceptServerName></EapType></Eap><EnableQuarantineChecks>false</EnableQuarantineChecks><RequireCryptoBinding>false</RequireCryptoBinding><PeapExtensions><PerformServerValidation xmlns="http://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV2">true</PerformServerValidation><AcceptServerName xmlns="http://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV2">true</AcceptServerName></PeapExtensions></EapType></Eap></Config></EapHostConfig>
    ```

1. Replace the **\<ServerNames>NPS.contoso.com\</ServerNames>** in the sample XML with the FQDN of the domain-joined NPS where authentication takes place.

1. Replace the **\<TrustedRootCA>5a 89 fe cb 5b 49 a7 0b 1a 52 63 b7 35 ee d7 1c c2 68 be 4b<\/TrustedRootCA>** in the sample with the certificate thumbprint of your on-premises root certificate authority in both places.

    >[!Important]
    >Do not use the sample thumbprint in the \<TrustedRootCA>\</TrustedRootCA> section below.  The TrustedRootCA must be the certificate thumbprint of the on-premises root certificate authority that issued the server-authentication certificate for RRAS and NPS servers. **This must not be the cloud root certificate, nor the intermediate issuing CA certificate thumbprint**.

1. Save the XML for use in the next section.

## Create the Always On VPN configuration policy

1. Sign into [Microsoft Endpoint Manager admin center](https://endpoint.microsoft.com/).

1. Go to **Devices** > **Configuration profiles**.

1. Select **+ Create profile**.

1. For **Platform**, select **Windows 10 and later**.

1. For **Profile type**, select **Templates**.

1. For **Template name**, select **VPN**.

1. Select **Create**.

1. For the **Basics** tab:

    - Enter a **Name** for the VPN profile and (optionally) a description.

1. For the  **Configuration settings** tab:

    1. For **Use this VPN profile with a user/device scope**, select **User**.

    1. For **Connection type:**, select **IKEv2**.

    1. For **Connection name:** enter the name of the VPN connection; for example, *Contoso AutoVPN*.

    1. For **Servers:**, add the VPN server addresses and descriptions. For the default server, set **Default server** to **True**.

    1. For **Register IP addresses with internal DNS**, select **Disable**.

    1. For **Always On:**, select **Enable**.

    1. For **Remember credentials at each logon**, select the value that's appropriate to your security policy.

    1. For **Authentication Method**, select **EAP**.

    1. For **EAP XML**, select the XML you saved in [Create the EAP XML](#create-the-extensible-authentication-protocol-eap-configuration-xml).

    1. For **Device Tunnel**, select *Disable*. To learn more about device tunnels, see [Configure VPN device tunnels in Windows 10](/windows-server/remote/remote-access/vpn/vpn-device-tunnel-config).

    1. For **IKE Security Association Parameters**
        - Set **Split tunneling** to *Enable*.
        - Configure **Trusted Network Detection**.  To find the DNS suffix, you can use `Get-NetConnectionProfile > Name` on a system that's currently connected to the network and has the domain profile applied (`NetworkCategory:DomainAuthenticated`).

    1. Leave the remaining settings as default, unless your environment requires further configuration. For more information on EAP Profile settings for Intune, see [Windows 10/11 and Windows Holographic device settings to add VPN connections using Intune](/mem/intune/configuration/vpn-settings-windows-10).

    1. Select **Next**.

1. For the **Scope Tags** tab, leave default settings and select **Next**.

1. For the **Assignments** tab:

    1. Select **Add groups**, and add your VPN user group.

    1. Select **Next**.

1. For the **Applicability Rules** tab, leave default settings and select **Next**.

1. For the **Review + Create** tab, review all your settings, and select **Create**.

### Sync the Always On VPN configuration policy with Intune

To test the configuration policy, sign in to a Windows 10+ client computer as a VPN user and then sync with Intune.

1. On the Start menu, select **Settings**.

1. In Settings, select **Accounts**, and select **Access work or school**.

1. Select the account to connect to your Microsoft Entra ID, and select **Info**.

1. Move down and select **Sync** to force an Intune policy evaluation and retrieval.

1. When the synchronization is complete, close **Settings**. After synchronization, you should be able to connect to your organization's VPN server.

## Next Steps

- For an in depth tutorial on how to set up Always On VPN, see [Tutorial: Setup infrastructure for Always On VPN](tutorial-aovpn-deploy-setup.md).

- To learn how to configure Always On VPN profiles with Microsoft Configuration Manager, see [Deploy Always On VPN profile to Windows clients with Microsoft Configuration Manager](how-to-aovpn-client-config-mgr.md)

- For more detailed information on Always on VPN configuration options for the configuration service provider (CSP), see [VPNv2 configuration service provider](/windows/client-management/mdm/vpnv2-csp).

- To troubleshoot VPN deployment in Microsoft Intune, see [Troubleshooting VPN profile issues in Microsoft Intune](/troubleshoot/mem/intune/device-configuration/troubleshoot-vpn-profiles?tabs=windows).
