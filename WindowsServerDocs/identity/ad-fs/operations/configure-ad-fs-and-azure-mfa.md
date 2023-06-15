---
title: Configure AD FS and Azure AD Multi-Factor Authentication
description: Learn more about configuring Azure AD Multi-Factor Authentication as authentication provider using AD FS.
ms.author: billmath
author: billmath
manager: amycolannino
ms.date: 06/15/2023
ms.topic: article
---

# Configure Azure AD Multi-Factor Authentication as authentication provider using AD FS

Applies to: Windows 2016 and later

If your organization is federated with Azure AD, you can use Azure AD Multi-Factor Authentication to secure AD FS resources, both on-premises and in the cloud. Azure AD Multi-Factor Authentication enables you to eliminate passwords and provide a more secure way to authenticate. With AD FS, you can configure Azure AD Multi-Factor Authentication for primary authentication or use it as an extra authentication provider.

Unlike with AD FS in Windows Server 2012 R2, the AD FS 2016 Azure AD Multi-Factor Authentication adapter integrates directly with Azure AD and doesn't require an on premises Azure AD Multi-Factor Authentication server. The Azure AD Multi-Factor Authentication adapter is built in to Windows Server 2016. No other installation is required.

## Register users for Azure AD Multi-Factor Authentication using AD FS

AD FS doesn't support inline "proofup" (registration of Azure AD Multi-Factor Authentication security verification information such as phone number or mobile app). Without support for inline proof, users must get proofed up by visiting [https://account.activedirectory.windowsazure.com/Proofup.aspx](https://account.activedirectory.windowsazure.com/Proofup.aspx) prior to using Azure AD Multi-Factor Authentication to authenticate to AD FS applications.
When a user that hasn't yet proofed up in Azure AD tries to authenticate with Azure AD Multi-Factor Authentication at AD FS, you get an AD FS error.  As an AD FS administrator, you can customize this error experience to guide the user to the proofup page instead.  You can do this using onload.js customization to detect the error message string within the AD FS page and show a new message to direct the user to [https://aka.ms/mfasetup](https://aka.ms/mfasetup) to reattempt authentication. For detailed guidance, see [Customize the AD FS web page to guide users to register MFA verification methods](#customize-the-ad-fs-web-page-to-guide-users-to-register-mfa-verification-methods) in this article.

