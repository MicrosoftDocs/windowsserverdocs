---
ms.assetid: c5eb3fa0-550c-4a2f-a0bc-698b690c4199
title: Plan Device-based Conditional Access on-Premises
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---
# Plan Device-based Conditional Access on-Premises


This document describes conditional access policies based on devices in a hybrid scenario where the on-premises directories are connected to Azure AD using Azure AD Connect.     

## AD FS and Hybrid conditional access  

AD FS provides the on premises component of conditional access policies in a hybrid scenario.  When you register devices with Azure AD for conditional access to cloud resources, the Azure AD Connect device write back capability makes device registration information available on premises for AD FS policies to consume and enforce.  This way, you have a consistent approach to access control policies for both on premises and cloud resources.  

![conditional access](media/Plan-Device-based-Conditional-Access-on-Premises/ADFS_ITPRO4.png)  

### Types of registered devices  
There are three kinds of registered devices, all of which are represented as Device objects in Azure AD and can be used for conditional access with AD FS on premises as well.  

| |Add Work or School Account  |Azure AD Join  |Windows 10 Domain Join    
| --- | --- |--- | --- |
|Description    |  Users add their work or school account to their BYOD device interactively.  **Note:** Add Work or School Account is the replacement for Workplace Join in Windows 8/8.1       | Users join their Windows 10 work device to Azure AD.|Windows 10 domain joined devices automatically register with Azure AD.|           
|How users log in to the device     |  No login to Windows as the work or school account.  Login using a Microsoft account.       |   Login to Windows as the (work or school) account that registered the device.      |     Login using AD account.|      
|How devices are managed    |      MDM Policies (with additional Intune enrollment)   | MDM Policies (with additional Intune enrollment)        |   Group Policy, Configuration Manager |
|Azure AD Trust type|Workplace joined|Azure AD joined|Domain joined  |     
|W10 Settings location    | Settings > Accounts > Your account > Add a work or school account        | Settings > System > About > Join Azure AD       |   Settings > System > About > Join a domain |       
|Also available for iOS and Android Devices?   |    Yes     |       No  |   No   |   

  

For more information on the different ways to register devices, see also:  
* [Using Windows 10 devices in your workplace](https://azure.microsoft.com/documentation/articles/active-directory-azureadjoin-windows10-devices/)  
* [Setting up Windows 10 devices for work](https://jairocadena.com/2016/01/18/setting-up-windows-10-devices-for-work-domain-join-azure-ad-join-and-add-work-or-school-account/)  
[Join Windows 10 Mobile to Azure Active Directory](https://technet.microsoft.com/itpro/windows/manage/join-windows-10-mobile-to-azure-active-directory)  

### How Windows 10 User and Device Sign on is different from previous versions  
For Windows 10 and AD FS 2016 there are some new aspects of device registration and authentication you should know about (especially if you are very familiar with device registration and "workplace join" in previous releases).  

First, in Windows 10 and AD FS in Windows Server 2016, device registration and authentication is no longer based solely on an X509 user certificate.  There is a new and more robust protocol that provides better security and a more seamless user experience.  The key differences are that, for Windows 10 Domain Join and Azure AD Join, there is an X509 computer certificate and a new credential called a PRT.  You can read all about it [here](https://jairocadena.com/2016/01/18/how-domain-join-is-different-in-windows-10-with-azure-ad/) and [here](https://jairocadena.com/2016/02/01/azure-ad-join-what-happens-behind-the-scenes/).  

Second, Windows 10 and AD FS 2016 support user authentication using Microsoft Passport for Work, which you can read about [here](https://jairocadena.com/2016/03/09/azure-ad-and-microsoft-passport-for-work-in-windows-10/) and [here](https://azure.microsoft.com/documentation/articles/active-directory-azureadjoin-passport-deployment/).  

AD FS 2016 provides seamless device and user SSO based on both PRT and Passport credentials.  Using the steps in this document, you can enable these capabilities and see them work.  

### Device Access Control Policies  
Devices can be used in simple AD FS access control rules such as:  

- allow access only from a registered device   
- require multi factor authentication when a device is not registered  

These rules can then be combined with other factors such as network access location and multi factor authentication, creating rich conditional access policies such as:  


- require multi factor authentication for unregistered devices accessing from outside the corporate network, except for members of a particular group or groups  

With AD FS 2016, these policies can be configured specifically to require a particular device trust level as well: either **authenticated**, **managed**, or **compliant**.  

For more information on configuring AD FS access control policies, see [Access control policies in AD FS](../../ad-fs/operations/Access-Control-Policies-in-AD-FS.md).  

#### Authenticated devices  
Authenticated devices are registered devices that are not enrolled in MDM (Intune and 3rd party MDMs for Windows 10, Intune only for iOS and Android).   

Authenticated devices will have the **isManaged** AD FS claim with value **FALSE**. (Whereas devices that are not registered at all will lack this claim.)  Authenticated devices (and all registered devices) will have the isKnown AD FS claim with value **TRUE**.  

#### Managed Devices:   

Managed devices are registered devices that are enrolled with MDM.  

Managed devices will have the isManaged AD FS claim with value **TRUE**.  

#### Devices compliant (with MDM or Group Policies)  
Compliant devices are registered devices that are not only enrolled with MDM but compliant with the MDM policies. (Compliance information originates with the MDM and is written to Azure AD.)  

Compliant devices will have the **isCompliant** AD FS claim with value **TRUE**.    

For complete list of AD FS 2016 device and conditional access claims, see [Reference](#reference).  


## Reference  
#### Complete list of new AD FS 2016 and device claims  

* https://schemas.microsoft.com/ws/2014/01/identity/claims/anchorclaimtype  
* http://schemas.xmlsoap.org/ws/2005/05/identity/claims/implicitupn  
* https://schemas.microsoft.com/2014/03/psso  
* https://schemas.microsoft.com/2015/09/prt  
* http://schemas.xmlsoap.org/ws/2005/05/identity/claims/upn  
* https://schemas.microsoft.com/ws/2008/06/identity/claims/primarygroupsid  
* https://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid  
* http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name  
* https://schemas.microsoft.com/ws/2008/06/identity/claims/windowsaccountname  
* https://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid  
* https://schemas.microsoft.com/2012/01/devicecontext/claims/registrationid  
* https://schemas.microsoft.com/2012/01/devicecontext/claims/displayname  
* https://schemas.microsoft.com/2012/01/devicecontext/claims/identifier  
* https://schemas.microsoft.com/2012/01/devicecontext/claims/ostype  
* https://schemas.microsoft.com/2012/01/devicecontext/claims/osversion  
* https://schemas.microsoft.com/2012/01/devicecontext/claims/ismanaged  
* https://schemas.microsoft.com/2012/01/devicecontext/claims/isregistereduser  
* https://schemas.microsoft.com/2014/02/devicecontext/claims/isknown  
* https://schemas.microsoft.com/2014/02/deviceusagetime  
* https://schemas.microsoft.com/2014/09/devicecontext/claims/iscompliant  
* https://schemas.microsoft.com/2014/09/devicecontext/claims/trusttype  
* https://schemas.microsoft.com/claims/authnmethodsreferences  
* https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-client-user-agent  
* https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-endpoint-absolute-path  
* https://schemas.microsoft.com/ws/2012/01/insidecorporatenetwork  
* https://schemas.microsoft.com/2012/01/requestcontext/claims/client-request-id  
* https://schemas.microsoft.com/2012/01/requestcontext/claims/relyingpartytrustid  
* https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-client-ip  
* https://schemas.microsoft.com/2014/09/requestcontext/claims/userip  
* https://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod  
