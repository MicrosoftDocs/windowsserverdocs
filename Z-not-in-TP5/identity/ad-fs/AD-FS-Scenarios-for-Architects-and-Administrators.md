---
title: AD FS Scenarios for Architects and Administrators
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: ad-health-connect
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8ef33494-1186-4708-b274-5a7dd573d3fd
---
# AD FS Scenarios for Architects and Administrators

 
 ## Improved Security Scenarios
The following section describes the improved security scenarios that are introduced with Active Directory Federation Services in Windows Server 2016.  Security is a critical part of any organization and continuing to deliver improved security scenarios is one of the main areas of focus for AD FS. 

### Greater interoperability with Multi-factor Authentication

AD FS in Windows Server 2016 introduces and builds upon the multi\-factor authentication capabilities that were introduced with Windows Server 2012 R2.   By introducing a built\-in Azure MFA adapter, setup and configuration for using Azure MFA as the primary authentication provider has never been simpler.

Currently there are some limitations with using strong authentication with AD FS.  With AD FS in Windows Server 2016, these are addressed and organizations can take advantage of usuing Azure MFA with their AD FS implementation.  Organizations can take advantage of the following:

-   An AD FS farm can easily be configured to use multi\-factor authentication with Azure MFA without excessive configuration or additional infrastructure.

-   The built\-in MFA experience is easy to install with Windows Server 2016

-   Azure MFA can be configured as the primary authentication provider allowing for an alternative authentication mechanism for intranet or extranet.

For more information see [Configure AD FS and Azure MFA.](../ad-fs/manage/ops/Configure-AD-FS-2016-and-Azure-MFA.md)

### Improved device registration for delivering hybrid conditional access
The Device Registration service is the foundation for device-based conditional access scenarios. Whether it is Azure DRS or AD FS DRS, when a device is registered, the DRS provides the device with an identity which is used to authenticate the device when the user signs in. The authenticated device, and the attributes of the device, can then be used to:

* Enable Access only from devices that are managed and\/or compliant
* Restrict access to corporate ‘joined’ PC’s \(including managed devices and domain joined PC’s\)
* Require multi-factor authentication for computers that are not domain joined and devices that are not compliant
 
AD FS in Windows Server 2016 builds on our previous device registration capabilities to enable these scenarios.  AD FS in Windows Server 2016 can consume the computer or device compliance status, so that you can apply the same policies to your on premises resources as you do for the cloud.  Compliance is re\-evaluated when device attributes change, so that you can always ensure policies are being enforced.

![ADFS_ITPRO_1media/ADFS_ITPRO_1.png)

 For more information see 
