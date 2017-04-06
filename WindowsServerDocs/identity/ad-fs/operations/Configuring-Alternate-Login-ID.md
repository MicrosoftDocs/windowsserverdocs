---
ms.assetid: f0cbdd78-f5ae-47ff-b5d3-96faf4940f4a
title: Configuring Alternate Login ID
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 02/24/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---
# Configuring Alternate Login ID

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Users can sign in to Active Directory Federation Services (AD FS) enabled applications using any form of user identifier that is accepted by Active Directory Domain Services (AD DS). These include User Principal Names (UPNs) (johndoe@contoso.com) or domain qualified sam-account names (contoso\johndoe or contoso.com\johndoe).

In some environments, due to corporate policy or on-premises line-of-business application dependencies, end users may only be aware of their email address and not their UPN or sam-account name. In some cases, the UPN is also non-routable (jdoe@contoso.local) and is only used for authenticating into applications on the corporate network.

Since non-routable domains' (ex. Contoso.local) ownership cannot be verified, Office 365 requires all user login IDs to be fully internet routable. If the on-premises UPN uses a non-routable domain (ex. Contoso.local), or the existing UPN cannot be changed due to local application dependencies, we recommend setting up alternate login ID. Alternate login ID allows you to configure a sign in experience where users can sign in with an attribute other than their UPN, such as mail.

One of the benefits of this feature is that it enables you to adopt SaaS providers, such as Office 365 without modifying your on-premises UPNs. It also enables you to support line-of-business service applications with consumer-provisioned identities.

