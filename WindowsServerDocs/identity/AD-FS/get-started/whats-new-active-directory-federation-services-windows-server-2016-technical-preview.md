---
title: What&#39;s new in Active Directory Federation Services for Windows Server 2016 Technical Preview
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d133f97f-4b37-475f-b965-56d97d6c0e16
author: billmath
---
# What&#39;s new in Active Directory Federation Services for Windows Server 2016 Technical Preview
  
## What's new in Active Directory Federation Services for Windows Server 2016 Preview  
If you are looking for information on earlier versions of AD FS, see the following articles:  
 [ADFS in Windows Server 2012 or 2012 R2](https://technet.microsoft.com/library/hh831502.aspx) and [AD FS 2.0](https://technet.microsoft.com/library/adfs2(v=ws.10).aspx)  
   
 Active Directory Federation Services provides access control and single sign on across a wide variety of applications including Office 365, cloud based SaaS applications, and applications on the corporate network.  
* For the IT organization, we enable you to provide authentication and access control to both modern and legacy applications, on premises and in the cloud, based on the same set of credentials and policies, ensuring that you are only allowing access to users, devices and network locations that meet your corporate policies.  
* For the user, we provide a seamless sign on using the same, familiar account credentials.  
* For the developer, we provide an easy way to authenticate users whose identities live in the organizational directory so that you can focus your efforts on your application, not authentication or identity.  
This article describes the new scenarios enabled by AD FS in Windows Server 2016 for improved security, manageability and interoperability across cloud and on premises applications.  
  
## Protect your network and eliminate passwords with multiple factors of authentication  
  
The following section describes the improved security scenarios that are introduced with Active Directory Federation Services in Windows Server 2016. Security is a critical part of any organization and continuing to deliver improved security scenarios is one of the main areas of focus for AD FS.  
  
### Greater interoperability with Multi-factor Authentication (Private Preview)  
AD FS in Windows Server 2016 introduces and builds upon the multi-factor authentication capabilities that were introduced with Windows Server 2012 R2. By introducing a built-in Azure MFA adapter, setup and configuration for using Azure MFA as the primary authentication provider has never been simpler. The functionality is available in Windows Server 2016 Preview builds but is currently in Private Preview status  
  
With AD FS in Windows Server 2016, organizations can take advantage of Azure MFA without the need for an on premises Azure MFA server. Organizations can tconfigure the following:  
  
* With Azure MFA as the primary authentication method, the user is prompted for their username and the OTP code from the Azure Authenticator app.  
* With Azure MFA as the secondary or additional authentication method, the user provides primary authentication credentials (using Windows Integrated Authentication, username and password, smart card, or user or device certificate), then sees a prompt for text, voice, or OTP based Azure MFA login.  
* The built-in MFA experience is easy to install with Windows Server 2016  
* Azure MFA can be configured for intranet or extranet, or as part of any access control policy.  
  
  
  
### Improved device registration for delivering hybrid conditional access  
AD FS in Windows Server 2016 builds on our previous device registration capabilities to enable these scenarios. AD FS in Windows Server 2016 can consume the computer or device compliance status, so that you can apply the same policies to your on premises resources as you do for the cloud. Compliance is re-evaluated when device attributes change, so that you can always ensure policies are being enforced.  
  
![ADFS_ITPRO_1media/ADFS_ITPRO_1.png)  
  
Device authentication is the foundation for device-based conditional access scenarios. Device registration provides the device with an identity which is used to authenticate the device when the user signs in. The authenticated device, and the attributes of the device, can then be used to:  
* Enable Access only from devices that are managed and/or compliant  
* Restrict access to corporate ‘joined’ PC’s (including managed devices and domain joined PC’s)  
* Require multi-factor authentication for computers that are not domain joined and devices that are not compliant  
  
 For more information see   
*  [Get started with Azure Active Directory Device Registration](https://azure.microsoft.com/en-us/documentation/articles/active-directory-conditional-access-device-registration-overview/)  
* [Access Control Policies in AD FS](../../active-directory-federation-servic../../active-directory-federation-services/manage/ops/access-control-policies-ad-fs.md)  
  
### Deep Windows 10 and Microsoft Passport integration  
One of the benefits of Windows 10 devices is the convenience and security that comes with Windows Hello and Microsoft Passport for Work.  Microsoft Passport for Work replaces user passwords with strong device-bound user credentials protected by a user’s gesture (a PIN or a biometric gesture like fingerprint or facial recognition i.e. Windows Hello).    
  
This allows users to sign-in to applications on any device without having to send their corporate credentials.  These applications can be hosted in the cloud or on-premises.  
  
By integrating with Windows 10 and Microsoft Passport, AD FS can use the Microsoft Passport for Work to authenticate users whether they are federated or on-premises.  
  
  
  
###	Greater intergration with LDAP directories to secure non-AD directories  
In many organizations, identity management solutions consist of a combination of Active Directory, AD LDS, or third-party LDAP directories. With the addition of AD FS support for authenticating users stored in LDAP v3-compliant directories, you can benefit from the entire enterprise-grade AD FS feature set regardless of where your user identities are stored. AD FS supports any LDAP v3-compliant directory.   
  
For more information see [Configure AD FS to authenticate users stored in LDAP directories.](../../active-directory-federation-services/manage/ops/configure-ad-fs-authenticate-users-stored-ldap-directories.md)  
  
## Manageability and Operational Enhancements  
  
The following section describes the improved operational scenarios that are introduced with Active Directory Federation Services in Windows Server 2016.  
  
### Streamlined auditing for easier administrative management  
Currently, in AD FS for Windows Server 2012 R2 there are numerous audit events generated for a single request and the relevant information about a log-in or token issuance activity is either absent (in some versions of AD FS) or spread across multiple audit events. By default the AD FS audit events are turned off due to their verbose nature.  
With the release of AD FS in Windows Server 2016, auditing has become more streamlined and less verbose.  
  
For more information see [Auditing enhancemenet to AD FS in Windows Server 2016.](../../active-directory-federation-services/manage/ops/auditing-enhancements-ad-fs-windows-server-2016.md)  
  
### Improved interoperability with SAML 2.0 for participation in confederations  
AD FS in Windows Server 2016 contains additional SAML protocol support, including support for importing trusts based on metadata that contains multiple entities. This enables you to configure AD FS to participate in confederations such as InCommon Federation and other implementations conforming to the eGov 2.0 standard.  
  
For more information see [Improved interoperability with SAML 2.0.](../../active-directory-federation-services/manage/ops/improved-interoperability-with-saml-20.md)  
  
### Customize sign in experience for AD FS applications  
We heard from you that the ability to customize the logon experience for each application would be a great usability improvement, especially for organizations who provide sign on for applications that represent multiple different companies or brands.  
  
Previously, AD FS in Windows Server 2012 R2 provided a common sign on experience for all relying party applications, with the ability to customize a subset of text based content per application. With Windows Server 2016, you can customize not only the messages, but images, logo and web theme per application. Additionally, you can create new, custom web themes and apply these per relying party.  
  
 For more information see [AD FS user sign-in customization.](../../active-directory-federation-services/manage/ops/ad-fs-user-signin-customization.md)  
   
 ### Simplified password management for federated O365 users  
You can configure Active Directory Federation Services (AD FS) to send password expiry claims to the relying party trusts (applications) that are protected by AD FS. How these claims are used depends on the application. For example, with Office 365 as your relying party, updates have been implemented to Exchange and Outlook to notify federated users of their soon-to-be-expired passwords.  
  
For more information see [Configure AD FS to send password expiry claims.](../../active-directory-federation-services/manage/ops/configure-ad-fs-send-password-expiry-claims.md)  
  
### Configure access control policies without having to know claim rules language  
The AD FS core pipeline for policy processing has three phases: authentication, authorization and claim issuance.  
  
Previously, AD FS administrators had to configure a policy for each of these phases separately and to understand the AD FS claim rule language to enable simple, common policies.  
  
With access control policy templates, administrators can control when to grant conditional access, including enforcing multi-factor authentication, with a simple UI driven process.  
The new access control policy templates enable the following new scenarios and benefits:  
* Templates to simplify applying similar policies across multiple applications  
* Parameterized policies to support assigning different values for access control (e.g. Security Group)  
* Simpler UI with additional support for many new conditions  
* Conditional Predicates (Security groups, networks, device trust level, require mfa)  
  
For more information see [Access control policies in AD FS.](../../active-directory-federation-servic../../active-directory-federation-services/manage/ops/access-control-policies-ad-fs.md)  
  
### Moving from AD FS in Windows Server 2012 R2 to AD FS in Windows Server 2016 is easier  
Previously, migrating to a new version of AD FS required exporting configuration from the old farm and importing to a brand new, parallel farm.  
  
Now, moving from AD FS on Windows Server 2012 R2 to AD FS on Windows Server 2016 has become much easier. Simply add a new Windows Server 2016 server to a Windows Server 2012 R2 farm, and the farm will act at the Windows Server 2012 R2 farm behavior level, so it looks and behaves just like a Windows Server 2012 R2 farm.  
  
Then, add new Windows Server 2016 servers to the farm, verify the functionality and remove the older servers from the load balancer. Once all farm nodes are running Windows Server 2016, you are ready to upgrade the farm behavior level to 2016 and begin using the new features.  
  
For more information see [Upgrading to AD FS in Windows Server 2016.](../../active-directory-federation-services/get-started/upgrading-to-WS2016/upgrading-ad-fs-windows-server-2016.md)  

