---
title: Tutorial - Deploy Always On VPN - Configure Windows 10+ Always On VPN client connections
description:  Learn how to deploy configure  Always On VPN client connections
ms.topic: article
ms.date: 01/06/2022
ms.assetid: d165822d-b65c-40a2-b440-af495ad22f42
ms.author: anaharris
author: anaharris-ms
---
# Tutorial: Deploy Always On VPN - Configure Always On VPN client connections

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10+

In this last part of the tutorial, you'll learn how to configure Always On VPN settings in Windows 10+ using the following configuration options:

- Manual PowerShell configuration directly on each client.
- Configuration Manager configuration for a group of clients.
- Microsoft InTune configuration for a group of clients.

For more detailed information on Always on VPN configuration options for the configuration service provider (CSP), see [VPNv2 configuration service provider](/windows/client-management/mdm/vpnv2-csp).

## Prerequisites

1. Complete [Tutorial: Deploy Always On VPN - Configure Certificate Authority templates](tutorial-aovpn-deploy-create-certificates.md).

1. Download [Sample Configuration Windows PowerShell Script](VPN-Profile.ps1).

## Create an Always On VPN client profile

In this section, we'll create a VPN client connection for the following reasons:

- Verify that the VPN test client can establish a successful VPN connection.

- Create the EAP settings for export in the next section.  For more information about EAP settings, see [EAP configuration](/windows/client-management/mdm/eap-configuration).

