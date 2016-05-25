---
title: Configuring Alternate Login ID
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4e298a12-7aff-4135-85c1-48cc86f373f3
author: billmath
---
# Configuring Alternate Login ID
Users can sign in to Active Directory Federation Services (AD FS) enabled applications using any form of user identifier that is accepted by Active Directory Domain Services (AD DS). These include User Principal Names (UPNs) (johndoe@contoso.com) or domain qualified sam-account names (contoso\johndoe or contoso.com\johndoe).  
  
In some environments, due to corporate policy or on-premises line-of-business application dependencies, end users may only be aware of their email address and not their UPN or sam-account name. In some cases, the UPN is also non-routable (jdoe@contoso.local) and is only used for authenticating into applications on the corporate network.  
  
Since non-routable domains’ (ex. Contoso.local) ownership cannot be verified, Office 365 requires all user login IDs to be fully internet routable. If the on-premises UPN uses a non-routable domain (ex. Contoso.local), or the existing UPN cannot be changed due to local application dependencies, we recommend setting up alternate login ID. Alternate login ID allows you to configure a sign in experience where users can sign in with an attribute other than their UPN, such as mail.  
  
One of the benefits of this feature is that it enables you to adopt SaaS providers, such as Office 365 without modifying your on\-premise UPNs. It also enables you to support line\-of\-business service applications with consumer\-provisioned identities.  
  