> [!IMPORTANT]
> We have recently changed our support statement on using Alternate ID with Exchange Hybrid.   For the best user experience in an Exchange Hybrid environment, we recommend using the same set of credentials for on-premises and Exchange Online.  It is also recommended that customers that use Office 2013 clients enable [Modern Authentication](https://blogs.office.com/2015/03/23/office-2013-modern-authentication-public-preview-announced/).  Please refer to the table below for the expected user experience using various clients.

Please refer to the table below for the user experience with Alternate ID using various Office 365 clients with Regular Authentication, Modern Authentication and Certificate Based Authentication (requires enabling Modern Authentication).

|**Client Types**|**Additional Information**|**Support Statement - Regular and Modern Authentication**|**Description**|
|--------------------|------------------------------|------------------------------|------------------------------|
|Outlook|Regular Authentication: You must be on a domain joined machine and connected to the corporate network<br /><br />Modern Authentication: Supported|You can only use Alternate ID in environments that do not allow external access for mailbox users. This means that users can only authenticate to there mailbox in a supported way when they are connected and joined to the corporate network, on a VPN, or connected via Direct Access. If you opt to configure Modern Authentication (Known as ADAL) you can use Outlook from non-domain joined/connected machines, but you will get a couple of extra prompts when configuring your Outlook  profile.<br /><br />See the first image below the table for user experience demo.|[Modern Authentication in Office 2013](https://blogs.office.com/2015/03/23/office-2013-modern-authentication-public-preview-announced/)|
|Hybrid Public Folders|Regular Authentication:  Not supported<br /><br />Modern Authentication: Supported|Hybrid Public Folders will not be able to expand if Alternate ID's are used and therefore should  not be used today with regular authentication methods. If you want to be able to use Public Folder in Hybrid you will have to configure Modern Authentication (Known as ADAL).<br /><br />See the first image below the table for user experience demo.|[Modern Authentication in Office 2013](https://blogs.office.com/2015/03/23/office-2013-modern-authentication-public-preview-announced/)|
|Cross premises Delegation|Not supported|Currently cross premises permissions are not supported in a hybrid configuration, but they also will not work if you use AltID.||
|Archive mailbox access (Mailbox on-premises - archive in the cloud)|Supported|Users will get an extra prompt for credentials when accessing the archive, they will have to provide there alternate ID when prompted.<br /><br />See the first image below the table for user experience demo.||
|Office 365 Pro Plus activation page|Supported - client side registry key recommended|With Alternate ID configured you will see the on-premises UPN is pre-populated In the verification field. This needs to be changed to the alternate Identity that is being used. We recommend to use the client side reg key  noted in the link column<br />.<br /><br />See the second image below the table for user experience demo.|[Office 2013 and Lync 2013 periodically prompt for credentials to SharePoint Online, OneDrive, and Lync Online](https://support.microsoft.com/en-us/kb/2913639)|
|Lync / Skype for Business integration with Outlook (free busy, OOF, Calendar, etc)|Supported but there is a potential for user confusion (See Description)|If Skype for Business or Lync says "Exchange needs your credentials", you need to provide the credentials that are valid for were the mailbox is located. If the mailbox is in the cloud you need to provide the Alternate ID if the Mailbox is on-premises you need to provide the on-premises UPN.||
|ActiveSync for all mobile devices|Requires MDM solution or manual device configuration|For the autodiscover portion of ActiveSync to work you need to use an MDM solution, otherwise you will have to show your users how to manually configure ActiveSync profiles and be OK with the fact that if there is a reconfiguration needed it will be manual.|Use step 4 in the following:  [A mobile device can't connect to Exchange Online by using Exchange ActiveSync](https://support.microsoft.com/en-us/kb/2427193)|
|Outlook Web Access|Supported|||
|Outlook Mobile Apps for Android, IOS, and Windows Phone|Supported|||
|OneDrive for Business|Supported - client side registry key recommended|With Alternate ID configured you will see the on-premises UPN is pre-populated In the verification field. This needs to be changed to the alternate Identity that is being used. We recommend to use the client side reg key  noted in the link column.<br /><br />See the second image below the table for user experience demo.|[Office 2013 and Lync 2013 periodically prompt for credentials to SharePoint Online, OneDrive, and Lync Online](https://support.microsoft.com/en-us/kb/2913639)|
|OneDrive for Business Mobile Client|Supported|||

![alternate login](media/Configure-Alternate-Login-ID/ADFS_Alt_ID1.png)

![alternate login](media/Configure-Alternate-Login-ID/ADFS_Alt_ID2.png)

![alternate login](media/Configure-Alternate-Login-ID/ADFS_Alt_ID3.png)

## To configure alternate login ID
In order to configure alternate login ID, you must perform the following tasks:

Configure your AD FS claims provider trusts to enable alternate login ID

1.  Install [KB2919355](http://go.microsoft.com/fwlink/?LinkID=396590).  You can get it via Windows Update Services or download it directly.

2.  Update the AD FS configuration by running the following PowerShell cmdlet on any of the federation servers in your farm (if you have a WID farm, you must run this command on the primary AD FS server in your farm):

    ```
    Set-AdfsClaimsProviderTrust -TargetIdentifier "AD AUTHORITY" -AlternateLoginID <attribute> -LookupForests <forest domain>

    ```

    **AlternateLoginID** is the LDAP name of the attribute that you want to use for login.

    **LookupForests** is the list of forest DNS that your users belong to.

    To enable alternate login ID feature, you must configure both -AlternateLoginID and -LookupForests parameters with a non-null, valid value.

    In the following example, you are enabling alternate login ID functionality such that your users with accounts in contoso.com and fabrikam.com forests can log in to AD FS-enabled applications with their "mail" attribute.

    ```
    Set-AdfsClaimsProviderTrust -TargetIdentifier "AD AUTHORITY" -AlternateLoginID mail -LookupForests contoso.com,fabrikam.com
    ```

3.  To disable this feature, set the value for both parameters to be null.

    ```
    Set-AdfsClaimsProviderTrust -TargetIdentifier "AD AUTHORITY" -AlternateLoginID $NULL -LookupForests $NULL
    ```

4.  To enable alternate login ID with Azure AD, no additional configurations steps are needed when using Azure AD Connect.   Alternate ID can be configured directly from the wizard.  See uniquely identifying your users under the section [Connect to Azure AD](https://azure.microsoft.com/en-us/documentation/articles/active-directory-aadconnect-get-started-custom/#connect-to-azure-ad).

## Additional Details & Considerations

-   When enabled, the alternate login ID feature is only available for username/password authentication across all the user name/password authentication protocols supported by AD FS (SAML-P, WS-Fed, WS-Trust, and OAuth).

-   When Windows Integrated Authentication (WIA) is performed (for example, when users try to access a corporate application on a domain-joined machine from intranet and AD FS administrator has configured the authentication policy to use WIA for intranet), UPN will be used for authentication. If you have configured any claim rules for the relying parties for alternate login ID feature, you should make sure those rules are still valid in the WIA case.

-   When enabled, the alternate login ID feature requires at least one global catalog server to be reachable from the AD FS server for each user account forest that AD FS supports. Failure to reach a global catalog server in the user account forest will result in AD FS falling back to use UPN. By default all the domain controllers are global catalog servers.

-   When enabled, if the AD FS server finds more than one user object with the same alternate login ID value specified across all the configured user account forests, it will fail the login.

-   When alternate login ID feature is enabled, AD FS will try to authenticate the end user with alternate login ID first and then fall back to use UPN if it cannot find an account that can be identified by the alternate login ID. You should make sure there are no clashes between the alternate login ID and the UPN if you want to still support the UPN login. For example, setting one's mail attribute with the other's UPN will block the other user from signing in with his UPN.

-   If one of the forests that is configured by the administrator is down, AD FS will continue to look up user account with alternate login ID in other forests that are configured. If AD FS server finds a unique user objects across the forests that it has searched, a user will log in successfully.

-   You may additionally want to customize the AD FS sign-in page to give end users some hint about the alternate login ID. You can do it by either adding the customized sign-in page description (for more information, see [Customizing the AD FS Sign-in Pages](https://technet.microsoft.com/library/dn280950.aspx) or customizing "Sign in with organizational account" string above username field (for more information, see [Advanced Customization of AD FS Sign-in Pages](https://technet.microsoft.com/library/dn636121.aspx).

-   The new claim type that contains the alternate login ID value is **http:schemas.microsoft.com/ws/2013/11/alternateloginid**

## Events and Performance Counters
The following performance counters have been added to measure the performance of AD FS servers when alternate login ID is enabled:

-   Alternate Login Id Authentications: number of authentications performed by using alternate login ID

-   Alternate Login Id Authentications/Sec: number of authentications performed by using alternate login ID per second

-   Average Search Latency for Alternate Login ID: average search latency across the forests that an administrator has configured for alternate login ID

The following are various error cases and corresponding impact on a user's sign-in experience with events logged by AD FS:



**Error Cases**|**Impact on Sign-in Experience**|**Event**|
---------|---------|---------
Unable to get a value for SAMAccountName for the user object|Login failure|Event ID 364 with exception message MSIS8012: Unable to find samAccountName for the user: '{0}'.|
The CanonicalName attribute is not accessible|Login failure|Event ID 364 with exception message MSIS8013: CanonicalName: '{0}' of the user:'{1}' is in bad format.|
Multiple user objects are found in one forests|Login failure|Event ID 364 with exception message MSIS8015: Found multiple user accounts with identity '{0}' in forest '{1}' with identities: {2}|
Multiple user objects are found across multiple forests|Login failure|Event ID 364 with exception message MSIS8014: Found multiple user accounts with identity '{0}' in forests: {1}|

## See Also
[AD FS Operations](../../ad-fs/AD-FS-2016-Operations.md)


