---
ms.assetid: aa892a85-f95a-4bf1-acbb-e3c36ef02b0d
title: What's new in Active Directory Federation Services for Windows Server 2016
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 09/08/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---
# What's new in Active Directory Federation Services for Windows Server 2016

>Applies To: Windows Server 2016

## What's new in Active Directory Federation Services for Windows Server 2016   
If you are looking for information on earlier versions of AD FS, see the following articles:  
 [ADFS in Windows Server 2012 or 2012 R2](https://technet.microsoft.com/library/hh831502.aspx) and [AD FS 2.0](https://technet.microsoft.com/library/adfs2.aspx)  

 Active Directory Federation Services provides access control and single sign on across a wide variety of applications including Office 365, cloud based SaaS applications, and applications on the corporate network.  
* For the IT organization, it enables you to provide sign on and access control to both modern and legacy applications, on premises and in the cloud, based on the same set of credentials and policies.    
* For the user, it provides seamless sign on using the same, familiar account credentials.  
* For the developer, it provides an easy way to authenticate users whose identities live in the organizational directory so that you can focus your efforts on your application, not authentication or identity.  

This article describes what is new in AD FS in Windows Server 2016 (AD FS 2016).  

## Eliminate Passwords from the Extranet  
AD FS 2016 enables three new options for sign on without passwords, enabling organizations to avoid risk of network compromise from phished, leaked or stolen passwords. 

### Sign in with Azure Multi-factor Authentication
AD FS 2016 builds upon the multi-factor authentication (MFA) capabilities of AD FS in Windows Server 2012 R2 by allowing sign on using only an Azure MFA code, without first entering a username and password.

* With Azure MFA as the primary authentication method, the user is prompted for their username and the OTP code from the Azure Authenticator app.  
* With Azure MFA as the secondary or additional authentication method, the user provides primary authentication credentials (using Windows Integrated Authentication, username and password, smart card, or user or device certificate), then sees a prompt for text, voice, or OTP based Azure MFA login.  
* With the new built-in Azure MFA adapter, setup and configuration for Azure MFA with AD FS has never been simpler.
* Organizations can take advantage of Azure MFA without the need for an on premises Azure MFA server.
* Azure MFA can be configured for intranet or extranet, or as part of any access control policy.

For more information about Azure MFA with AD FS
*  [Configure AD FS 2016 and Azure MFA](https://docs.microsoft.com/azure/multi-factor-authentication/multi-factor-authentication-get-started-adfs)  

### Password-less Access from Compliant Devices
AD FS 2016 builds on previous device registration capabilities to enable sign on and access control based the device compliance status. Users can sign on using the device credential, and compliance is re-evaluated when device attributes change, so that you can always ensure policies are being enforced.  This enables policies such as

* Enable Access only from devices that are managed and/or compliant  
* Enable Extranet Access only from devices that are managed and/or compliant  
* Require multi-factor authentication for computers that are not managed or not compliant  

AD FS provides the on premises component of conditional access policies in a hybrid scenario. When you register devices with Azure AD for conditional access to cloud resources, the device identity can be used for AD FS policies as well.

![whats new](media/whats-new-in-active-directory-federation-services-for-windows-server-2016/ADFS_ITPRO4.png)  

 For more information about using device based conditional access in the cloud   
 *  [Azure Active Directory Conditional Access](https://azure.microsoft.com/en-us/documentation/articles/active-directory-conditional-access/)

For more information about using device based conditional access with AD FS
*  [Planning for Device Based Conditional Access with AD FS](../../ad-fs/deployment/Plan-Device-based-Conditional-Access-on-Premises.md)  
* [Access Control Policies in AD FS](../../ad-fs/operations/Access-Control-Policies-in-AD-FS.md)  

### Sign in with Windows Hello for Business   
Windows 10 devices introduce Windows Hello and Windows Hello for Business, replacing user passwords with strong device-bound user credentials protected by a user's gesture (a PIN, a biometric gesture like fingerprint, or facial recognition). AD FS 2016 supports these new these new Windows 10 capabilities so that users can sign in to AD FS applications from the intranet or the extranet without the need to provide a password.

For more information about using Microsoft Windows Hello for Business in your organization
*  [Enable Windows Hello for Business in your organization](https://azure.microsoft.com/en-us/documentation/articles/active-directory-azureadjoin-passport-deployment/)

## Secure Access to Applications

### Modern Authentication
AD FS 2016 supports the latest modern protocols that provide a better user experience for Windows 10 as well as the latest iOS and Android devices and apps.  

For more information see [AD FS Scenarios for Developers](../../ad-fs/overview/AD-FS-Scenarios-for-Developers.md)  


### Configure access control policies without having to know claim rules language  
Previously, AD FS administrators had to configure policies using the AD FS claim rule language, making it difficult to configure and maintain policies. With access control policies, administrators can use built in templates to apply common policies such as
* Permit intranet access only
* Permit everyone and require MFA from Extranet
* Permit everyone and require MFA from a specific group

The templates are easy to customize using a wizard driven process to add exceptions or additional policy rules and can be applied to one or many applications for consistent policy enforcement.

For more information see [Access control policies in AD FS.](../../ad-fs/operations/Access-Control-Policies-in-AD-FS.md)  

### Enable sign on with non-AD LDAP directories  
Many organizations have a combination of Active Directory and third-party directories. With the addition of AD FS support for authenticating users stored in LDAP v3-compliant directories, AD FS can now be used for:
* Users in third party, LDAP v3 compliant directories
* Users in Active Directory forests to which an Active Directory two-way trust is not configured
* Users in Active Directory Lightweight Directory Services (AD LDS)

For more information see [Configure AD FS to authenticate users stored in LDAP directories.](../../ad-fs/operations/Configure-AD-FS-to-authenticate-users-stored-in-LDAP-directories.md)  

## Better Sign in experience
### Customize sign in experience for AD FS applications  
We heard from you that the ability to customize the logon experience for each application would be a great usability improvement, especially for organizations who provide sign on for applications that represent multiple different companies or brands.  

Previously, AD FS in Windows Server 2012 R2 provided a common sign on experience for all relying party applications, with the ability to customize a subset of text based content per application. With Windows Server 2016, you can customize not only the messages, but images, logo and web theme per application. Additionally, you can create new, custom web themes and apply these per relying party.  

For more information see [AD FS user sign-in customization.](../../ad-fs/operations/AD-FS-user-sign-in-customization.md)  



## Manageability and Operational Enhancements  
The following section describes the improved operational scenarios that are introduced with Active Directory Federation Services in Windows Server 2016.  

### Streamlined auditing for easier administrative management  
In AD FS for Windows Server 2012 R2 there were numerous audit events generated for a single request and the relevant information about a log-in or token issuance activity is either absent (in some versions of AD FS) or spread across multiple audit events. By default the AD FS audit events are turned off due to their verbose nature.  
With the release of AD FS 2016, auditing has become more streamlined and less verbose.  

For more information see [Auditing enhancements to AD FS in Windows Server 2016.](../../ad-fs/technical-reference/auditing-enhancements-to-ad-fs-in-windows-server.md)  

### Improved interoperability with SAML 2.0 for participation in confederations  
AD FS 2016 contains additional SAML protocol support, including support for importing trusts based on metadata that contains multiple entities. This enables you to configure AD FS to participate in confederations such as InCommon Federation and other implementations conforming to the eGov 2.0 standard.  

For more information see [Improved interoperability with SAML 2.0.](../../ad-fs/operations/Improved-interoperability-with-SAML-2.0.md)  

### Simplified password management for federated O365 users  
You can configure Active Directory Federation Services (AD FS) to send password expiry claims to the relying party trusts (applications) that are protected by AD FS. How these claims are used depends on the application. For example, with Office 365 as your relying party, updates have been implemented to Exchange and Outlook to notify federated users of their soon-to-be-expired passwords.  

For more information see [Configure AD FS to send password expiry claims.](../../ad-fs/operations/Configure-AD-FS-to-Send-Password-Expiry-Claims.md)  

### Moving from AD FS in Windows Server 2012 R2 to AD FS in Windows Server 2016 is easier  
Previously, migrating to a new version of AD FS required exporting configuration from the old farm and importing to a brand new, parallel farm.  

Now, moving from AD FS on Windows Server 2012 R2 to AD FS on Windows Server 2016 has become much easier. Simply add a new Windows Server 2016 server to a Windows Server 2012 R2 farm, and the farm will act at the Windows Server 2012 R2 farm behavior level, so it looks and behaves just like a Windows Server 2012 R2 farm.  

Then, add new Windows Server 2016 servers to the farm, verify the functionality and remove the older servers from the load balancer. Once all farm nodes are running Windows Server 2016, you are ready to upgrade the farm behavior level to 2016 and begin using the new features.  

For more information see [Upgrading to AD FS in Windows Server 2016.](../../ad-fs/deployment/Upgrading-to-AD-FS-in-Windows-Server-2016.md)  