> [!IMPORTANT]  
> We have recently changed our support statement on using Alternate ID with Exchange Hybrid.   For the best user experience in an Exchange Hybrid environment, we recommend using the same set of credentials for on\-premises and Exchange Online.  It is also recommended that customers that use Office 2013 clients enable [Modern Authentication](https://blogs.office.com/2015/03/23/office-2013-modern-authentication-public-preview-announced/).  Please refer to the table below for the expected user experience using various clients.  
  
Please refer to the table below for the user experience with Alternate ID using various Office 365 clients with Regular Authentication, Modern Authentication and Certificate Based Authentication (requires enabling Modern Authentication).  
  
|**Client Types**|**Regular Authentication Options**|**Modern Authentication Options**|**Smart Card Authentication Options**|  
|--------------------|------------------------------|------------------------------|------------------------------|  
|**Outlook**|Regular Authentication can only be used in Alternate Login ID environments that do not allow external access for mailbox users. This means that users can only authenticate to their mailbox when they are connected to the corporate network, on a VPN, or via Direct Access.|With Modern Authentication (known as Active Directory Authentication Libraries or ADAL), users can also connect to their mailbox from non-domain joined/connected machines. There will be a couple of extra authentication prompts during Outlook profile creation. Please see the first image below.  </br></br>[Modern Authentication in Office 2013](https://blogs.office.com/2015/03/23/office-2013-modern-authentication-public-preview-announced/)|Smart Card based authentication requires configuring Modern Authentication (known as ADAL). Users can connect to their mailboxes when they are connected to the corporate network, on a VPN, or via Direct Access.</br></br>[Modern Authentication in Office 2013](https://blogs.office.com/2015/03/23/office-2013-modern-authentication-public-preview-announced/) or [Deploy Smart Card Authentication](https://technet.microsoft.com/library/dn579272.aspx)|  
|**Hybrid Public Folders**|NA|When using Public Folders in a hybrid environment, you must configure Modern Authentication (known as ADAL).</br></br>[Modern Authentication in Office 2013](https://blogs.office.com/2015/03/23/office-2013-modern-authentication-public-preview-announced/)|Using Public Folders in a Hybrid environment with Smart Card based authentication requires configuring Modern Authentication (known as ADAL).</br></br>[Modern Authentication in Office 2013](https://blogs.office.com/2015/03/23/office-2013-modern-authentication-public-preview-announced/) or [Deploy Smart Card Authentication](https://technet.microsoft.com/library/dn579272.aspx)|  
|**Cross Premises Delegation**|Not Supported|This functionality is not supported with Alternate ID.| NA|  
|**Archive Mailbox Access (mailbox on-premises archive in Exchange Online)** |Regular Authentication can only be used in Alternate Login ID environments that do not allow external access for mailbox users. This means that users can only authenticate to their mailbox when they are connected to the corporate network, on a VPN, or via Direct Access. |With Modern Authentication (known as ADAL), users can also connect to their mailbox from non-domain joined/connected machines. There will be a couple of extra authentication prompts during Outlook profile creation. See the first image below.</br></br>[Modern Authentication in Office 2013](https://blogs.office.com/2015/03/23/office-2013-modern-authentication-public-preview-announced/)|Smart Card based authentication requires configuring Modern Authentication (known as ADAL). Users can connect to their mailboxes when they are connected to the corporate network, on a VPN, or via Direct Access.</br></br>[Modern Authentication in Office 2013](https://blogs.office.com/2015/03/23/office-2013-modern-authentication-public-preview-announced/) or [Deploy Smart Card Authentication](https://technet.microsoft.com/library/dn579272.aspx)|  
|**Office 365 Pro Plus activation and OneDrive for Business**|With Alternate ID configured, users will see the on-premises UPN pre-populated in the verification field. This needs to be changed to the alternate ID of the user. We recommend using the Client Side Registry Key noted in the additional information column.   See the second image below.</br></br>[Office 2013 and Lync 2013 periodically prompt for credentials to SharePoint Online, OneDrive, and Lync Online](https://support.microsoft.com/kb/2913639)|Users can easily activate Office ProPlus as long as Modern Authentication (known as ADAL) is enabled, or running Office 2016.</br></br>[Modern Authentication in Office 2013](https://blogs.office.com/2015/03/23/office-2013-modern-authentication-public-preview-announced/)|Users can easily activate Office ProPlus as long as Modern Authentication (known as ADAL) is enabled, or running Office 2016.</br></br>[Modern Authentication in Office 2013](https://blogs.office.com/2015/03/23/office-2013-modern-authentication-public-preview-announced/) or [Deploy Smart Card Authentication](https://technet.microsoft.com/library/dn579272.aspx)|  
|**Skype for Business integration with Outlook (free busy, OOF, Calendar, etc.)** |If Skype for Business or Lync says “Exchange needs your credentials”, you need to provide the credentials that are valid for were the mailbox is located. If the mailbox is in the cloud you need to provide the Alternate ID if the Mailbox is on-premises you need to provide the on-premises UPN. |If Skype for Business client or Lync client says “Exchange needs your credentials”, you need to provide the credentials that are valid for where the mailbox is located. If the mailbox is in the cloud you need to provide the Alternate login ID, if the Mailbox is on-premises you need to provide the on-premises UPN. See the third image below.</br></br>[Modern Authentication in Office 2013](https://blogs.office.com/2015/03/23/office-2013-modern-authentication-public-preview-announced/)|If Skype for Business or Lync says “Exchange needs your credentials”, you need to provide the credentials that are valid for were the mailbox is located. If the mailbox is in the cloud you need to provide the Alternate ID if the Mailbox is on-premises you need to provide the on-premises UPN.</br></br>[Modern Authentication in Office 2013](https://blogs.office.com/2015/03/23/office-2013-modern-authentication-public-preview-announced/) or [Deploy Smart Card Authentication](https://technet.microsoft.com/library/dn579272.aspx)|  
|**Exchange ActiveSync** |Use a Mobile Device Management (MDM) solution to configure the autodiscover portion of ActiveSync. If there isn’t an MDM, inform users the steps required to manually configure their ActiveSync profiles.</br></br>See step 4 in the following: [A mobile device can't connect to Exchange Online by using Exchange ActiveSync](https://support.microsoft.com/kb/2427193)|Use a Mobile Device Management (MDM) solution to configure the autodiscover portion of ActiveSync. If there isn’t an MDM, inform users the steps required to manually configure their ActiveSync profiles.</br></br>[Modern Authentication in Office 2013](https://blogs.office.com/2015/03/23/office-2013-modern-authentication-public-preview-announced/)|NA|  
|**Outlook Web Access, SharePoint Online, Yammer and other Office 365 web apps**|Users can access Outlook and other Office web apps from the browser. |Users can access Outlook and other Office web apps from the browser with their alternate ID and password. Admins can also choose to enable MFA with Modern Atuh enabled.</br></br>[Modern Authentication in Office 2013](https://blogs.office.com/2015/03/23/office-2013-modern-authentication-public-preview-announced/)|Users can access Outlook and other Office web apps from the browser by connecting with a physical or virtual smart card.</br></br>[Modern Authentication in Office 2013](https://blogs.office.com/2015/03/23/office-2013-modern-authentication-public-preview-announced/) or [Deploy Smart Card Authentication](https://technet.microsoft.com/library/dn579272.aspx)|  
|**Office Mobile Apps for iOS, Android and Windows Phone**|Regular authentication does not apply to Office Mobile apps. </br><br>Office mobile apps are modern authentication enabled. |Office mobile applications are Modern Authentication enabled. Users can sign in with their alternate ID and complete MFA requirements if enabled.  |NA|  
|**Exchange Online Remote PowerShell**|Administrators can authenticate successfully with their Alternate ID into Exchange Online Remote PowerShell.</br></br>[Connecting to EXO with PowerShell](https://technet.microsoft.com/library/jj984289(v=exchg.160).aspx)|Administrators cannot use Modern Authentication (known as ADAL) with Exchange Online Remote PowerShell. The recommended workaround is to create cloud only administrator accounts to access PowerShell features.</br></br>[Connecting to EXO with PowerShell](https://technet.microsoft.com/library/jj984289(v=exchg.160).aspx)|NA|  
|**Azure Active Directory PowerShell and SharePoint Online PowerShell**|Administrators can authenticate successfully with their Alternate ID into AAD and SharePoint PowerShell.</br></br>[Connecting to Azure Active Directory PowerShell](https://connect.microsoft.com/site1164/content/content.aspx?ContentID=32016) and [Connecting to SharePoint Online PowerShell](https://www.microsoft.com/download/details.aspx?id=35588)|Administrators can authenticate successfully with their Alternate ID into AAD and SharePoint PowerShell with Modern Authentication (known as ADAL) enabled.</br></br>[Connecting to Azure Active Directory PowerShell](https://connect.microsoft.com/site1164/content/content.aspx?ContentID=32016) and [Connecting to SharePoint Online PowerShell](https://www.microsoft.com/download/details.aspx?id=35588)|Administrators can authenticate successfully using their Smart Card into AAD and SharePoint PowerShell with Modern Authentication (known as ADAL) enabled.</br></br>[Connecting to Azure Active Directory PowerShell](https://connect.microsoft.com/site1164/content/content.aspx?ContentID=32016) and [Connecting to SharePoint Online PowerShell](https://www.microsoft.com/download/details.aspx?id=35588)  
  
  
   
  
  
   
  
  
  
  
  
  
![ADFS_Alt_ID1](/Image/ADFS_Alt_ID1.png)  
  
![ADFS_Alt_ID1](/Image/ADFS_Alt_ID2.png)  
  
![ADFS_Alt_ID1](/Image/ADFS_Alt_ID3.png)  
  
## To configure alternate login ID  
In order to configure alternate login ID, you must perform the following tasks:  
  
Configure your AD FS claims provider trusts to enable alternate login ID  
  
1.  Install KB2919355 \(you can get it via Windows Update Services or locate it on [https:\/\/support.microsoft.com](https://support.microsoft.com).\) For more information, see [http:\/\/go.microsoft.com\/fwlink\/?LinkID\=396590](http://go.microsoft.com/fwlink/?LinkID=396590).  
  
2.  Update the AD FS configuration by running the following PowerShell cmdlet on any of the federation servers in your farm \(if you have a WID farm, you must run this command on the primary AD FS server in your farm\):  
  
    ```  
    Set-AdfsClaimsProviderTrust -TargetIdentifier "AD AUTHORITY" -AlternateLoginID <attribute> -LookupForests <forest domain>  
  
    ```  
  
    **AlternateLoginID** is the LDAP name of the attribute that you want to use for login.  
  
    **LookupForests** is the list of forest DNS that your users belong to.  
  
    To enable alternate login ID feature, you must configure both ‘AlternateLoginID’ and ‘LookupForests’ parameters with a non\-null, valid value.  
  
    In the following example, you are enabling alternate login ID functionality such that your users with accounts in contoso.com and fabrikam.com forests can log in to AD FS\-enabled applications with their "mail" attribute.  
  
    ```  
    Set-AdfsClaimsProviderTrust -TargetIdentifier "AD AUTHORITY" -AlternateLoginID mail -LookupForests contoso.com,fabrikam.com  
    ```  
  
3.  To disable this feature, set the value for both parameters to be null.  
  
    ```  
    Set-AdfsClaimsProviderTrust -Target Identifier "AD AUTHORITY" -AlternateLoginID $NULL -LookupForests $NULL  
    ```  
  
4.  To enable alternate login ID with Azure AD, no additional configurations steps are needed when using Azure AD Connect.   Alternate ID can be configured directly from the wizard.  See uniquely identifying your users under the section [Connect to Azure AD](https://azure.microsoft.com/en-us/documentation/articles/active-directory-aadconnect-get-started-custom/#connect-to-azure-ad).  
  
## Additional Details & Considerations  
  
-   When enabled, the alternate login ID feature is only available for username\/password authentication across all the user name\/password authentication protocols supported by AD FS \(SAML\-P, WS\-Fed, WS\-Trust, and OAuth\).  
  
-   When Windows Integrated Authentication \(WIA\) is performed \(for example, when users try to access a corporate application on a domain\-joined machine from intranet and AD FS administrator has configured the authentication policy to use WIA for intranet\), UPN will be used for authentication. If you have configured any claim rules for the relying parties for alternate login ID feature, you should make sure those rules are still valid in the WIA case.  
  
-   When enabled, the alternate login ID feature requires at least one global catalog server to be reachable from the AD FS server for each user account forest that AD FS supports. Failure to reach a global catalog server in the user account forest will result in AD FS falling back to use UPN. By default all the domain controllers are global catalog servers.  
  
-   When enabled, if the AD FS server finds more than one user object with the same alternate login ID value specified across all the configured user account forests, it will fail the login.  
  
-   When alternate login ID feature is enabled, AD FS will try to authenticate the end user with alternate login ID first and then fall back to use UPN if it cannot find an account that can be identified by the alternate login ID. You should make sure there are no clashes between the alternate login ID and the UPN if you want to still support the UPN login. For example, setting one’s mail attribute with the other’s UPN will block the other user from signing in with his UPN.  
  
-   If one of the forests that is configured by the administrator is down, AD FS will continue to look up user account with alternate login ID in other forests that are configured. If AD FS server finds a unique user objects across the forests that it has searched, a user will log in successfully.  
  
-   You may additionally want to customize the AD FS sign\-in page to give end users some hint about the alternate login ID. You can do it by either adding the customized sign\-in page description \(for more information, see [Customizing the AD FS Sign-in Pages](../Topic/Customizing-the-AD-FS-Sign-in-Pages.md)\) or customizing “Sign in with organizational account” string above username field \(for more information, see [Advanced Customization of AD FS Sign-in Pages](../Topic/Advanced-Customization-of-AD-FS-Sign-in-Pages.md)\).  
  
-   The new claim type that contains the alternate login ID value is **http:\/\/schemas.microsoft.com\/ws\/2013\/11\/alternateloginid**  
  
## Events and Performance Counters  
The following performance counters have been added to measure the performance of AD FS servers when alternate login ID is enabled:  
  
-   Alternate Login Id Authentications: number of authentications performed by using alternate login ID  
  
-   Alternate Login Id Authentications\/Sec: number of authentications performed by using alternate login ID per second  
  
-   Average Search Latency for Alternate Login ID: average search latency across the forests that an administrator has configured for alternate login ID  
  
The following are various error cases and corresponding impact on a user’s sign\-in experience with events logged by AD FS:  
  
||||  
|-|-|-|  
|**Error Cases**|**Impact on Sign\-in Experience**|**Event**|  
|Unable to get a value for SAMAccountName for the user object|Login failure|Event ID 364 with exception message MSIS8012: Unable to find samAccountName for the user: '{0}'.|  
|The CanonicalName attribute is not accessible|Login failure|Event ID 364 with exception message MSIS8013: CanonicalName: '{0}' of the user:'{1}' is in bad format.|  
|Multiple user objects are found in one forests|Login failure|Event ID 364 with exception message MSIS8015: Found multiple user accounts with identity '{0}' in forest '{1}' with identities: {2}|  
|Multiple user objects are found across multiple forests|Login failure|Event ID 364 with exception message MSIS8014: Found multiple user accounts with identity '{0}' in forests: {1}|  
  
## See Also  
[AD FS Operations](../Topic/AD-FS-Operations.md)  
  