1. Sign in to the domain-joined VPN client computer as the VPN user you created in [Create Active Directory test user](tutorial-aovpn-deploy-setup.md#create-vpn-user-and-group).

1. On the Start menu, type **VPN** to select **VPN Settings**. Press ENTER.

1. In the details pane, select **Add a VPN connection**.

1. For **VPN Provider**, select *Windows (built-in)*.

1. For **Connection Name**, enter *Contoso VPN*.

1. For **Server name or address**, enter the **external** FQDN of your VPN server (for example, *vpn.contoso.com*).

1. For **VPN type**, select *IKEv2*.

1. For **Type of sing-in info**, select *Certificate*.

1. Select **Save**.

1. Under Related Settings, select **Change adapter options**.

1. Right-click **Contoso VPN**, and select **Properties**.

1. On the **Security** tab, for **Data encryption**, select *Maximum strength encryption*.

1. Select **Use Extensible Authentication Protocol (EAP)**. Then, for **Use Extensible Authentication Protocol (EAP)**, select *Microsoft: Protected EAP (PEAP) (encryption enabled)*.

1. Select **Properties** to open Protected EAP Properties, and complete the following steps:

    1. For **Connect to these servers**, enter the name of the NPS server. For this tutorial, the NPS server is on the domain controller.

    1. For **Trusted Root Certification Authorities**, select the CA that issued the NPS server's certificate (for example, contoso-CA).

    1. For **Notifications before connecting**, select *Don't ask user to authorize new servers or trusted CAs*.

    1. For **Select Authentication Method**, select **Smart Card or other certificate**.
  
    1. Select **Configure**.

        1. Select **Use a certificate on this computer**.

        1. For **Connect to these servers**, enter the name of the NPS server. For this tutorial, the NPS server is on the domain controller.

        1. For **Trusted Root Certification Authorities**, select the CA that issued the NPS server's certificate.

        1. Select **Don't prompt user to authorize new servers or trusted certification authorities**.

        1. Select **OK** to close Smart Card or other Certificate Properties.

        1. Select **OK** to close Protected EAP Properties.

    1. Select **OK** to close Contoso VPN Properties.

1. Close the Network Connections window.

1. In Settings, select **Contoso VPN**, and then select **Connect**.

>[!IMPORTANT]
>Make sure that the template VPN connection to your VPN server is successful. Doing so ensures that the EAP settings are correct before you use them in the next step. You must connect at least once before continuing; otherwise, the profile will not contain all the information necessary to connect to the VPN.

## Configure your Windows VPN clients

# [Manual Configuration](#tab/manual)

In this section, you'll manually configure the Windows VPN client with the PowerShell script, *VPN-Profile.ps1*, that you downloaded in [Prerequisites](#prerequisites).
  
1. Sign in as your VPN User to the VPN client computer.

1. Open Windows PowerShell integrated scripting environment (ISE) as Administrator.

1. Open `VPN-Profile.ps1`.

1. Set the value for the following variables at the top of the script: `$Domain`, `$TemplateName`, `$ProfileName`, `$Servers`, `$DnsSuffix`,  `$DomainName`, and `$DNSServers`. For more detailed information about how to set these variables, see: [VPNv2 CSP](/windows/client-management/mdm/vpnv2-csp).

1. Press ENTER to run the script.

1. Verify that the script was successful by running the following command in the Windows PowerShell ISE:

```powershell
    Get-CimInstance -Namespace root\cimv2\mdm\dmmap -ClassName MDM_VPNv2_01
```

1. You should see the following output (the ProfileXML value has been truncated for readability):

```powershell

AlwaysOn                : True
ByPassForLocal          : 
DeviceTunnel            : 
DnsSuffix               : corp.contoso.com
EdpModeId               : 
InstanceID              : Contoso%20AlwaysOn%20VPN
LockDown                : 
ParentID                : ./Vendor/MSFT/VPNv2
ProfileXML              : <VPNProfile>...</VPNProfile>
RegisterDNS             : 
RememberCredentials     : True
TrustedNetworkDetection : corp.contoso.com
PSComputerName          : 
```

# [Configuration Manager Configuration](#tab/config)

In Configuration Manager, you can deploy VPN profiles with the `VPN_Profile.ps1` PowerShell script.

To use Configuration Manager to deploy a Remote Access Always On VPN profile to Windows 10+ client computers, you'll need to create a group of machines or users to whom you'll deploy the profile. 

### Create a user group

1.  In the Configuration Manager console, open Assets and Compliance\\User Collections.

2.  On the **Home** ribbon, in the **Create** group, select **Create User Collection**.

3.  On the General page, complete the following steps:

    a. In **Name**, type **VPN Users**.

    b. Select **Browse**, select **All Users** and select **OK**.

    c. Select **Next**.

4.  On the Membership Rules page, complete the following steps:

    a.  In **Membership rules**, select **Add Rule**, and select **Direct Rule**. In this example, you're adding individual users to the user collection. However, you might use a query rule to add users to this collection dynamically for a larger-scale deployment.

    b.  On the **Welcome** page, select **Next**.

    c.  On the Search for Resources page, in **Value**, type the name of the user you want to add. The resource name includes the user's domain. To include results based on a partial match, insert the **%** character at either end of your search criterion. For example, to find all users containing the string "lori," type **%lori%**. Select **Next**.

    d.  On the Select Resources page, select the users you want to add to the group, and select **Next**.

    e.  On the Summary page, select **Next**.

    f.  On the Completion page, select **Close**.

6.  Back on the Membership Rules page of the Create User Collection Wizard, select **Next**.

7.  On the Summary page, select **Next**.

8.  On the Completion page, select **Close**.

After you create the user group to receive the VPN profile, you can create a package and program to deploy the Windows PowerShell configuration script (VPN_Profile.ps1).

### Create a package containing the ProfileXML configuration script

1.  Host the script VPN_Profile.ps1 on a network share that the site server computer account can access.

2.  In the Configuration Manager console, open **Software Library\\Application Management\\Packages**.

3.  On the **Home** ribbon, in the **Create** group, select **Create Package** to start the Create Package and Program Wizard.

4.  On the Package page, complete the following steps:

    a. In **Name**, type **Windows 10 Always On VPN Profile**.

    b. Select the **This package contains source files** check box, and select **Browse**.

    c. In the Set Source Folder dialog box, select **Browse**, select the file share containing VPN_Profile.ps1, and select **OK**.
        Make sure you select a network path, not a local path. In other words, the path should be something like *\\fileserver\\vpnscript*, not *c:\\vpnscript*.

1.  Select **Next**.

2.  On the Program Type page, select **Next**.

3.  On the Standard Program page, complete the following steps:

    a.  In **Name**, type **VPN Profile Script**.

    b.  In **Command line**, type **PowerShell.exe -ExecutionPolicy Bypass -File        "VPN_Profile.ps1"**.

    c.  In **Run mode**, select **Run with administrative rights**.

    d.  Select **Next**.

4.  On the Requirements page, complete the following steps:

    a.  Select **This program can run only on specified platforms**.

    b.  Select the **All Windows 10 (32-bit)** and **All Windows 10 (64-bit)** check boxes.

    c.  In **Estimated disk space**, type **1**.

    d.  In **Maximum allowed run time (minutes)**, type **15**.

    e.  Select **Next**.

5.  On the Summary page, select **Next**.

6.  On the Completion page, select **Close**.

With the package and program created, you need to deploy it to the **VPN Users** group.

### Deploy the ProfileXML configuration script

1.  In the Configuration Manager console, open Software Library\\Application Management\\Packages.

2.  In **Packages**, select **Windows 10 Always On VPN Profile**.

3.  On the **Programs** tab, at the bottom of the details pane, right-select **VPN Profile Script**, select **Properties**, and complete the following steps:

    a.  On the **Advanced** tab, in **When this program is assigned to a computer**, select **Once for every user who logs on**.

    b.  Select **OK**.

4.  Right-click **VPN Profile Script** and select **Deploy** to start the Deploy Software Wizard.

5.  On the General page, complete the following steps:

    a.  Beside **Collection**, select **Browse**.

    b.  In the **Collection Types** list (top left), select **User Collections**.

    c.  Select **VPN Users**, and select **OK**.

    d.  Select **Next**.

6.  On the Content page, complete the following steps:

    a.  Select **Add**, and select **Distribution Point**.

    b.  In **Available distribution points**, select the distribution points to which you want to distribute the ProfileXML configuration script, and select **OK**.

    c.  Select **Next**.

7.  On the Deployment settings page, select **Next**.

8.  On the Scheduling page, complete the following steps:

    a.  Select **New** to open the Assignment Schedule dialog box.

    b.  Select **Assign immediately after this event**, and select **OK**.

    c.  Select **Next**.

9.  On the User Experience page, complete the following steps:

    1.  Select the **Software Installation** check box.

    2.  Select **Summary**.

10. On the Summary page, select **Next**.

11. On the Completion page, select **Close**.

With the ProfileXML configuration script deployed, sign in to a Windows 10 client computer with the user account you selected when you built the user collection. Verify the configuration of the VPN client.

>[!NOTE]
>The script VPN_Profile.ps1 does not work in a Remote Desktop session. Likewise, it does not work in a Hyper-V enhanced session. If you're testing a Remote Access Always On VPN in virtual machines, disable enhanced session on your client VMs before continuing.

### Verify the configuration of the VPN client

1.  In Control Panel, under **System\\Security**, select **Configuration Manager**.

2.  In the Configuration Manager Properties dialog, on the **Actions** tab, complete the following steps:

    a.  Select **Machine Policy Retrieval & Evaluation Cycle**, select **Run Now**, and select **OK**.

    b.  Select **User Policy Retrieval & Evaluation Cycle**, select **Run Now**, and select **OK**.

    c.  Select **OK**.

3.  Close the Control Panel.

You should see the new VPN profile shortly.

# [InTune Configuration](#tab/intune)

To use Intune to deploy Windows 10 Remote Access Always On VPN profiles, you can configure the ProfileXML CSP node by using VPN_Profile.xml, or you can use the base EAP XML sample provided below.

>[!NOTE]
>Intune now uses Azure AD groups. If Azure AD Connect synced the VPN Users group from on-premises to Azure AD, and users are assigned to the VPN Users group, you are ready to proceed.

Create the VPN device configuration policy to configure the Windows 10 client computers for all users added to the group. Since the Intune template provides VPN parameters, only copy the \<EapHostConfig> \</EapHostConfig> portion of the VPN_ProfileXML file.

### Create the Always On VPN configuration policy

1.    Sign into the [Azure portal](https://portal.azure.com/).

2.    Go to **Intune** > **Device Configuration** > **Profiles**.

3.    Select **Create Profile** to start the Create profile Wizard.

4.    Enter a **Name** for the VPN profile and (optionally) a description.

1.   Under **Platform**, select **Windows 10 or later**, and choose **VPN** from the Profile type drop-down.

     >[!TIP]
     >If you are creating a custom VPN profileXML, see [Apply ProfileXML using Intune](/windows/security/identity-protection/vpn/vpn-profile-options#apply-profilexml-using-intune) for the instructions.

2. Under the **Base VPN** tab, verify or set the following settings:

    - **Connection name:** Enter the name of the VPN connection as it appears on the client computer in the **VPN** tab under **Settings**, for example, _Contoso AutoVPN_.

    - **Servers:** Add one or more VPN servers by clicking **Add.**

    - **Description** and **IP Address or FQDN:** Enter the description and IP Address or FQDN of the VPN server. These values must align with the Subject Name in the VPN server's authentication certificate.

    - **Default server:** If this is the default VPN server, set to **True**. Doing this enables this server as the default server that devices use to establish the connection.

    - **Connection type:** Set to **IKEv2**.

    - **Always On:** Set to **Enable** to connect to the VPN automatically at the sign-in and stay connected until the user manually disconnects.

    - **Remember credentials at each logon**:  Boolean value (true or false) for caching credentials. If set to true, credentials are cached whenever possible.

3.  Copy the following XML string to a text editor:

    [!INCLUDE [important-lower-case-true-include](includes/important-lower-case-true-include.md)]


    ```XML
    <EapHostConfig xmlns="https://www.microsoft.com/provisioning/EapHostConfig"><EapMethod><Type xmlns="https://www.microsoft.com/provisioning/EapCommon">25</Type><VendorId xmlns="https://www.microsoft.com/provisioning/EapCommon">0</VendorId><VendorType xmlns="https://www.microsoft.com/provisioning/EapCommon">0</VendorType><AuthorId xmlns="https://www.microsoft.com/provisioning/EapCommon">0</AuthorId></EapMethod><Config xmlns="https://www.microsoft.com/provisioning/EapHostConfig"><Eap xmlns="https://www.microsoft.com/provisioning/BaseEapConnectionPropertiesV1"><Type>25</Type><EapType xmlns="https://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV1"><ServerValidation><DisableUserPromptForServerValidation>true</DisableUserPromptForServerValidation><ServerNames>NPS.contoso.com</ServerNames><TrustedRootCA>5a 89 fe cb 5b 49 a7 0b 1a 52 63 b7 35 ee d7 1c c2 68 be 4b </TrustedRootCA></ServerValidation><FastReconnect>true</FastReconnect><InnerEapOptional>false</InnerEapOptional><Eap xmlns="https://www.microsoft.com/provisioning/BaseEapConnectionPropertiesV1"><Type>13</Type><EapType xmlns="https://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV1"><CredentialsSource><CertificateStore><SimpleCertSelection>true</SimpleCertSelection></CertificateStore></CredentialsSource><ServerValidation><DisableUserPromptForServerValidation>true</DisableUserPromptForServerValidation><ServerNames>NPS.contoso.com</ServerNames><TrustedRootCA>5a 89 fe cb 5b 49 a7 0b 1a 52 63 b7 35 ee d7 1c c2 68 be 4b </TrustedRootCA></ServerValidation><DifferentUsername>false</DifferentUsername><PerformServerValidation xmlns="https://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV2">true</PerformServerValidation><AcceptServerName xmlns="https://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV2">true</AcceptServerName></EapType></Eap><EnableQuarantineChecks>false</EnableQuarantineChecks><RequireCryptoBinding>false</RequireCryptoBinding><PeapExtensions><PerformServerValidation xmlns="https://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV2">true</PerformServerValidation><AcceptServerName xmlns="https://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV2">true</AcceptServerName></PeapExtensions></EapType></Eap></Config></EapHostConfig>
    ```

4.  Replace the **\<TrustedRootCA>5a 89 fe cb 5b 49 a7 0b 1a 52 63 b7 35 ee d7 1c c2 68 be 4b<\/TrustedRootCA>** in the sample with the certificate thumbprint of your on-premises root certificate authority in both places.

    >[!Important]
    >Do not use the sample thumbprint in the \<TrustedRootCA>\</TrustedRootCA> section below.  The TrustedRootCA must be the certificate thumbprint of the on-premises root certificate authority that issued the server-authentication certificate for RRAS and NPS servers. **This must not be the cloud root certificate, nor the intermediate issuing CA certificate thumbprint**.

5.  Replace the **\<ServerNames>NPS.contoso.com\</ServerNames>** in the sample XML with the FQDN of the domain-joined NPS where authentication takes place.

6.  Copy the revised XML string and paste into the **EAP Xml** box under the Base VPN tab and select **OK**.
    An Always On VPN Device Configuration policy using EAP is created in Intune.


### Sync the Always On VPN configuration policy with Intune

To test the configuration policy, sign in to a Windows 10 client computer as the user you added to the **Always On VPN Users** group, and then sync with Intune.

1.  On the Start menu, select **Settings**.

2.  In Settings, select **Accounts**, and select **Access work or school**.

3.  Select the MDM profile, and select **Info**.

4.  Select **Sync** to force an Intune policy evaluation and retrieval.

5.  Close Settings. After synchronization, you see the VPN profile available on the computer.

---

## Next steps

You are done deploying Always On VPN.  For other features you can configure, see the table below:

|If you want to...  |Then see...  |
|---------|---------|
|Configure Conditional Access for VPN    |[Step 7. (Optional) Configure conditional access for VPN connectivity using Azure AD](vpn/ad-ca-vpn-connectivity-windows10.md): In this step, you can fine-tune how authorized VPN users access your resources using [Azure Active Directory (Azure AD) conditional access](/azure/active-directory/active-directory-conditional-access-azure-portal). With Azure AD conditional access for virtual private network (VPN) connectivity, you can help protect the VPN connections. Conditional Access is a policy-based evaluation engine that lets you create access rules for any Azure Active Directory (Azure AD) connected application.         |
|Learn more about the advanced VPN features  |[Advanced VPN Features](vpn/always-on-vpn/deploy/always-on-vpn-adv-options.md#advanced-vpn-features): This page provides guidance on how to enable VPN Traffic Filters, how to configure Automatic VPN connections using App-Triggers, and how to configure NPS to only allow VPN Connections from clients using certificates issued by Azure AD.        |
