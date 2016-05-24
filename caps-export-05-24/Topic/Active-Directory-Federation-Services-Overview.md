---
title: Active Directory Federation Services Overview
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 51456fd7-90a0-40b6-a165-6ffa0a2f2d68
author: billmath
---
# Active Directory Federation Services Overview
This topic provides an overview of Active Directory Federation Services \(AD FS\).  
  
You can use the following sections to jump to the information that interests you most:  
  
-   [Role description](../Topic/Active-Directory-Federation-Services-Overview.md#BKMK_OVER)  
  
-   [Practical applications](../Topic/Active-Directory-Federation-Services-Overview.md#BKMK_APP)  
  
-   [AD FS in Windows Server Technical Preview](../Topic/Active-Directory-Federation-Services-Overview.md#BKMK_preview)  
  
-   [AD FS in Windows Server 2012 R2](../Topic/Active-Directory-Federation-Services-Overview.md#BKMK_R2)  
  
-   [AD FS in Windows Server 2012](../Topic/Active-Directory-Federation-Services-Overview.md#BKMK_NEW)  
  
## <a name="BKMK_OVER"></a>Role description  
AD FS provides simplified, secured identity federation and Web single sign\-on \(SSO\) capabilities for end users who want to access applications within an AD FS\-secured enterprise, in federation partner organizations, or in the cloud.  
  
In [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)], AD FS includes a federation service role service that acts as an identity provider \(authenticates users to provide security tokens to applications that trust AD FS\) or as a federation provider \(consumes tokens from other identity providers and then provides security tokens to applications that trust AD FS\).  
  
The function of providing extranet access to applications and services that are secured by AD FS is now performed by a new Remote Access role service called Web Application Proxy. This is a departure from the prior versions of Windows Server in which this function was handled by an AD FS federation server proxy. Web Application Proxy is a server role designed to provide access for the AD FS\-related extranet scenario and other extranet scenarios. For more information on Web Application Proxy, see [Web Application Proxy Walkthrough Guide](../Topic/Web-Application-Proxy-Walkthrough-Guide.md).  
  
## <a name="BKMK_APP"></a>Practical applications  
AD FS simplifies access to systems and applications by using a claims\-based authentication and access authorization mechanism to maintain application security. Prior versions of AD FS were used for the following:  
  
-   Providing your employees or customers with a web\-based, SSO experience when accessing claims\-based applications within your enterprise.  
  
-   Providing your employees or customers with a web\-based, SSO experience to access resources in any federation partner organization.  
  
-   Providing your employees or customers with a Web\-based, SSO experience when remote accessing internally hosted Web sites or services.  
  
-   Providing your employees or customers with a web\-based, SSO experience when accessing resources or services in the cloud.  
  
AD FS in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] adds additional practical applications for AD FS, including the following:  
  
-   Device workplace join for SSO and seamless second factor authentication. This enables organizations to allow access from devices that are personally owned by users and manage the risk when providing this access. For more information, see [Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](../Topic/Join-to-Workplace-from-Any-Device-for-SSO-and-Seamless-Second-Factor-Authentication-Across-Company-Applications.md).  
  
-   Managing risk with multi\-factor access control. AD FS provides a rich level of authorization that controls who has access to what applications. This can be based on user attributes \(UPN, email, security group membership, authentication strength, etc.\), device attributes \(whether the device is workplace joined\) or request attributes \(network location, IP address, or user agent\). For more information, see [Manage Risk with Conditional Access Control](../Topic/Manage-Risk-with-Conditional-Access-Control.md).  
  
-   Managing risk with additional multi\-factor authentication for sensitive applications. AD FS allows you to control policies to potentially require multi\-factor authentication on a per application basis. In addition, AD FS provides extensibility points for any multi\-factor vendor to integrate deeply for a secure and seamless multi\-factor experience for end users. For more information, see [Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](../Topic/Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md).  
  
-   Providing authentication and authorization capabilities for accessing web application resources from the extranet that are protected by the Web Application Proxy. For more information, see [Planning to Publish Applications Using Web Application Proxy](../Topic/Planning-to-Publish-Applications-Using-Web-Application-Proxy.md), [Connect to Applications and Services from Anywhere with Web Application Proxy](../Topic/Connect-to-Applications-and-Services-from-Anywhere-with-Web-Application-Proxy.md), and [Web Application Proxy Walkthrough Guide](../Topic/Web-Application-Proxy-Walkthrough-Guide.md).  
  
## <a name="BKMK_preview"></a>AD FS in Windows Server Technical Preview  
For the Windows Server Technical Preview, the AD FS server role includes the same functionality and feature set that is available in Windows Server 2012 and Windows Server 2012 R2. It also includes new features that enable you to configure AD FS to authenticate users stored in non\-AD directories, such as X.500 compliant Lightweight Directory Access Protocol \(LDAP\) directories and SQL databases. In many organizations, identity management solutions consist of a combination of Active Directory, AD LDS and third\-party LDAP directories, as well as SQL databases. With the AD FS support of the non\-AD identity stores, you can benefit from the entire enterprise\-ready AD FS feature set regardless of where your user identities are stored. For more information, see [Configure AD FS to authenticate users stored in LDAP directories](../Topic/Configure-AD-FS-to-authenticate-users-stored-in-LDAP-directories.md).  
  
## <a name="BKMK_R2"></a>AD FS in Windows Server 2012 R2  
The following sections summarize numerous changes that were made to AD FS in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] in order to support newer practical applications of AD FS as well as to enhance existing functionality.  
  
You can use the following sections to jump to the information that interests you most:  
  
-   [Enable users to access resources on their personal devices from anywhere](../Topic/Active-Directory-Federation-Services-Overview.md#BKMK_1)  
  
-   [Enhanced access control risk management tools](../Topic/Active-Directory-Federation-Services-Overview.md#BKMK_2)  
  
-   [Simplified deployment experience](../Topic/Active-Directory-Federation-Services-Overview.md#BKMK_3)  
  
-   [Enhanced sign\-in with AD FS experience](../Topic/Active-Directory-Federation-Services-Overview.md#BKMK_4)  
  
-   [Enable developers to build modern applications](../Topic/Active-Directory-Federation-Services-Overview.md#BKMK_5)  
  
-   [Other improvements](../Topic/Active-Directory-Federation-Services-Overview.md#BKMK_6)  
  
### <a name="BKMK_1"></a>Enable users to access resources on their personal devices from anywhere  
  
-   Workplace join that enables users to join their personal devices to corporate Active Directory and as a result gain access and seamless experiences when accessing corporate resources from these devices.  
  
-   Pre\-authentication of resources inside the corporate network that are protected by the Web Application proxy and accessed from the internet.  
  
-   Password change to enable users to change their password from any workplace joined device when their password has expired so that they can continue to access resources.  
  
For more information, see [Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](../Topic/Join-to-Workplace-from-Any-Device-for-SSO-and-Seamless-Second-Factor-Authentication-Across-Company-Applications.md).  
  
### <a name="BKMK_2"></a>Enhanced access control risk management tools  
Managing risk is an important aspect of governance and compliance in every IT organization. There are numerous access control risk management enhancements in AD FS in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)], including the following:  
  
-   Flexible controls based on network location to govern how a user authenticates to access an AD FS\-secured application. For more information, see [Manage Risk with Conditional Access Control](../Topic/Manage-Risk-with-Conditional-Access-Control.md).  
  
-   Flexible policy to determine if a user needs to perform multi\-factor authentication based on the user’s data, device data, and network location. For more information, see [Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](../Topic/Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md).  
  
-   Support for third\-party and custom built authentication methods when configuring multi\-factor authentication. For more information, see [Configure Additional Authentication Methods for AD FS](../Topic/Configure-Additional-Authentication-Methods-for-AD-FS.md).  
  
-   Per\-application control to ignore SSO and force the user to provide credentials every time they access a sensitive application. For more information, see  
  
-   Flexible per\-application access policy based on user data, device data, or network location.  
  
-   AD FS Extranet Lockout, which enables administrators to protect Active Directory accounts from brute force attacks from the internet. For more information, see [Configuring AD FS Extranet Lockout](../Topic/Configuring-AD-FS-Extranet-Lockout.md)  
  
-   Access revocation for any workplace joined device that is disabled or deleted in Active Directory.  
  
### <a name="BKMK_3"></a>Simplified deployment experience  
Deploying AD FS in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] is simplified by the following enhancements:  
  
-   AD FS is no longer dependent on IIS. This offers enhanced performance and reduces the foot print of services, especially when AD FS is installed on Active Directory domain controllers.  
  
-   Remote installation and configuration through Server Manager.  
  
-   UI support for installing AD FS with SQL Server  
  
-   Group Managed Service Account support. This enables AD FS to be run with service accounts without managing expiring service account passwords.  
  
-   SQL Server merge replication support when deploying AD FS across globally dispersed datacenters.  
  
> [!IMPORTANT]  
> Note that in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)], the ‘stand\-alone’ mode for AD FS setup has been removed.  
  
For more information, see [Windows Server 2012 R2 AD FS Deployment Guide](../Topic/Windows-Server-2012-R2-AD-FS-Deployment-Guide.md).  
  
### <a name="BKMK_4"></a>Enhanced sign\-in with AD FS experience  
The following are new AD FS capabilities in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] that enable administrator to customize and enhance the sign\-in experience:  
  
-   Unified customization of the AD FS service, where the changes are made once and then automatically propagated to the rest of the AD FS federation servers in a given farm.  
  
-   Updated sign\-in pages that look modern and cater to different form factors automatically.  
  
-   Support for automatic fallback to forms\-based authentication for devices that are not joined to the corporate domain but are still used generate access requests from within the corporate network \(intranet\).  
  
-   Simple controls to customize the company logo, illustration image, standard links for IT support, home page, privacy, etc.  
  
-   Customization of description messages in the sign\-in pages.  
  
-   Customization of web themes.  
  
-   Home Realm Discovery \(HRD\) based on organizational suffix of the user for enhanced privacy of a company’s partners.  
  
-   HRD filtering on a per\-application basis to automatically pick a realm based on the application.  
  
-   One\-click error reporting for easier IT troubleshooting.  
  
-   Customizable error messages.  
  
-   User authentication choice when more than one authentication provider is available.  
  
For more information, see [Customizing the AD FS Sign-in Pages](../Topic/Customizing-the-AD-FS-Sign-in-Pages.md) and [Advanced Customization of AD FS Sign-in Pages](../Topic/Advanced-Customization-of-AD-FS-Sign-in-Pages.md).  
  
### <a name="BKMK_5"></a>Enable developers to build modern applications  
ADFS in Windows Server 2012 now supports the OAuth Authorization Grant profile with support for refresh tokens to enable modern applications that use RESTful services. ADFS also supports issuing JWT tokens that are compact tokens that are more amenable to transmit to the resources that use the REST pattern. For more information, see [Developing Modern Applications using OAuth and Active Directory Federation Services](assetId:///9eb35f78-5d24-4196-bbe9-7e9abda358b4).  
  
### <a name="BKMK_6"></a>Other improvements  
  
-   Reduction of SSO cookie size with dynamic group SID hydration. This provides a more deterministic cookie size and reduces bloat when a user belongs to many security groups.  
  
-   Access to claims that are encoded within user certificates when using certificate authentication. This can help administrators differentiate access based on what type of certificate is used.  
  
-   Consistent client\-request\-id that is logged in all event logs and traces for easier troubleshooting.  
  
-   Additional request claims, for example, IP addresses, endpoint addresses, or user agents that can be used to base policy decisions on.  
  
-   Password expiry notification as claims that an administrator can configure to send to downstream applications to notify the user when their password is about to expire.  
  
## <a name="BKMK_NEW"></a>AD FS in Windows Server 2012  
For [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the AD FS server role includes the same functionality and feature set that is available in AD FS 2.0. It also includes the following list of new functionality that was not available in AD FS 2.0:  
  
-   **Improved installation experience using Server Manager –** With AD FS 2.0, you had to download and install the AD FS 2.0 software to deploy your AD FS server infrastructure. However, in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you install the AD FS server role using Server Manager. Server Manager provides improved AD FS configuration wizard pages that perform server validation checks before you continue with the AD FS server role installation and will automatically list and install all the services that AD FS depends on during the AD FS server role installation.  
  
-   **Additional Windows PowerShell cmdlet tools \-** In addition to the Windows PowerShell based management capabilities provided in AD FS 2.0, AD FS in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)], includes new cmdlets for installing the AD FS server role and for initial configuration of the federation server and federation server proxy.  
  
## See Also  
[Active Directory](assetId:///05f58d7c-81a3-44b0-80dc-ecd9a5fe48cb)  
  
