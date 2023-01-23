---
title: Deploy Always On VPN profile to Windows 10+ clients with Microsoft InTune
description:  Learn how to deploy Always On VPN profile to Windows 10+ clients with Microsoft InTune
ms.topic: article
ms.date: 01/23/2022
ms.author: anaharris
author: anaharris-ms
---

# Deploy Always On VPN profile to Windows 10+ clients with Microsoft InTune

In this how-to article, we'll show you how to use InTune to deploy Always On VPN profiles to configure the ProfileXML CSP node using a base EAP XML sample XML.

## Prerequisites

InTune uses Azure Active Directory (AD) user groups, so you'll need to:

- Create an Azure AD user group that's associated with a VPN user authentication certificate, and you'll need to assign users to that group. For guidance on how to setup a VPN Users group, as well as a user certificate for VPN access, see [Tutorial: Setup infrastructure for Always On VPN](tutorial-aovpn-deploy-setup.md).

- Make sure that Azure AD Connect has synced to the VPN Users group from on-premises to Azure AD.

- Create the VPN device configuration policy to configure the Windows 10 client computers for all users added to the group. If you don't have one, you can create one using the steps provided in [](tutorial-aovpn-deploy-configure-client.md). Since the Intune template provides VPN parameters, only copy the \<EapHostConfig> \</EapHostConfig> portion of the VPN_ProfileXML file.

### Create the Always On VPN configuration policy

1. Sign into the [Azure portal](https://portal.azure.com/).

1. Go to **Intune** > **Device Configuration** > **Profiles**.

1. Select **Create Profile** to start the Create profile Wizard.

1. Enter a **Name** for the VPN profile and (optionally) a description.

1. Under **Platform**, select **Windows 10 or later**, and choose **VPN** from the Profile type drop-down.

     >[!TIP]
     >If you are creating a custom VPN profileXML, see [Apply ProfileXML using Intune](/windows/security/identity-protection/vpn/vpn-profile-options#apply-profilexml-using-intune) for the instructions.

1. Under the **Base VPN** tab, verify or set the following settings:

    - **Connection name:** Enter the name of the VPN connection as it appears on the client computer in the **VPN** tab under **Settings**, for example, _Contoso AutoVPN_.

    - **Servers:** Add one or more VPN servers by clicking **Add.**

    - **Description** and **IP Address or FQDN:** Enter the description and IP Address or FQDN of the VPN server. These values must align with the Subject Name in the VPN server's authentication certificate.

    - **Default server:** If this is the default VPN server, set to **True**. Doing this enables this server as the default server that devices use to establish the connection.

    - **Connection type:** Set to **IKEv2**.

    - **Always On:** Set to **Enable** to connect to the VPN automatically at the sign-in and stay connected until the user manually disconnects.

    - **Remember credentials at each logon**:  Boolean value (true or false) for caching credentials. If set to true, credentials are cached whenever possible.

1. Copy the following XML string to a text editor:

    [!INCLUDE [important-lower-case-true-include](includes/important-lower-case-true-include.md)]

    ```XML
    <EapHostConfig xmlns="https://www.microsoft.com/provisioning/EapHostConfig"><EapMethod><Type xmlns="https://www.microsoft.com/provisioning/EapCommon">25</Type><VendorId xmlns="https://www.microsoft.com/provisioning/EapCommon">0</VendorId><VendorType xmlns="https://www.microsoft.com/provisioning/EapCommon">0</VendorType><AuthorId xmlns="https://www.microsoft.com/provisioning/EapCommon">0</AuthorId></EapMethod><Config xmlns="https://www.microsoft.com/provisioning/EapHostConfig"><Eap xmlns="https://www.microsoft.com/provisioning/BaseEapConnectionPropertiesV1"><Type>25</Type><EapType xmlns="https://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV1"><ServerValidation><DisableUserPromptForServerValidation>true</DisableUserPromptForServerValidation><ServerNames>NPS.contoso.com</ServerNames><TrustedRootCA>5a 89 fe cb 5b 49 a7 0b 1a 52 63 b7 35 ee d7 1c c2 68 be 4b </TrustedRootCA></ServerValidation><FastReconnect>true</FastReconnect><InnerEapOptional>false</InnerEapOptional><Eap xmlns="https://www.microsoft.com/provisioning/BaseEapConnectionPropertiesV1"><Type>13</Type><EapType xmlns="https://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV1"><CredentialsSource><CertificateStore><SimpleCertSelection>true</SimpleCertSelection></CertificateStore></CredentialsSource><ServerValidation><DisableUserPromptForServerValidation>true</DisableUserPromptForServerValidation><ServerNames>NPS.contoso.com</ServerNames><TrustedRootCA>5a 89 fe cb 5b 49 a7 0b 1a 52 63 b7 35 ee d7 1c c2 68 be 4b </TrustedRootCA></ServerValidation><DifferentUsername>false</DifferentUsername><PerformServerValidation xmlns="https://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV2">true</PerformServerValidation><AcceptServerName xmlns="https://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV2">true</AcceptServerName></EapType></Eap><EnableQuarantineChecks>false</EnableQuarantineChecks><RequireCryptoBinding>false</RequireCryptoBinding><PeapExtensions><PerformServerValidation xmlns="https://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV2">true</PerformServerValidation><AcceptServerName xmlns="https://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV2">true</AcceptServerName></PeapExtensions></EapType></Eap></Config></EapHostConfig>
    ```

1. Replace the **\<TrustedRootCA>5a 89 fe cb 5b 49 a7 0b 1a 52 63 b7 35 ee d7 1c c2 68 be 4b<\/TrustedRootCA>** in the sample with the certificate thumbprint of your on-premises root certificate authority in both places.

    >[!Important]
    >Do not use the sample thumbprint in the \<TrustedRootCA>\</TrustedRootCA> section below.  The TrustedRootCA must be the certificate thumbprint of the on-premises root certificate authority that issued the server-authentication certificate for RRAS and NPS servers. **This must not be the cloud root certificate, nor the intermediate issuing CA certificate thumbprint**.

1. Replace the **\<ServerNames>NPS.contoso.com\</ServerNames>** in the sample XML with the FQDN of the domain-joined NPS where authentication takes place.

1. Copy the revised XML string and paste into the **EAP Xml** box under the Base VPN tab and select **OK**.

    An Always On VPN Device Configuration policy using EAP is created in Intune.

### Sync the Always On VPN configuration policy with Intune

<!-- Will this work? -->
To test the configuration policy, sign in to a Windows 10+ client computer and then sync with Intune.

1. On the Start menu, select **Settings**.

1. In Settings, select **Accounts**, and select **Access work or school**.

1. Select the MDM profile, and select **Info**.

1. Select **Sync** to force an Intune policy evaluation and retrieval.

1. Close Settings. After synchronization, you see the VPN profile available on the computer.

## Next Steps

- For an in depth tutorial on how to setup Always On VPN, see [Tutorial: Setup infrastructure for Always On VPN](tutorial-aovpn-deploy-setup.md).
- To learn how to configure Always On VPN profiles with Microsoft Configuration Manager, see [Deploy Always On VPN profile to Windows 10+ clients with Microsoft Configuration Manager](how-to-aovpn-client-config-mgr.md)
- For more detailed information on Always on VPN configuration options for the configuration service provider (CSP), see [VPNv2 configuration service provider](/windows/client-management/mdm/vpnv2-csp).