>[!NOTE]
> Prior to this update, users had to authenticate using Azure AD Multi-Factor Authentication for registration (by visiting [https://account.activedirectory.windowsazure.com/Proofup.aspx](https://account.activedirectory.windowsazure.com/Proofup.aspx), for example using the shortcut [https://aka.ms/mfasetup](https://aka.ms/mfasetup)). With this update, an AD FS user who has not yet registered Azure AD Multi-Factor Authentication verification information can access the Azure proofup page using the shortcut [https://aka.ms/mfasetup](https://aka.ms/mfasetup) using only primary authentication (such as Windows Integrated Authentication or username and password at the AD FS web pages). If the user has no verification methods configured, Azure AD performs inline registration; the user sees the message "Your admin has required that you set up this account for additional security verification." Then the user selects **Set it up now.**
> Users who already have at least one verification method configured will still be prompted to provide multi-factor authentication (MFA) when visiting the proofup page.

## Recommended deployment topologies

This section covers using Azure AD Multi-Factor Authentication as the primary authentication method with AD FS and Azure AD Multi-Factor Authentication for Office 365.

### Azure AD Multi-Factor Authentication as primary authentication

There are a couple of great reasons to use Azure AD Multi-Factor Authentication as Primary Authentication with AD FS:

- To avoid passwords for sign-in to Azure AD, Office 365 and other AD FS apps
- To protect password based sign-in by requiring another factor such as verification code prior to the password

You also may want to use Azure AD Multi-Factor Authentication as the primary authentication method and Azure AD conditional access, including true MFA by prompting for extra factors. To use Azure AD MFA on premises, you can configure the Azure AD domain setting by setting `SupportsMfa` to `$True`. In this configuration, Azure AD can prompt AD FS to perform extra authentication or &#34;true MFA&#34; for conditional access scenarios that require it.

Any AD FS user who isn't registered (hasn't yet configured MFA verification information) should be prompted to configure verification information. To prompt unregistered users, you can use a customized AD FS error page to direct users to [https://aka.ms/mfasetup](https://aka.ms/mfasetup) and configure verification information. Once configured they can reattempt their AD FS sign-in.

Azure AD Multi-Factor Authentication as primary authentication is considered a single factor. After initial configuration users need to provide another factor to manage or update their verification information in Azure AD, or to access other resources that require MFA.

>[!NOTE]
> With AD FS 2019, you're required to make a modification to the anchor claim type for the Active Directory Claims Provider trust and modify this from the `windowsaccountname` to UPN. Execute the following PowerShell cmdlet. This has no impact on the internal functioning of the AD FS farm. It's possible a few users may be re-prompted for credentials after this change is made. After logging in again, end users will see no difference.

```powershell
Set-AdfsClaimsProviderTrust -AnchorClaimType "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/upn" -TargetName "Active Directory"
```

### Azure AD Multi-Factor Authentication as extra authentication to Office 365

Azure AD Multi-Factor Authentication adapter for AD FS enables your users to do MFA on AD FS. To secure your Azure AD resource, it's recommended you require MFA through a [Conditional Access policy](/azure/active-directory/conditional-access/howto-conditional-access-policy-all-users-mfa). You must also set the domain setting `SupportsMfa` to `$True` and [emit the multipleauthn claim](/azure/active-directory/authentication/howto-mfa-adfs#secure-azure-ad-resources-using-ad-fs) when a user performs two-step verification successfully.

As described previously, any AD FS user who isn't registered (hasn't yet configured MFA verification information) should be prompted to configure verification information. To prompt unregistered users, you can use a customized AD FS error page to direct users to [https://aka.ms/mfasetup](https://aka.ms/mfasetup) and configure verification information. Once configured they can reattempt their AD FS sign-in.

## Prerequisites

The following prerequisites are required when using Azure AD Multi-Factor Authentication for authentication with AD FS:

- An [Azure subscription with Azure Active Directory](https://azure.microsoft.com/pricing/free-trial/).
- [Azure AD Multi-Factor Authentication](/azure/active-directory/authentication/concept-mfa-howitworks)

> [!NOTE]
> Azure AD and Azure AD Multi-Factor Authentication are included in Azure AD Premium and the Enterprise Mobility Suite (EMS).  You do not need individual subscriptions if you have either of these applications installed.

- A Windows Server 2016 AD FS on-premises environment.
  - The server needs to be able to communicate with the following URLs over port 443.
    - https://adnotifications.windowsazure.com
      - https://login.microsoftonline.com
- Your on-premises environment is [federated with Azure AD.](/azure/active-directory/hybrid/how-to-connect-install-custom#configuring-federation-with-ad-fs)
- [Microsoft Azure Active Directory Module for Windows PowerShell](/powershell/module/azuread/).
- Global administrator permissions on your instance of Azure AD to configure it using Azure AD PowerShell.
- Enterprise administrator credentials to configure the AD FS farm for Azure AD Multi-Factor Authentication.

## Configure the AD FS Servers

In order to complete configuration for Azure AD Multi-Factor Authentication for AD FS, you need to configure each AD FS server using the steps described here.

>[!NOTE]
>Ensure that these steps are performed on **all** AD FS servers in your farm. If you've multiple AD FS servers in your farm, you can perform the necessary configuration remotely using Azure AD PowerShell.

### Step 1: Generate a certificate for Azure AD Multi-Factor Authentication on each AD FS server

The first thing you need to do is to use the `New-AdfsAzureMfaTenantCertificate` PowerShell command to generate a certificate for Azure AD Multi-Factor Authentication to use. After you generate the certificate, find it in the local machines certificate store. The certificate is marked with a subject name containing the TenantID for your Azure AD directory.

![Screenshot of the certificate store of a local machine showing the generated certificate.](media/Configure-AD-FS-2016-and-Azure-MFA/ADFS_AzureMFA3.png)

The TenantID is the name of your directory in Azure AD. Use the following PowerShell cmdlet to generate the new certificate:

```powershell
$certbase64 = New-AdfsAzureMfaTenantCertificate -TenantID <tenantID>
```

![Screenshot of the PowerShell window showing the cmdlet above.](media/Configure-AD-FS-2016-and-Azure-MFA/ADFS_AzureMFA1.PNG)

### Step 2: Add the new credentials to the Azure Multi-Factor Auth Client Service Principal

In order to enable the AD FS servers to communicate with the Azure Multi-Factor Auth Client, you need to add the credentials to the Service Principal for the Azure Multi-Factor Auth Client. The certificates generated using the `New-AdfsAzureMFaTenantCertificate` cmdlet serves as these credentials. Using PowerShell, perform the following steps to add the new credentials to the Azure Multi-Factor Auth Client Service Principal.

> [!NOTE]
> In order to complete this step you need to connect to your instance of Azure AD with PowerShell using `Connect-MsolService`.  These steps assume you've already connected via PowerShell.  For information see [`Connect-MsolService`.](/previous-versions/azure/dn194123(v=azure.100))

#### Set the certificate as the new credential against the Azure Multi-Factor Auth Client

```powershell
New-MsolServicePrincipalCredential -AppPrincipalId 981f26a1-7f43-403b-a875-f8b09b8cd720 -Type asymmetric -Usage verify -Value $certBase64
```

> [!IMPORTANT]
> This command needs to be run on all of the AD FS servers in your farm. Azure AD MFA will fail on servers that haven't had the certificate set as the new credential against the Azure Multi-Factor Auth Client.

> [!NOTE]
> 981f26a1-7f43-403b-a875-f8b09b8cd720 is the GUID for Azure Multi-Factor Auth Client.

## Configure the AD FS Farm

After you've completed the steps in the previous section for each AD FS server, set the Azure tenant information using the [Set-AdfsAzureMfaTenant](/powershell/module/adfs/export-adfsauthenticationproviderconfigurationdata) cmdlet. This cmdlet needs to be executed only once for an AD FS farm.

Open a PowerShell prompt and enter your own *tenantId* with the [Set-AdfsAzureMfaTenant](/powershell/module/adfs/export-adfsauthenticationproviderconfigurationdata) cmdlet. For customers that use Microsoft Azure Government cloud, add the `-Environment USGov` parameter:

> [!NOTE]
> You need to restart the AD FS service on each server in your farm before these changes take effect. For minimal impact, take each AD FS server out of the NLB rotation one at a time and wait for all connections to drain.

```powershell
Set-AdfsAzureMfaTenant -TenantId <tenant ID> -ClientId 981f26a1-7f43-403b-a875-f8b09b8cd720
```

![Screenshot of the PowerShell window showing the warning message received after running the Set-AdfsAzureMfaTenant cmdlet.](media/Configure-AD-FS-2016-and-Azure-MFA/ADFS_AzureMFA5.png)

Windows Server without the latest service pack doesn't support the `-Environment` parameter for the [Set-AdfsAzureMfaTenant](/powershell/module/adfs/export-adfsauthenticationproviderconfigurationdata) cmdlet. If you use Azure Government cloud and the previous steps failed to configure your Azure tenant due to the missing `-Environment` parameter, complete the following steps to manually create the registry entries. Skip these steps if the previous cmdlet correctly registered your tenant information or if you aren't in the Azure Government cloud:

1. Open **Registry Editor** on the AD FS server.
1. Navigate to `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ADFS`. Create the following registry key values:

    | Registry key       | Value |
    |--------------------|-----------------------------------|
    | SasUrl             | https://adnotifications.windowsazure.us/StrongAuthenticationService.svc/Connector |
    | StsUrl             | https://login.microsoftonline.us |
    | ResourceUri        | https://adnotifications.windowsazure.us/StrongAuthenticationService.svc/Connector |

1. Restart the AD FS service on each server in the farm before these changes take effect. To reduce the effect on your systems, take each AD FS server out of the NLB rotation one at a time and wait for all connections to drain.

After this step, you'll see that Azure AD Multi-Factor Authentication is available as a primary authentication method for intranet and extranet use.

![Screenshot of the Edit Authentication Methods dialog box showing the Azure M F A option highlighted in both the Extranet and Intranet sections.](media/Configure-AD-FS-2016-and-Azure-MFA/ADFS_AzureMFA6.png)

If you want to use Azure AD Multi-Factor Authentication as a secondary authentication method, on the Edit Authentication Methods box, select the Multi-factor tab (the Additional tab in AD FS 2019) and ensure that it's enabled. Otherwise you might receive error messages, such as, "No valid strong authentication method found. Contact your administrator to configure and enable an appropriate strong authentication provider."

## Renew and Manage AD FS Azure AD Multi-Factor Authentication Certificates

The following guidance is designed to help you manage the Azure AD Multi-Factor Authentication certificates on your AD FS servers.

By default, when you configure AD FS with Azure AD Multi-Factor Authentication, the certificates generated via the `New-AdfsAzureMfaTenantCertificate` PowerShell cmdlet are valid for two years. To determine how close to expiration your certificates are, and to renew and install new certificates, use the following procedure.

1. Assess AD FS Azure AD Multi-Factor Authentication certificate expiration date

    On each AD FS server, in the local computer My store, there's a self signed certificate with "Microsoft AD FS Azure AD Multi-Factor Authentication" in the Issuer and Subject. This certificate is the Azure AD Multi-Factor Authentication certificate. Check the validity period of this certificate on each AD FS server to determine the expiration date.

1. Create a new AD FS Azure AD Multi-Factor Authentication Certificate on each AD FS server

    If the validity period of your certificates is nearing its end, start the renewal process by generating a new Azure AD Multi-Factor Authentication certificate on each AD FS server. In a PowerShell command window, generate a new certificate on each AD FS server using the following cmdlet:

    > [!CAUTION]
    > If your certificate has already expired, don't add the `-Renew $true` parameter to the following command. In this scenario, the existing expired certificate is replaced with a new one instead of being left in place and an additional certificate created.

    ```powershell
    $newcert = New-AdfsAzureMfaTenantCertificate -TenantId <tenant id such as contoso.onmicrosoft.com> -Renew $true
    ```

    If the certificate hasn't already expired, a new certificate that is valid from two days in the future to two days + 2 years is generated. AD FS and Azure AD Multi-Factor Authentication operations aren't affected when running cmdlet or renewing the certificate. The two-day delay is intentional and provides time to execute the following steps to configure the new certificate in the tenant before AD FS starts using it for Azure AD Multi-Factor Authentication.

1. Configure each new AD FS Azure AD Multi-Factor Authentication certificate in the Azure AD tenant

    Using the Azure AD PowerShell module, for each new certificate (on each AD FS server), update your Azure AD tenant settings as follows (Note: you must first connect to the tenant using `Connect-MsolService` to run the following commands).

    ```powershell
    New-MsolServicePrincipalCredential -AppPrincipalId 981f26a1-7f43-403b-a875-f8b09b8cd720 -Type Asymmetric -Usage Verify -Value $newcert
    ```

    If your previous certificate is expired, restart the AD FS service to pick up the new certificate. You don't need to restart the AD FS service if you renewed a certificate before it expired.

1. Verify that the new certificate(s) is used for Azure AD Multi-Factor Authentication

After the new certificate(s) become valid, AD FS will pick them up and start using each respective certificate for Azure AD Multi-Factor Authentication within a few hours to one day.  After AD FS begins using the new certificates, on each server you'll see an event logged in the AD FS Admin event log with the following information:

```Output
Log Name:      AD FS/Admin
Source:        AD FS
Date:          2/27/2018 7:33:31 PM
Event ID:      547
Task Category: None
Level:         Information
Keywords:      AD FS
User:          DOMAIN\adfssvc
Computer:      ADFS.domain.contoso.com
Description:
The tenant certificate for Azure MFA has been renewed.

TenantId: contoso.onmicrosoft.com.
Old thumbprint: 7CC103D60967318A11D8C51C289EF85214D9FC63.
Old expiration date: 9/15/2019 9:43:17 PM.
New thumbprint: 8110D7415744C9D4D5A4A6309499F7B48B5F3CCF.
New expiration date: 2/27/2020 2:16:07 AM.
```

## Customize the AD FS web page to guide users to register MFA verification methods

Use the following examples to customize your AD FS web pages for users who haven't yet proofed up (configured MFA verification information).

### Find the error

First, AD FS returns a couple of different error messages when the user lacks verification information.
If you're using Azure AD Multi-Factor Authentication as primary authentication, the unproofed user sees an AD FS error page containing the following messages:

```html
    <div id="errorArea">
        <div id="openingMessage" class="groupMargin bigText">
            An error occurred
        </div>
        <div id="errorMessage" class="groupMargin">
            Authentication attempt failed. Select a different sign in option or close the web browser and sign in again. Contact your administrator for more information.
        </div>
```

When Azure AD as extra authentication is being attempted, the unproofed user sees an AD FS error page containing the following messages:

```html
<div id='mfaGreetingDescription' class='groupMargin'>For security reasons, we require additional information to verify your account (mahesh@jenfield.net)</div>
    <div id="errorArea">
        <div id="openingMessage" class="groupMargin bigText">
            An error occurred
        </div>
        <div id="errorMessage" class="groupMargin">
            The selected authentication method is not available for &#39;username@contoso.com&#39;. Choose another authentication method or contact your system administrator for details.
        </div>
```

### Catch the error and update the page text

To catch the error and show the user custom guidance, append the JavaScript to the end of the `onload.js` file that's part of the AD FS web theme. Do so allows you to:

- Search for the identifying error string(s)
- Provide custom web content

> [!NOTE]
> For guidance in general on how to customize the onload.js file, see the article [Advanced Customization of AD FS Sign-in Pages](advanced-customization-of-ad-fs-sign-in-pages.md).

The following steps show a simple example.

1. Open Windows PowerShell on your primary AD FS server and create a new AD FS Web Theme by running the following command.

    ``` PowerShell
        New-AdfsWebTheme –Name ProofUp –SourceName default
    ```

1. Create the folder and export the default AD FS Web Theme:

    ``` PowerShell
       New-Item -Path 'c:\Theme' -ItemType Directory;Export-AdfsWebTheme –Name default –DirectoryPath c:\Theme
    ```

1. Open the C:\Theme\script\onload.js file in a text editor
1. Append the following code to the end of the onload.js file

    ``` JavaScript
    //Custom Code
    //Customize MFA exception
    //Begin

    var domain_hint = "<YOUR_DOMAIN_NAME_HERE>";
    var mfaSecondFactorErr = "The selected authentication method is not available for";
    var mfaProofupMessage = "You will be automatically redirected in 5 seconds to set up your account for additional security verification. Once you've completed the setup, please return to the application you are attempting to access.<br><br>If you are not redirected automatically, please click <a href='{0}'>here</a>."
    var authArea = document.getElementById("authArea");
    if (authArea) {
        var errorMessage = document.getElementById("errorMessage");
        if (errorMessage) {
            if (errorMessage.innerHTML.indexOf(mfaSecondFactorErr) >= 0) {

                //Hide the error message
                var openingMessage = document.getElementById("openingMessage");
                if (openingMessage) {
                    openingMessage.style.display = 'none'
                }
                var errorDetailsLink = document.getElementById("errorDetailsLink");
                if (errorDetailsLink) {
                    errorDetailsLink.style.display = 'none'
                }

                //Provide a message and redirect to Azure AD MFA Registration Url
                var mfaRegisterUrl = "https://account.activedirectory.windowsazure.com/proofup.aspx?proofup=1&whr=" + domain_hint;
                errorMessage.innerHTML = "<br>" + mfaProofupMessage.replace("{0}", mfaRegisterUrl);
                window.setTimeout(function () { window.location.href = mfaRegisterUrl; }, 5000);
            }
        }
    }

    //End Customize MFA Exception
    //End Custom Code
    ```

    > [!IMPORTANT]
    > You need to change "<YOUR_DOMAIN_NAME_HERE>"; to use your domain name. For example:
    > `var domain_hint = "contoso.com";`

1. Save the onload.js file
1. Import the onload.js file into your custom theme by typing the following Windows PowerShell command:

    ``` PowerShell
    Set-AdfsWebTheme -TargetName ProofUp -AdditionalFileResource @{Uri='/adfs/portal/script/onload.js';path="c:\theme\script\onload.js"}
    ```

1. Apply the custom AD FS Web Theme by typing the following Windows PowerShell command:

    ``` PowerShell
    Set-AdfsWebConfig -ActiveThemeName "ProofUp"
    ```

## Related links

[Manage TLS/SSL Protocols and Cipher Suites used by AD FS and Azure AD Multi-Factor Authentication](manage-ssl-protocols-in-ad-fs.md)