*  [Get started with Azure Active Directory Device Registration](https://azure.microsoft.com/en-us/documentation/articles/active-directory-conditional-access-device-registration-overview/)
* [Using registerd devices for conditional access on-premises](Using-registered-devices-for-Conditional-Access-on-premises.md)
* [Access Control Policies in AD FS](../ad-fs/manage/ops/../ad-fs/manage/ops/Access-Control-Policies-in-AD-FS.md)

### Providing Authentication for Azure RemoteApps
Azure RemoteApp brings the functionality of the on-premises Microsoft RemoteApp program, backed by Remote Desktop Services, to Azure. With Azure RemoteApp you can share apps and resources with users on almost any device.  AD FS in Windows Server 2016 provides the authentication method to securely enable this scenario.

This is accomplished by providing the ability for a client to objtain a certificate that can be used to login a user interactively.  AD FS does this by running in one of two modes:

-	**Self-signed certificates issued by AD FS** – this mode is suitable for smaller customers who do not have an enterprise PKI infrastructure. For such customers, AD FS will offer a simpler deployment model where certificates used to logon users are issued by AD FS. However, in order for these certificates to be used for interactive logon, administrators will need to configure their KDC to trust AD FS as an issuer CA.

-	**Certificates issued by enterprise CA** – this mode is suitable for customers who have an enterprise PKI deployed and will prefer that their CA issue certificates used to logon users interactively.

For more information see [Configure AD FS as a certificate issuing authority.](../ad-fs/Configure-AD-FS-as-a-certificate-issuing-authority.md)

### Deep Windows 10 and Microsoft Passport integration
One of the benefits of Windows 10 devices is the convenience and security that comes with Windows Hello and Microsoft Passport for Work.  Microsoft Passport for Work replaces user passwords with strong device-bound user credentials protected by a user’s gesture (a PIN or a biometric gesture like fingerprint or facial recognition i.e. Windows Hello).  

This allows users to sign-in to applications on any device without having to send their corporate credentials.  These applications can be hosted in the cloud or on-premises.

By integrating with Windows 10 and Microsoft Passport, AD FS can use the Microsoft Passport for Work to authenticate users whether they are federated or on-premises.

For more information see [AD FS and Microsoft Passport for Work in Windows 10 on-premises](../ad-fs/AD-FS-and-Microsoft-Passport-for-Work-in-Windows-10-on-premises.md)


###	Greater intergration with LDAP directories to secure non-AD directories
In many organizations, identity management solutions consist of a combination of Active Directory, AD LDS, or third-party LDAP directories. With the addition of AD FS support for authenticating users stored in LDAP v3-compliant directories, you can benefit from the entire enterprise-grade AD FS feature set regardless of where your user identities are stored. AD FS supports any LDAP v3-compliant directory. 

For more information see [Configure AD FS to authenticate users stored in LDAP directories.](../ad-fs/manage/ops/Configure-AD-FS-to-authenticate-users-stored-in-LDAP-directories.md)

## Scenarios around Operational Enhancements
The following section describes the improved operational scenarios that are introduced with Active Directory Federation Services in Windows Server 2016.
	
###	Streamlined auditing for easier administrative management
Currently, in AD FS for Windows Server 2012 R2 there are numerous audit events generated for a single request and the relevant information about a log-in or token issuance activity is either absent (in some versions of AD FS) or spread across multiple audit events. By default the AD FS audit events are turned off due to their verbose nature.
With the release of AD FS in Windows Server 2016, auditing has become more streamlined and less verbose.

For more information see [Auditing enhancemenet to AD FS in Windows Server 2016.](../ad-fs/manage/ops/Auditing-Enhancements-to-AD-FS-in-Windows-Server-2016.md)
	
###	Improved interoperablity with SAML 2.0 for particpation in confederations
AD FS in Windows Server 2016 contains additional SAML protocol support, including support for importing trusts based on metadata that contains multiple entities. This enables you to configure AD FS to participate in confederations such as InCommon Federation and other implementations conforming to the eGov 2.0 standard.

For more information see [AD FS and the eGov 2.0 Standard.](AD-FS-and-the-eGov-2.0-Standard.md)
###	Enhanced web customization on a per RP basis

In response to feedback from organizations using AD FS, we have added additional tools to customize the user sign in experience for individual applications protected by AD FS.
 In addition to specifying per-application web content such as description text and links, now you can specify entire web themes per application. This includes logo, illustration, style sheets, or an entire onload.js file
 
 For more information see [AD FS Web UX Customization.](AD-FS-Web-UX-Customization.md)

###	Simplified password management for federated O365 users
You can configure Active Directory Federation Services (AD FS) to send password expiry claims to the relying party trusts (applications) that are protected by AD FS. How these claims are used depends on the application. For example, with Office 365 as your relying party, updates have been implemented to Exchange and Outlook to notify federated users of their soon-to-be-expired passwords.

For more information see [Configure AD FS to send password expiry claims.](../ad-fs/manage/ops/Configure-AD-FS-to-Send-Password-Expiry-Claims.md)
###	Easier configuration and deployment of common policies for issuance authorization rules
The AD FS core pipeline for policy processing has three phases: authentication, authorization and claim issuance. 
Currently, AD FS administrators have to configure a policy for each of these phases separately. This also involves understanding the implications of these policies and if these policies have inter-dependency. Also, administrators have to understand the claim rule language and author custom rules to enable some simple/common policy 

What access control policy templates do is replace this old model where administrators have to configure Issuance Authorization Rules using claims language. The new model allows administrators to control when to grant access, including enforcing multi-factor authentication.

For more information see [Access control policies in AD FS.](../ad-fs/manage/ops/../ad-fs/manage/ops/Access-Control-Policies-in-AD-FS.md)
###	Simplified upgrading that offers a staged approach
New in AD FS for Windows Server 2016 is the farm behavior level feature (FBL). This features is farm wide and determines the features that the AD FS farm can use. By default, the FBL in a Windows Server 2012 R2 AD FS farm is at the Windows Server 2012 R2 FBL.

A Windows Server 2016 AD FS server can be added to a Windows Server 2012 R2 farm and it will operate at the same FBL as a Windows Server 2012 R2. When you are ready to take advantage of the AD FS 2016 features you can simply raise the FBL for your farm to 2016.

For more information see [Upgrading to AD FS in Windows Server 2016.](../ad-fs/get-started/upgrading-to-WS2016/Upgrading-to-AD-FS-in-Windows-Server-2016.md)





