---
ms.assetid: c81b8291-fba5-4b30-a43d-7feb2f4b66be
title: AD FS Design Guide in Windows Server 2012 R2
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Identify Your AD FS Deployment Goals

Correctly identifying your Active Directory Federation Services \(AD FS\) deployment goals is essential for the success of your AD FS design project. Prioritize and, possibly, combine your deployment goals so that you can design and deploy AD FS by using an iterative approach. You can take advantage of existing, documented, and predefined AD FS deployment goals that are relevant to the AD FS designs and develop a working solution for your situation.  
  
Prior versions of AD FS were most commonly deployed to achieve the following:  
  
-   Providing your employees or customers with a web\-based, SSO experience when accessing claims\-based applications within your enterprise.  
  
-   Providing your employees or customers with a web\-based, SSO experience to access resources in any federation partner organization.  
  
-   Providing your employees or customers with a Web\-based, SSO experience when remote accessing internally hosted Web sites or services.  
  
-   Providing your employees or customers with a web\-based, SSO experience when accessing resources or services in the cloud.  
  
In addition to these, AD FS in Windows Server® 2012 R2 adds functionality that can help you achieve the following:  
  
-   Device workplace join for SSO and seamless second factor authentication. This enables organizations to allow access from user's personal devices and manage the risk when providing this access.  
  
-   Managing risk with multi\-factor access control. AD FS provides a rich level of authorization that controls who has access to what applications. This can be based on user attributes \(UPN, email, security group membership, authentication strength, etc.\), device attributes \(whether the device is workplace joined\) or request attributes \(network location, IP address, or user agent\).  
  
-   Managing risk with additional multi\-factor authentication for sensitive applications. AD FS allows you to control policies to potentially require multi\-factor authentication globally or on a per application basis. In addition, AD FS provides extensibility points for any multi\-factor vendor to integrate deeply for a secure and seamless multi\-factor experience for end users.  
  
-   Providing authentication and authorization capabilities for accessing web resources from the extranet that are protected by the Web Application Proxy.  
  
To summarize, AD FS in Windows Server 2012 R2 can be deployed to achieve the following goals in your organization:  
  
### Enable your users to access resources on their personal devices from anywhere  
  
-   Workplace join that enables users to join their personal devices to corporate Active Directory and as a result gain access and seamless experiences when accessing corporate resources from these devices.  
  
-   Pre\-authentication of resources inside the corporate network that are protected by the Web Application proxy and accessed from the internet.  
  
-   Password change to enable users to change their password from any workplace joined device when their password has expired so that they can continue to access resources.  
  
### Enhance your access control risk management tools  
Managing risk is an important aspect of governance and compliance in every IT organization. There are numerous access control risk management enhancements in AD FS in Windows Server® 2012 R2, including the following:  
  
-   Flexible controls based on network location to govern how a user authenticates to access an AD FS\-secured application.  
  
-   Flexible policy to determine if a user needs to perform multi\-factor authentication based on the user's data, device data, and network location.  
  
-   Per\-application control to ignore SSO and force the user to provide credentials every time they access a sensitive application.  
  
-   Flexible per\-application access policy based on user data, device data, or network location.  
  
-   AD FS Extranet Lockout, which enables administrators to protect Active Directory accounts from brute force attacks from the internet.  
  
-   Access revocation for any workplace joined device that is disabled or deleted in Active Directory.  
  
### Use AD FS to enhance the sign\-in experience  
The following are new AD FS capabilities in Windows Server® 2012 R2 that enable administrator to customize and enhance the sign\-in experience:  
  
-   Unified customization of the AD FS service, where the changes are made once and then automatically propagated to the rest of the AD FS federation servers in a given farm.  
  
-   Updated sign\-in pages that look modern and cater to different form factors automatically.  
  
-   Support for automatic fallback to forms\-based authentication for devices that are not joined to the corporate domain but are still used generate access requests from within the corporate network \(intranet\).  
  
-   Simple controls to customize the company logo, illustration image, standard links for IT support, home page, privacy, etc.  
  
-   Customization of description messages in the sign\-in pages.  
  
-   Customization of web themes.  
  
-   Home Realm Discovery \(HRD\) based on organizational suffix of the user for enhanced privacy of a company's partners.  
  
-   HRD filtering on a per\-application basis to automatically pick a realm based on the application.  
  
-   One\-click error reporting for easier IT troubleshooting.  
  
-   Customizable error messages.  
  
-   User authentication choice when more than one authentication provider is available.  
  
## See Also  
[AD FS Design Guide in Windows Server 2012 R2](../../ad-fs/design/AD-FS-Design-Guide-in-Windows-Server-2012-R2.md)  
  

